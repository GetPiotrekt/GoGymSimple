import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../notification_screen.dart';
import 'notification_dropdown_section.dart';
import 'notification_message_input_section.dart';

class NotificationForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAdd;

  const NotificationForm({super.key, required this.onAdd});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  NotificationMode _mode = NotificationMode.daily;
  ReminderType _reminderType = ReminderType.training;
  int _intervalDays = 2;
  final List<bool> _selectedWeekDays = List.generate(7, (_) => false);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);
  late TextEditingController _messageController;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDefaultMessage();
  }

  void _updateDefaultMessage() {
    final t = AppLocalizations.of(context)!;
    switch (_reminderType) {
      case ReminderType.training:
        _titleController.text = t.notificationForm_defaultTitleTraining;
        _messageController.text = t.notificationForm_defaultMessageTraining;
        break;
      case ReminderType.weight:
        _titleController.text = t.notificationForm_defaultTitleWeight;
        _messageController.text = t.notificationForm_defaultMessageWeight;
        break;
      case ReminderType.measurement:
        _titleController.text = t.notificationForm_defaultTitleMeasurement;
        _messageController.text = t.notificationForm_defaultMessageMeasurement;
        break;
      case ReminderType.custom:
        _titleController.text = "";
        _messageController.text = "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorProvider.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Górna sekcja
            NotificationDropdownSection(
              reminderType: _reminderType,
              mode: _mode,
              intervalDays: _intervalDays,
              selectedWeekDays: _selectedWeekDays,
              selectedTime: _selectedTime,
              onReminderTypeChanged: (val) {
                setState(() {
                  _reminderType = val;
                  _updateDefaultMessage();
                });
              },
              onModeChanged: (val) => setState(() => _mode = val),
              onIntervalDaysChanged: (val) =>
                  setState(() => _intervalDays = val),
              onWeekdayToggled: (index, selected) =>
                  setState(() => _selectedWeekDays[index] = selected),
              onTimeChanged: (val) => setState(() => _selectedTime = val),
            ),

            const SizedBox(height: 16),

            /// Dolna sekcja
            NotificationMessageInputSection(
              titleController: _titleController,
              messageController: _messageController,
              reminderType: _reminderType,
              selectedTime: _selectedTime,
              intervalDays: _intervalDays,
              mode: _mode,
              selectedWeekDays: _selectedWeekDays,
              onAdd: widget.onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
