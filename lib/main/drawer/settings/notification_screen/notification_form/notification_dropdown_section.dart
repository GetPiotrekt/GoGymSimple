import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../util/dates_and_time/time_picker.dart';
import '../../../../../util/input_form_field/input_form_field.dart';
import '../notification_screen.dart';

class NotificationDropdownSection extends StatelessWidget {
  final ReminderType reminderType;
  final NotificationMode mode;
  final int intervalDays;
  final List<bool> selectedWeekDays;
  final TimeOfDay selectedTime;
  final void Function(ReminderType) onReminderTypeChanged;
  final void Function(NotificationMode) onModeChanged;
  final void Function(int) onIntervalDaysChanged;
  final void Function(int, bool) onWeekdayToggled;
  final void Function(TimeOfDay) onTimeChanged;

  const NotificationDropdownSection({
    super.key,
    required this.reminderType,
    required this.mode,
    required this.intervalDays,
    required this.selectedWeekDays,
    required this.selectedTime,
    required this.onReminderTypeChanged,
    required this.onModeChanged,
    required this.onIntervalDaysChanged,
    required this.onWeekdayToggled,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        // ReminderType i NotificationMode obok siebie
        Row(
          children: [
            Expanded(
              child: _sectionContainer(
                context,
                _buildDecoratedRow(
                  context: context,
                  icon: Icons.fitness_center,
                  label: t.notificationForm_typeLabel,
                  child: DropdownButton<ReminderType>(
                    value: reminderType,
                    dropdownColor: colorProvider.secondary,
                    iconEnabledColor: colorProvider.accent,
                    style: TextStyle(color: colorProvider.accent),
                    isExpanded: true,
                    onChanged: (type) {
                      if (type != null) onReminderTypeChanged(type);
                    },
                    items: [
                      DropdownMenuItem(
                        value: ReminderType.training,
                        child: Text(t.notificationForm_typeTraining),
                      ),
                      DropdownMenuItem(
                        value: ReminderType.weight,
                        child: Text(t.notificationForm_typeWeight),
                      ),
                      DropdownMenuItem(
                        value: ReminderType.measurement,
                        child: Text(t.notificationForm_typeMeasurement),
                      ),
                      DropdownMenuItem(
                        value: ReminderType.custom,
                        child: Text(t.notificationForm_typeCustom),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16), // odstęp między dropdownami
            Expanded(
              child: _sectionContainer(
                context,
                _buildDecoratedRow(
                  context: context,
                  icon: Icons.calendar_month_outlined,
                  label: t.notificationForm_modeLabel,
                  child: DropdownButton<NotificationMode>(
                    value: mode,
                    dropdownColor: colorProvider.secondary,
                    iconEnabledColor: colorProvider.accent,
                    style: TextStyle(color: colorProvider.accent),
                    isExpanded: true,
                    onChanged: (mode) {
                      if (mode != null) onModeChanged(mode);
                    },
                    items: [
                      DropdownMenuItem(
                        value: NotificationMode.daily,
                        child: Text(t.notificationForm_modeDaily),
                      ),
                      // DropdownMenuItem( // Opcja "co x dni" skomentowana
                      //   value: NotificationMode.intervalDays,
                      //   child: Text(t.notificationForm_modeInterval),
                      // ),
                      DropdownMenuItem(
                        value: NotificationMode.weekly,
                        child: Text(t.notificationForm_modeWeekly),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (mode != NotificationMode.daily)
          _sectionContainer(context, _buildModeSettings(context)),
        if (mode != NotificationMode.daily) const SizedBox(height: 16),

        _sectionContainer(context, _buildTimePicker(colorProvider)),
      ],
    );
  }

  Widget _buildDecoratedRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: colorProvider.accent, size: 20),
              ),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: colorProvider.accent)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _sectionContainer(BuildContext context, Widget child) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildModeSettings(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);

    switch (mode) {
    // case NotificationMode.intervalDays: // Opcja "co x dni" skomentowana
    //   return Row(
    //     children: [
    //       Text(t.notificationForm_intervalPrefix,
    //           style: TextStyle(color: colorProvider.accent)),
    //       const SizedBox(width: 10),
    //       SizedBox(
    //         width: 50,
    //         child: InputFormField(
    //           labelText: '',
    //           controller:
    //               TextEditingController(text: intervalDays.toString()),
    //           keyboardType: TextInputType.number,
    //           fontSize: 18,
    //           onChanged: (val) {
    //             final parsed = int.tryParse(val);
    //             if (parsed != null && parsed > 0 && parsed <= 365) {
    //               onIntervalDaysChanged(parsed);
    //             }
    //           },
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //       Text("d.", style: TextStyle(color: colorProvider.accent)),
    //     ],
    //   );
      case NotificationMode.weekly:
        final days = [
          t.notificationForm_weekdayMon,
          t.notificationForm_weekdayTue,
          t.notificationForm_weekdayWed,
          t.notificationForm_weekdayThu,
          t.notificationForm_weekdayFri,
          t.notificationForm_weekdaySat,
          t.notificationForm_weekdaySun,
        ];

        return Wrap(
          spacing: 8,
          children: List.generate(7, (i) {
            final isSelected = selectedWeekDays[i];
            return ChoiceChip( // Zmieniono na ChoiceChip
              label: Text(days[i]),
              selected: isSelected,
              selectedColor: colorProvider.secondary.withOpacity(0.8), // Zaktualizowany kolor
              backgroundColor: colorProvider.secondary.withOpacity(0.6), // Zaktualizowany kolor
              checkmarkColor: colorProvider.accent,
              labelStyle: TextStyle(
                color: isSelected
                    ? colorProvider.accent
                    : colorProvider.accent.withOpacity(0.7), // Zaktualizowany styl
                fontWeight: FontWeight.w500, // Zaktualizowany styl
              ),
              shape: RoundedRectangleBorder( // Dodano kształt
                side: BorderSide(
                  color: isSelected
                      ? colorProvider.accent.withOpacity(0.5)
                      : Colors.transparent,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: (val) => onWeekdayToggled(i, val),
            );
          }),
        );
      case NotificationMode.daily:
        return const SizedBox.shrink();
      default: // Dodany default case, aby uniknąć błędów, jeśli `mode` jest `intervalDays`
        return const SizedBox.shrink();
    }
  }

  Widget _buildTimePicker(ColorProvider colorProvider) {
    return CustomTimePicker(
      initialTime: selectedTime,
      onTimeSelected: onTimeChanged,
    );
  }
}
