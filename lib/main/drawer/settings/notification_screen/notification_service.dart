import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  late AndroidNotificationChannel _channel;
  int nextNotificationId = 1000;

  // Inicjalizacja systemu powiadomień (initializes notification system)
  Future<void> initNotification() async {
    print('[NotificationService] Initializing notifications...');

    _channel = const AndroidNotificationChannel(
      'default_channel',
      'Your Notifications',
      description: 'Your notifications',
      importance: Importance.high,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_notification');

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload != null) {
          final type = payload.split(':').last;

          switch (type) {
            case 'training':
              navigatorKey.currentState?.pushNamed('/training');
              break;
            case 'weight':
              navigatorKey.currentState?.pushNamed('/weight');
              break;
            case 'measurement':
              navigatorKey.currentState?.pushNamed('/measurements');
              break;
            default:
          }
        }
      },

    );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    tz.initializeTimeZones();
    print('[NotificationService] Initialization complete.');
  }

  NotificationDetails notificationDetails({required String? body}) {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: _channel.importance,
      priority: Priority.high,
      icon: 'ic_notification',
      styleInformation: BigTextStyleInformation(body ?? ''),
    );

    const iOSDetails = DarwinNotificationDetails();

    return NotificationDetails(android: androidDetails, iOS: iOSDetails);
  }

// Wysyła natychmiastowe powiadomienie z podanym tytułem i treścią (sends an instant notification with provided title and body)
  Future<void> sendInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await notificationsPlugin.show(
      0,
      title,
      body,
      payload: payload,  // <-- tutaj przekazujemy
      notificationDetails(body: body),
    );
  }

  // Harmonogramuje codzienne powiadomienie o określonej godzinie (schedules daily notification at specified time)
  Future<void> scheduleDailyNotification({
    int? id,
    required String title,
    required String body,
    String? payload,
    required DateTime time,
  }) async {
    final scheduledTime = _nextInstanceOfTime(time);
    final usedId = id ?? nextNotificationId++;

    print('[NotificationService] Scheduling daily notification: $scheduledTime');

    await notificationsPlugin.zonedSchedule(
      usedId,
      title,
      body,
      scheduledTime,
      notificationDetails(body: body),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Harmonogramuje jednorazowe powiadomienie na konkretną datę i godzinę (schedules a one-time notification)
  Future<void> scheduleOneTimeNotification({
    int? id,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    String? payload,
  }) async {
    final usedId = id ?? nextNotificationId++;
    final scheduledTime = tz.TZDateTime.from(scheduledDateTime, tz.local);

    print('[NotificationService] Scheduling one-time notification: $scheduledTime');

    await notificationsPlugin.zonedSchedule(
      usedId,
      title,
      body,
      scheduledTime,
      notificationDetails(body: body),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: null,
    );
  }

  Future<void> scheduleWeeklyNotifications({
    int? id,
    required String title,
    required String body,
    required String? payload,
    required DateTime time,
    required List<bool> weekdays, // 7-elementowa lista booli: [Mon, Tue, ..., Sun]
  }) async {
    for (int i = 0; i < weekdays.length; i++) {
      if (weekdays[i]) {
        // i: 0 = Monday, ..., 6 = Sunday
        final notificationId = id! * 10 + i;

        final now = tz.TZDateTime.now(tz.local);
        final nextDayTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
        final scheduledTime = _nextInstanceOfWeekday(i + 1, nextDayTime); // i+1 because DateTime.monday = 1

        print('[NotificationService] Scheduling weekly notification for weekday $i at $scheduledTime');

        await notificationsPlugin.zonedSchedule(
          notificationId,
          title,
          body,
          scheduledTime,
          notificationDetails(body: body),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: payload,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }

// Zwraca kolejne wystąpienie konkretnego dnia tygodnia o podanej godzinie
  tz.TZDateTime _nextInstanceOfWeekday(int weekday, DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);

    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  // Anuluje zaplanowane powiadomienie o danym ID (cancels scheduled notification by ID)
  Future<void> cancelScheduledNotification(int id) async {
    await notificationsPlugin.cancel(id);
    print("🗑️ Canceled notification ID $id");
  }

  Future<void> cancelWeeklyNotificationGroup(int baseId) async {
    for (int i = 0; i < 7; i++) {
      await notificationsPlugin.cancel(baseId * 10 + i);
      print("🗑️ Canceled notification ID $baseId");
    }
  }

  // Usuwa wszystkie zaplanowane i wyświetlone powiadomienia (cancels all notifications)
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
    print("🗑️ All notifications canceled");
  }

  // Zwraca czas następnego wystąpienia podanej godziny (returns next instance of the specified time)
  Future<tz.TZDateTime> getNextDailyTime(DateTime time) async {
    return _nextInstanceOfTime(time);
  }

  // Oblicza najbliższą przyszłą datę wystąpienia godziny (calculates the next occurrence of a time today or tomorrow)
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

    return scheduledDate;
  }

  Future<bool> checkAndRequestPermissions() async {
    final result = await notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();

    if (result == false) {
      return false;
    }

    final iosDetails = await notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    final macosDetails = await notificationsPlugin
        .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return iosDetails == true || macosDetails == true || result == true;
  }

  Future<void> showTrainingOngoingNotification() async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true, // nie da się przesunąć żeby usunąć
      showWhen: false,
      icon: 'ic_notification',
    );

    const iOSDetails = DarwinNotificationDetails();

    final details = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await notificationsPlugin.show(
      2000, // stałe ID dla treningu
      'Training in progress',
      'Your workout is running...',
      details,
    );
  }

  Future<void> cancelTrainingOngoingNotification() async {
    await notificationsPlugin.cancel(2000);
  }
}
