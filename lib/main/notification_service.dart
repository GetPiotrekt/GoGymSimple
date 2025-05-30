import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    print('[NotificationService] Initializing notifications...');
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        print('[NotificationService] Received local notification on iOS');
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        print(
            '[NotificationService] Notification tapped: ${notificationResponse.payload}');
      },
    );
    print('[NotificationService] Initialization complete.');
  }

  NotificationDetails notificationDetails({required String? body}) {
    print('[NotificationService] Building notification details...');
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'weekly_channel',
      'Weekly Notifications',
      channelDescription: 'Weekly scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(body ?? ''),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    return NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  /// Codzienne powiadomienia

  Future<void> scheduleDailyNotification({
    int id = 0,
    required String title,
    required String body,
    String? payload,
    required DateTime time,
  }) async {
    final nextTime = _nextInstanceOfTime(time);
    print('[NotificationService] Scheduling daily notification:');
    print('  - id: $id');
    print('  - title: $title');
    print('  - body: $body');
    print('  - next time: $nextTime');

    await notificationsPlugin.zonedSchedule(
      id * 1000,
      title,
      body,
      nextTime,
      notificationDetails(body: body),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print('[NotificationService] _nextInstanceOfTime: $scheduledDate');
    return scheduledDate;
  }

  /// Powiadomienia co N dni

  Future<List<int>> scheduleNotificationsEveryNDays({
    required int startId,
    required String title,
    required String body,
    required DateTime startTime,
    required int intervalInDays,
    int count = 100,
  }) async {
    List<Future<void>> futures = [];
    List<int> scheduledIds = [];

    for (int i = 0; i < count; i++) {
      final id = startId + i;
      final baseTime = startTime.add(Duration(days: intervalInDays * i));

      final scheduledTime = tz.TZDateTime.local(
        baseTime.year,
        baseTime.month,
        baseTime.day,
        baseTime.hour,
        baseTime.minute,
      );

      if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
        print("⏭️ Pomijam $scheduledTime, bo jest w przeszłości");
        continue;
      }

      print("📅 Planuję powiadomienie ID $id na $scheduledTime");

      futures.add(
        notificationsPlugin
            .zonedSchedule(
          id,
          title,
          body,
          scheduledTime,
          notificationDetails(body: body),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: null,
        )
            .then((_) => scheduledIds.add(id))
            .catchError((e) => print("❌ Błąd przy planowaniu ID $id: $e")),
      );
    }

    await Future.wait(futures);
    return scheduledIds;
  }


  tz.TZDateTime _nextInstanceInNDays(DateTime startTime, int intervalInDays) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
      startTime.second,
    );

    while (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: intervalInDays));
    }

    print('[NotificationService] _nextInstanceInNDays: $scheduledDate');
    return scheduledDate;
  }

  // Właściwa metoda do planowania na konkretne dni tygodnia
  Future<List<int>> scheduleWeeklyNotificationsOnDays({
    required int startId,
    required String title,
    required String body,
    required DateTime time,
    required List<Day> daysOfWeek,
  }) async {
    List<int> scheduledIds = [];
    int created = 0;
    int dayOffset = 0;

    while (created < 100) {
      final date = DateTime.now().add(Duration(days: dayOffset));
      final weekday = Day.values[date.weekday % 7]; // Poniedziałek=1, Sunday=7 → Day.values[0–6]

      if (daysOfWeek.contains(weekday)) {
        final scheduledTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        final id = startId + created;

        print("📅 Planuję powiadomienie ID $id na $scheduledTime (dzień: $weekday)");

        try {
          await notificationsPlugin.zonedSchedule(
            id,
            title,
            body,
            tz.TZDateTime.from(scheduledTime, tz.local),
            notificationDetails(body: body),
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: null,
          );
          scheduledIds.add(id);
          created++;
        } catch (e) {
          print("❌ Błąd przy planowaniu ID $id: $e");
        }
      }

      dayOffset++; // Przechodzimy do kolejnego dnia
    }

    return scheduledIds;
  }

  Future<tz.TZDateTime> getNextDailyTime(DateTime time) async {
    print("[NotificationService] Obliczanie następnego powiadomienia codziennego...");
    return _nextInstanceOfTime(time);
  }

  Future<tz.TZDateTime> getNextInNDays(DateTime startTime, int intervalInDays) async {
    print("[NotificationService] Obliczanie następnego powiadomienia co $intervalInDays dni...");
    return _nextInstanceInNDays(startTime, intervalInDays);
  }

  Future<void> cancelScheduledNotifications({required int startId, required int count}) async {
    for (int i = 0; i < count; i++) {
      final id = startId + i;
      await notificationsPlugin.cancel(id);
      print("🗑️ Usunięto powiadomienie ID $id");
    }
  }
}