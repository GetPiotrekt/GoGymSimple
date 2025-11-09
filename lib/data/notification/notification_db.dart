import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

@HiveType(typeId: 9)
class AppNotification {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String type; // 'training', 'weight', 'measurement'

  @HiveField(2)
  late String mode; // 'daily', 'intervalDays', 'weekly'

  @HiveField(3)
  late int intervalDays; // only for 'intervalDays'

  @HiveField(4)
  late List<bool> weekdays; // only for 'weekly'

  @HiveField(5)
  late int hour;

  @HiveField(6)
  late int minute;

  @HiveField(7)
  String? message;

  @HiveField(8)
  late bool isActive;

  @HiveField(9)
  late DateTime createdAt;

  @HiveField(10)
  late String title;

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'mode': mode,
      'intervalDays': intervalDays,
      'weekdays': weekdays,
      'hour': hour,
      'minute': minute,
      'message': message,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'title': title,
    };
  }
}

class AppNotificationAdapter extends TypeAdapter<AppNotification> {
  @override
  final int typeId = 9;

  @override
  AppNotification read(BinaryReader reader) {
    final notification = AppNotification();
    notification.id = reader.readInt();
    notification.type = reader.readString();
    notification.mode = reader.readString();
    notification.intervalDays = reader.readInt();
    notification.weekdays = List.generate(7, (_) => reader.readBool());
    notification.hour = reader.readInt();
    notification.minute = reader.readInt();
    notification.message = reader.readBool() ? reader.readString() : null;
    notification.isActive = reader.readBool();
    notification.createdAt = DateTime.parse(reader.readString());
    notification.title = reader.readString(); // read title
    return notification;
  }

  @override
  void write(BinaryWriter writer, AppNotification obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.type);
    writer.writeString(obj.mode);
    writer.writeInt(obj.intervalDays);
    for (var day in obj.weekdays) {
      writer.writeBool(day);
    }
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
    if (obj.message != null) {
      writer.writeBool(true);
      writer.writeString(obj.message!);
    } else {
      writer.writeBool(false);
    }
    writer.writeBool(obj.isActive);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.title); // write title
  }
}

class AppNotificationBox {
  static late Box<AppNotification> _box;

  static Future<void> initBox() async {
    Hive.registerAdapter(AppNotificationAdapter());
    _box = await Hive.openBox<AppNotification>('notifications');
  }

  static Future<void> addNotification(
      String type,
      String mode,
      int intervalDays,
      List<bool> weekdays,
      int hour,
      int minute,
      String? message,
      bool isActive,
      String title, // new parameter
      ) async {
    final int newId = _getMaxId() + 1;

    final newNotification = AppNotification()
      ..id = newId
      ..type = type
      ..mode = mode
      ..intervalDays = intervalDays
      ..weekdays = List<bool>.from(weekdays)
      ..hour = hour
      ..minute = minute
      ..message = message
      ..isActive = isActive
      ..createdAt = DateTime.now()
      ..title = title;

    await _box.put(newId, newNotification);
  }

  static Future<void> updateNotification(AppNotification config) async {
    await _box.put(config.id, config);
  }

  static List<AppNotification> getAll() => _box.values.toList();

  static AppNotification? getById(int id) =>
      _box.values.firstWhereOrNull((e) => e.id == id);

  static Future<void> delete(int id) async {
    await _box.delete(id);
  }

  static Future<void> deleteAll() async {
    await _box.clear();
  }

  static int _getMaxId() {
    return _box.values.map((e) => e.id).fold(0, (prev, el) => el > prev ? el : prev);
  }

  static Future<void> updateActivation(int id, bool isActive) async {
    final box = await Hive.openBox<AppNotification>('notifications');
    final notification = box.get(id);
    if (notification != null) {
      notification.isActive = isActive;
      await box.put(id, notification); // save updated object
    }
  }
}
