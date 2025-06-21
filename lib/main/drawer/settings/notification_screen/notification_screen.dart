import 'package:GoGymSimple/main/drawer/settings/notification_screen/notification_form/notification_form.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../data/notification/notification_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../util/custom_appbar.dart';
import 'notification_list_section.dart';
import 'notification_service.dart';

enum NotificationMode { daily, intervalDays, weekly }

enum ReminderType { training, weight, measurement, custom }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  bool _hasPermission = false;
  DateTime? _scheduledDate;
  List<AppNotification> _notifications = [];

  @override
  void initState() {
    super.initState();
    _initializeAndCheckPermissions();
  }

  Future<void> _initializeAndCheckPermissions() async {
    await _notificationService.initNotification();
    final status = await Permission.notification.status;
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  Future<void> _loadNotifications() async {
    final saved = AppNotificationBox.getAll();
    setState(() => _notifications = saved);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(title: t.notificationScreen_title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              NotificationForm(
                onAdd: (Map<String, dynamic> newNotification) async {
                  _loadNotifications();
                },
              ),
              const SizedBox(height: 16),
              // Lista zapisanych powiadomień
              NotificationListSection(
                onUpdate: _loadNotifications,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
