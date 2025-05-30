import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../data/notification_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../util/custom_appbar.dart';
import 'notification_form.dart';
import 'notification_list_section.dart';

enum NotificationMode { daily, intervalDays, weekly }

enum ReminderType { training, weight, measurement, custom }

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<AppNotification> _notifications = [];
  bool _hasNotificationPermission = true;

  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final saved = AppNotificationBox.getAll();
    setState(() => _notifications = saved);
  }

  Future<void> _checkNotificationPermission() async {
    final status = await Permission.notification.status;
    setState(() {
      _hasNotificationPermission = status.isGranted;
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    setState(() {
      _hasNotificationPermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.notificationScreen_title,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Formularz dodawania nowego powiadomienia
                    NotificationForm(
                      onAdd: (Map<String, dynamic> newNotification) async {
                        _loadNotifications();
                      },
                    ),

                    const SizedBox(height: 16),

                    // Lista zapisanych powiadomień
                    NotificationListSection(
                      notifications: _notifications,
                      onUpdate: _loadNotifications,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !_hasNotificationPermission
          ? FloatingActionButton(
              backgroundColor: colorProvider.accent,
              onPressed: _requestNotificationPermission,
              tooltip: t.notificationScreen_permissionTooltip,
              child: Icon(Icons.warning, color: colorProvider.secondary),
            )
          : null,
    );
  }
}
