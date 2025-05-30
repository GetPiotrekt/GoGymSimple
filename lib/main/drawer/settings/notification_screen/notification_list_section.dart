import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../../../data/notification_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../util/dialog/confirmation_dialog.dart';
import '../../../notification_service.dart';

class NotificationListSection extends StatelessWidget {
  final List<AppNotification> notifications;
  final VoidCallback onUpdate;

  const NotificationListSection({
    super.key,
    required this.notifications,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

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
            separatorBuilder: (_, __) => Divider(color: colorProvider.accent.withOpacity(0.0)),
            itemBuilder: (_, i) {
              final n = notifications[i];
              return GestureDetector(
                onLongPress: () async {
                  final confirmed = await showConfirmationDialog(
                    context: context,
                    title: t.notificationList_confirm_title,
                    content: t.notificationList_confirm_content,
                    onConfirmed: () async {
                      final notificationService = NotificationService();
                      await notificationService.notificationsPlugin.cancel(n.id);
                      await notificationService.cancelScheduledNotifications(startId: n.id * 1000, count: 100);
                      await AppNotificationBox.delete(n.id);
                      onUpdate();
                    },
                  );
                  if (confirmed ?? false) {}
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(n.title, style: TextStyle(color: colorProvider.accent)),
                      content: Text(n.message!, style: TextStyle(color: colorProvider.accent.withOpacity(0.9))),
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
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
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
                    trailing: Checkbox(
                      value: n.isActive,
                      onChanged: (bool? value) async {
                        if (value == null) return;

                        await AppNotificationBox.updateActivation(n.id, value);

                        final notificationService = NotificationService();
                        if (value) {
                          switch (n.mode) {
                            case 'daily':
                              await notificationService.scheduleDailyNotification(
                                id: n.id,
                                title: n.title,
                                body: n.message.toString(),
                                time: DateTime(0, 0, 0, n.time.hour, n.time.minute),
                              );
                              break;
                            case 'intervalDays':
                              final now = DateTime.now();
                              final startTime = DateTime(now.year, now.month, now.day, n.time.hour, n.time.minute);
                              await notificationService.scheduleNotificationsEveryNDays(
                                startId: n.id * 1000,
                                title: n.title,
                                body: n.message.toString(),
                                startTime: startTime,
                                intervalInDays: n.intervalDays ?? 1,
                                count: 100,
                              );
                              break;
                            case 'weekly':
                              final selectedDays = getSelectedDays(n.weekdays);
                              await notificationService.scheduleWeeklyNotificationsOnDays(
                                startId: n.id * 1000,
                                title: n.title,
                                body: n.message.toString(),
                                daysOfWeek: selectedDays,
                                time: DateTime(n.time.hour, n.time.minute),
                              );
                              break;
                          }
                        } else {
                          await notificationService.notificationsPlugin.cancel(n.id);
                          await notificationService.cancelScheduledNotifications(startId: n.id * 1000, count: 100);
                        }

                        onUpdate();
                      },
                      activeColor: colorProvider.accent,
                      checkColor: colorProvider.secondary,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          // Jeśli checkbox jest aktywny — pełny kolor accent
                          if (n.isActive) {
                            return colorProvider.accent;
                          } else {
                            // Jeśli nieaktywny — accent z przezroczystością
                            return colorProvider.accent.withOpacity(0.6);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
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
        return t.notificationList_interval(n.intervalDays.toString());
      case 'weekly':
        final days = [t.notificationForm_weekdayMon,
          t.notificationForm_weekdayTue,
          t.notificationForm_weekdayWed,
          t.notificationForm_weekdayThu,
          t.notificationForm_weekdayFri,
          t.notificationForm_weekdaySat,
          t.notificationForm_weekdaySun
        ];
        final selected = n.weekdays.asMap().entries.where((e) => e.value).map((e) => days[e.key]);
        return selected.isEmpty ? t.notificationList_weekly_none : selected.join(", ");
      default:
        return n.mode;
    }
  }

  List<Day> getSelectedDays(List<bool> weekdays) {
    final days = <Day>[];
    for (int i = 0; i < weekdays.length; i++) {
      if (weekdays[i]) {
        days.add(Day.values[i]);
      }
    }
    return days;
  }
}
