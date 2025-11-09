import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/notification/notification_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/notification_provider.dart';
import '../../../../util/dialog/confirmation_dialog.dart';
import 'notification_service.dart';

class NotificationListSection extends StatelessWidget {
  final VoidCallback onUpdate;

  const NotificationListSection({
    super.key,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final t = AppLocalizations.of(context)!;

    return FutureBuilder<List<AppNotification>>(
      future: notificationProvider.notifications,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final notifications = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorProvider.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: notifications.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Text(
                t.notificationList_empty,
                style: TextStyle(
                  color: colorProvider.accent.withOpacity(0.6),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.notificationList_title,
                style: TextStyle(
                  color: colorProvider.accent.withOpacity(0.8),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => Divider(
                  color: colorProvider.accent.withOpacity(0.0),
                ),
                itemBuilder: (_, i) {
                  final n = notifications[i];
                  return _buildNotificationItem(
                      context, n, colorProvider, t, notificationProvider);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorProvider.accent.withOpacity(0.2),
                    foregroundColor: colorProvider.accent,
                  ),
                  icon: const Icon(Icons.delete_forever),
                  label: Text(t.notificationList_deleteAll),
                  onPressed: () async {
                    final confirmed = await ConfirmationDialog.show(
                      context: context,
                      title: t.notificationList_confirmAll_title,
                      content: t.notificationList_confirmAll_content,
                      onConfirmed: () {},
                    );
                    if (confirmed == true) {
                      for (final n in notifications) {
                        if (n.mode == 'daily') {
                          await NotificationService().cancelScheduledNotification(n.id);
                        } else if (n.mode == 'weekly') {
                          await NotificationService().cancelWeeklyNotificationGroup(n.id);
                        }
                        await AppNotificationBox.delete(n.id);
                      }
                      notificationProvider.notifyListeners();
                      onUpdate();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(
      BuildContext context,
      AppNotification n,
      ColorProvider colorProvider,
      AppLocalizations t,
      NotificationProvider notificationProvider,
      ) {
    bool isLoading = false;
    bool showCheckbox = true; // ustaw według potrzeb

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(n.title, style: TextStyle(color: colorProvider.accent)),
              content: Text(n.message ?? '', style: TextStyle(color: colorProvider.accent.withOpacity(0.9))),
              backgroundColor: colorProvider.secondary,
              actions: [
                TextButton(
                  child: Text('OK', style: TextStyle(color: colorProvider.accent)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(2, 12, 18, 12),
          decoration: BoxDecoration(
            color: n.isActive
                ? colorProvider.accent.withOpacity(0.2)
                : colorProvider.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: IconButton(
              icon: Icon(Icons.delete, color: colorProvider.accent.withValues(alpha: 0.6)),
              onPressed: () async {
                final confirmed = await ConfirmationDialog.show(
                  context: context,
                  title: t.notificationList_confirm_title,
                  content: t.notificationList_confirm_content,
                  onConfirmed: () {},
                );
                if (confirmed == true) {
                  await AppNotificationBox.delete(n.id);
                  notificationProvider.notifyListeners(); // Refresh list
                  onUpdate();
                }
              },
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                "${_reminderTypeToString(n.type, t)} • ${_modeToString(n, t)}",
                style: TextStyle(color: colorProvider.accent),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.notificationList_hour(n.time.format(context)),
                  style: TextStyle(color: colorProvider.accent.withOpacity(0.6)),
                ),
              ],
            ),
            trailing: isLoading
                ? Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(colorProvider.accent),
                ),
              ),
            )
                : (showCheckbox
                ? GestureDetector(
              onTap: () async {
                setState(() => isLoading = true);

                final newValue = !n.isActive;
                await AppNotificationBox.updateActivation(n.id, newValue);

                final now = DateTime.now();
                final time = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  n.time.hour,
                  n.time.minute,
                );

                if (newValue == true) {
                  if (n.mode == 'daily') {
                    await NotificationService().scheduleDailyNotification(
                      id: n.id * 10,
                      title: n.title,
                      body: n.message ?? '',
                      payload: 'type:${n.type}',
                      time: time,
                    );
                  } else if (n.mode == 'weekly') {
                    await NotificationService().scheduleWeeklyNotifications(
                      id: n.id,
                      title: n.title,
                      body: n.message ?? '',
                      payload: 'reminder:${n.type}',
                      time: time,
                      weekdays: n.weekdays,
                    );
                  }
                } else {
                  if (n.mode == 'daily') {
                    await NotificationService().cancelScheduledNotification(n.id);
                  }
                  if (n.mode == 'weekly') {
                    await NotificationService().cancelWeeklyNotificationGroup(n.id);
                  }
                }

                setState(() => isLoading = false);
                notificationProvider.notifyListeners();
                onUpdate();
              },
              child: Icon(
                n.isActive ? Icons.check_box : Icons.check_box_outline_blank,
                color: n.isActive
                    ? colorProvider.accent
                    : colorProvider.accent.withOpacity(0.6),
                size: 24,
              ),
            )
                : null),
          ),
        ),
      );
    });
  }

  String _reminderTypeToString(String type, AppLocalizations t) {
    switch (type) {
      case 'training':
        return t.notificationList_type_training;
      case 'weight':
        return t.notificationList_type_weight;
      case 'measurement':
        return t.notificationList_type_measurement;
      case 'custom':
        return t.notificationList_type_custom;
      default:
        return type;
    }
  }

  String _modeToString(AppNotification n, AppLocalizations t) {
    switch (n.mode) {
      case 'daily':
        return t.notificationList_daily;
      case 'intervalDays':
        if (n.intervalDays == 1) return t.notificationList_daily;
        return t.notificationList_interval(n.intervalDays.toString());
      case 'weekly':
        final days = [
          t.notificationForm_weekdayMon,
          t.notificationForm_weekdayTue,
          t.notificationForm_weekdayWed,
          t.notificationForm_weekdayThu,
          t.notificationForm_weekdayFri,
          t.notificationForm_weekdaySat,
          t.notificationForm_weekdaySun
        ];
        final selected = n.weekdays
            .asMap()
            .entries
            .where((e) => e.value)
            .map((e) => days[e.key]);
        if (selected.length == 7) {
          return t.notificationList_daily;
        }
        return selected.isEmpty
            ? t.notificationList_weekly_none
            : selected.join(", ");
      default:
        return n.mode;
    }
  }
}
