import 'package:GoGymSimple/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/data_tab_sector/gym_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../util/custom_dropdown.dart';
import '../../util/dates_and_time/date_picker.dart';
import '../../util/dates_and_time/days_ago.dart';
import '../../util/dialog/text_input_dialog.dart';
import '../drawer/settings/notification_screen/notification_service.dart';

class GymDateSection extends StatefulWidget {
  const GymDateSection({super.key});

  @override
  State<GymDateSection> createState() => _GymDateSectionState();
}

class _GymDateSectionState extends State<GymDateSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WorkoutProvider>().loadGyms());
  }

  @override
  Widget build(BuildContext context) {
    final color = context.watch<ColorProvider>();
    final provider = context.watch<WorkoutProvider>();
    final t = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 2,),
          Text(
            t.workoutScreen_gymAndDate,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: color.accent,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (provider.gyms.length == 1) {
                    provider.setSelectedGym(provider.gyms.first['id']!);
                    if (!provider.isStarted) {
                      provider.startWorkout();
                      NotificationService().showTrainingOngoingNotification();
                    }
                  }
                },
                child: _icon(Icons.fitness_center),
              ),
              const SizedBox(width: 12),
              Expanded(child: _gymDropdown(context, provider, t)),
              const SizedBox(width: 8),
              _addGymButton(provider, t),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () => _pickDate(provider),
                child: _icon(Icons.calendar_today),
              ),
              const SizedBox(width: 12),
              Expanded(child: _dateDisplay(provider)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) {
    final color = context.watch<ColorProvider>();
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color.accent, size: 22),
    );
  }

  Widget _gymDropdown(BuildContext context, WorkoutProvider gymProvider, AppLocalizations t) {
    final colorProvider = context.watch<ColorProvider>();

    return DropdownButtonFormField<String>(
      value: gymProvider.selectedGymId.isEmpty ? null : gymProvider.selectedGymId,
      decoration: CustomDropdown.dropdownInputDecoration(colorProvider),
      dropdownColor: colorProvider.secondary,
      style: CustomDropdown.dropdownItemStyle(colorProvider),
      icon: Icon(Icons.expand_more, color: colorProvider.accent),
      hint: Text(
        t.workoutScreen_gym,
        style: CustomDropdown.dropdownItemStyle(colorProvider),
      ),
      items: [
        ...gymProvider.gyms.map((gym) {
          return DropdownMenuItem<String>(
            value: gym['id'],
            child: Text(gym['name'] ?? '', style: CustomDropdown.dropdownItemStyle(colorProvider)),
          );
        })
      ],
      onChanged: (value) {
        gymProvider.setSelectedGym(value ?? '');
        if (!gymProvider.isStarted) {
          gymProvider.startWorkout();
          NotificationService().showTrainingOngoingNotification(); // ✅ dodane powiadomienie
        }
      },
    );
  }

  Widget _addGymButton(WorkoutProvider provider, AppLocalizations t) {
    final color = context.watch<ColorProvider>();

    return GestureDetector(
      onTap: () async {
        final name = await TextInputDialog.showTextInputDialog(
          context: context,
          title: t.tabBottomDrawer_addNewGym,
          labelText: t.tabBottomDrawer_enterGymName,
        );

        if (name?.isNotEmpty == true) {
          final newGymId = await GymBox.addGym(name!);
          provider.loadGyms();
          provider.setSelectedGym(newGymId.toString());

          if (!provider.isStarted) {
            provider.startWorkout();
            NotificationService().showTrainingOngoingNotification(); // ✅ dodane powiadomienie
          }
        }
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add, color: color.accent, size: 26),
      ),
    );
  }

  Future<void> _pickDate(WorkoutProvider provider) async {
    final picked = await showCustomDatePicker(context, provider.selectedDate ?? DateTime.now());
    if (picked != null) provider.setDate(picked);
  }

  Widget _dateDisplay(WorkoutProvider provider) {
    final color = context.watch<ColorProvider>();
    final date = provider.selectedDate ?? DateTime.now();

    final localizedDaysAgo = DaysAgo.formatNoteDate(context, date);
    final locale = Localizations.localeOf(context).toString();
    final formattedShortDate = DateFormat("dd MMM yyyy", locale).format(date);

    return InkWell(
      onTap: () => _pickDate(provider),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.accent.withOpacity(0.1),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedShortDate,
                style: TextStyle(
                  fontSize: 16,
                  color: color.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "($localizedDaysAgo)",
                style: TextStyle(
                  fontSize: 16,
                  color: color.accent.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
