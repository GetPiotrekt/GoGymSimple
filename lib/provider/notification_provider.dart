import 'package:flutter/material.dart';
import '../data/notification/notification_db.dart';

class NotificationProvider with ChangeNotifier {
  // Global settings
  final bool _notificationsEnabled = true;
  final bool _remindersEnabled = true;
  final bool _dailySummaryEnabled = false;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get remindersEnabled => _remindersEnabled;
  bool get dailySummaryEnabled => _dailySummaryEnabled;

  // List of saved notifications
  Future<List<AppNotification>> get notifications async {
    return AppNotificationBox.getAll();
  }

  // Save a new notification
  Future<void> saveNotification({
    required String type,
    required String mode,
    required int intervalDays,
    required List<bool> weekdays,
    required int hour,
    required int minute,
    String? message,
    bool isActive = false,
    required String title,
  }) async {
    await AppNotificationBox.addNotification(
      type,
      mode,
      intervalDays,
      weekdays,
      hour,
      minute,
      message,
      isActive,
      title,
    );
    notifyListeners();
  }

  Future<void> toggleNotificationActiveStatus(int id, bool isActive) async {
    await AppNotificationBox.updateActivation(id, isActive);
    notifyListeners();
  }
// Optionally, you could add methods for enabling/disabling notifications globally, etc.
}
