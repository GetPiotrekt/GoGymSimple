import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/notification_provider.dart';
import '../../../../util/button_icon.dart';
import '../../../../util/dates_and_time/time_picker.dart';
import '../../../../util/input_form_field/input_form_field.dart';
import '../../../../util/snackbar_helper.dart';
import 'notification_screen.dart';

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
      padding: const EdgeInsets.all(8),
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
            _sectionContainer(
                _buildDecoratedDropdowns(colorProvider), colorProvider),
            const SizedBox(height: 16),
            _sectionContainer(_buildMessageInput(colorProvider), colorProvider),
          ],
        ),
      ),
    );
  }

  Widget _sectionContainer(Widget child, ColorProvider colorProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildMessageInput(ColorProvider colorProvider) {
    final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.message_outlined,
                  color: colorProvider.accent, size: 20),
            ),
            const SizedBox(width: 12),
            _buildText(t.notificationForm_titleLabel, colorProvider),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _titleController,
          style: TextStyle(color: colorProvider.accent),
          maxLines: 1,
          decoration: InputDecoration(
            hintText: t.notificationForm_titleHint,
            hintStyle: TextStyle(color: colorProvider.accent.withOpacity(0.5)),
            filled: true,
            fillColor: colorProvider.accent.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.message, color: colorProvider.accent, size: 20),
            ),
            const SizedBox(width: 12),
            _buildText(t.notificationForm_messageLabel, colorProvider),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _messageController,
          style: TextStyle(color: colorProvider.accent),
          maxLines: 2,
          decoration: InputDecoration(
            hintText: t.notificationForm_messageHint,
            hintStyle: TextStyle(color: colorProvider.accent.withOpacity(0.5)),
            filled: true,
            fillColor: colorProvider.accent.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.maxFinite,
          child: ButtonIcon(
            onPressed: () async {
              final notificationData = {
                'type': _reminderType,
                'mode': _mode,
                'time': _selectedTime,
                'message': _messageController.text,
                'interval': _intervalDays,
                'weekdays': List<bool>.from(_selectedWeekDays),
                'title': _titleController.text
              };

              await Provider.of<NotificationProvider>(context, listen: false)
                  .saveNotification(
                      hour: _selectedTime.hour,
                      minute: _selectedTime.minute,
                      intervalDays: _intervalDays,
                      mode: _mode.name,
                      type: _reminderType.name,
                      weekdays: List<bool>.from(_selectedWeekDays),
                      message: _messageController.text,
                      title: _titleController.text);

              widget.onAdd(notificationData);

              SnackbarHelper.showSnackbar(
                context,
                t.notificationForm_added,
              );
            },
            iconData: Icons.add,
            labelText: t.notificationForm_addNotification,
            showBorder: false,
          ),
        )
      ],
    );
  }

  Widget _buildDecoratedDropdowns(ColorProvider colorProvider) {
    final t = AppLocalizations.of(context)!;
    return Column(
      children: [
        _sectionContainer(
          _buildDecoratedRow(
            icon: Icons.fitness_center,
            label: t.notificationForm_typeLabel,
            child: DropdownButton<ReminderType>(
              value: _reminderType,
              dropdownColor: colorProvider.secondary,
              iconEnabledColor: colorProvider.accent,
              style: TextStyle(color: colorProvider.accent),
              onChanged: (type) {
                if (type != null) {
                  setState(() {
                    _reminderType = type;
                    _updateDefaultMessage();
                  });
                }
              },
              items: [
                DropdownMenuItem(
                    value: ReminderType.training,
                    child: Text(t.notificationForm_typeTraining)),
                DropdownMenuItem(
                    value: ReminderType.weight,
                    child: Text(t.notificationForm_typeWeight)),
                DropdownMenuItem(
                    value: ReminderType.measurement,
                    child: Text(t.notificationForm_typeMeasurement)),
                DropdownMenuItem(
                    value: ReminderType.custom,
                    child: Text(t.notificationForm_typeCustom)),
              ],
            ),
            colorProvider: colorProvider,
          ),
          colorProvider,
        ),
        const SizedBox(height: 16),
        _sectionContainer(
          _buildDecoratedRow(
            icon: Icons.calendar_month_outlined,
            label: t.notificationForm_modeLabel,
            child: DropdownButton<NotificationMode>(
              value: _mode,
              dropdownColor: colorProvider.secondary,
              iconEnabledColor: colorProvider.accent,
              style: TextStyle(color: colorProvider.accent),
              onChanged: (mode) => setState(() => _mode = mode!),
              items:  [
                DropdownMenuItem(
                    value: NotificationMode.daily,
                    child: Text(t.notificationForm_modeDaily)),
                DropdownMenuItem(
                    value: NotificationMode.intervalDays,
                    child: Text(t.notificationForm_modeInterval)),
                DropdownMenuItem(
                    value: NotificationMode.weekly,
                    child: Text(t.notificationForm_modeWeekly)),
              ],
            ),
            colorProvider: colorProvider,
          ),
          colorProvider,
        ),
        if (_mode != NotificationMode.daily) const SizedBox(height: 16),
        if (_mode != NotificationMode.daily)
          _sectionContainer(_buildModeSettings(colorProvider), colorProvider),
        const SizedBox(height: 16),
        _sectionContainer(_buildTimePicker(colorProvider), colorProvider),
      ],
    );
  }

  Widget _buildDecoratedRow({
    required IconData icon,
    required String label,
    required Widget child,
    required ColorProvider colorProvider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: colorProvider.accent, size: 20),
            ),
            const SizedBox(width: 12),
            _buildText(label, colorProvider),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildText(String text, ColorProvider colorProvider) {
    return Text(text, style: TextStyle(color: colorProvider.accent));
  }

  Widget _buildModeSettings(ColorProvider colorProvider) {
    final t = AppLocalizations.of(context)!;
    switch (_mode) {
      case NotificationMode.intervalDays:
        return Row(
          children: [
            _buildText(t.notificationForm_intervalPrefix, colorProvider),
            const SizedBox(width: 10),
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: InputFormField(
                labelText: t.notificationForm_intervalSuffix,
                controller:
                    TextEditingController(text: _intervalDays.toString()),
                keyboardType: TextInputType.number,
                fontSize: 18,
                onChanged: (val) {
                  final parsed = int.tryParse(val);
                  if (parsed != null && parsed > 0 && parsed <= 365) {
                    setState(() => _intervalDays = parsed);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            _buildText("d.", colorProvider),
          ],
        );
      case NotificationMode.weekly:
        final days = [t.notificationForm_weekdayMon,
          t.notificationForm_weekdayTue,
          t.notificationForm_weekdayWed,
          t.notificationForm_weekdayThu,
          t.notificationForm_weekdayFri,
          t.notificationForm_weekdaySat,
          t.notificationForm_weekdaySun
        ];
        return Wrap(
          spacing: 8,
          children: List.generate(7, (i) {
            final isSelected = _selectedWeekDays[i];
            return FilterChip(
              checkmarkColor: colorProvider.accent,
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedWeekDays[i] = val),
              label: Text(days[i]),
              selectedColor: colorProvider.secondary,
              backgroundColor: colorProvider.secondary,
              labelStyle: TextStyle(
                color: isSelected
                    ? colorProvider.accent
                    : colorProvider.accent.withOpacity(0.4),
              ),
            );
          }),
        );
      case NotificationMode.daily:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTimePicker(ColorProvider colorProvider) {
    return CustomTimePicker(
      initialTime: _selectedTime,
      onTimeSelected: (time) => setState(() => _selectedTime = time),
    );
  }
}
