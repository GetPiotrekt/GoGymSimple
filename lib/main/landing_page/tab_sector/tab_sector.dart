import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../data/workout/session_data/session_data_db.dart';
import '../../../data/workout/session_data/workout_note_db.dart';
import '../../../l10n/app_localizations.dart';
import 'tab_bottom_drawer/tab_bottom_drawer.dart';

class TabSector extends StatelessWidget {
  final ColorProvider colorProvider;

  const TabSector({super.key, required this.colorProvider});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bottomDrawer = TabBottomDrawer(colorProvider: colorProvider);

    return Consumer<SelectedOptionsProvider>(
      builder: (context, selectedOptions, _) {
        // Sprawdzamy czy jest cokolwiek zaznaczone
        bool hasSelected = selectedOptions.gym.isNotEmpty ||
            selectedOptions.user.isNotEmpty ||
            selectedOptions.workoutPlan.isNotEmpty ||
            selectedOptions.exercise.isNotEmpty;

        return Container(
          width: double.maxFinite,
          color: colorProvider.secondary,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Stack(
            children: [
              // Główna zawartość przewijana
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    if (hasSelected) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.clear, color: colorProvider.accent),
                            onPressed: () {
                              selectedOptions.clearSelectedOption('Gym');
                              selectedOptions.clearSelectedOption('User');
                              selectedOptions.clearSelectedOption('Workout plan');
                              selectedOptions.clearSelectedOption('Exercise');
                            },
                          ),
                        ),
                      ),
                    ],
                    if (!hasSelected)
                      Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 4, left: 4),
                        child: Text(
                          '${t.tabSector_filter}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorProvider.accent,
                          ),
                        ),
                      ),
                    _buildUserAndGymTab(
                      context,
                      t.tabSector_userGym,
                      selectedOptions.user,
                      selectedOptions.gym,
                      bottomDrawer,
                    ),
                    _buildTab(context, t.tabSector_workoutPlan, 'Workout plan',
                        selectedOptions.workoutPlan, bottomDrawer),
                    _buildTab(context, t.tabSector_exercise, 'Exercise',
                        selectedOptions.exercise, bottomDrawer),
                    const SizedBox(width: 12),
                  ],
                ),
              ),

              // Lewy gradient
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 15,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          colorProvider.secondary,
                          colorProvider.secondary.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Prawy gradient
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 15,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          colorProvider.secondary,
                          colorProvider.secondary.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      },
    );
  }

  Widget _buildTab(BuildContext context, String label, String key,
      List<int> selectedOptionIds, TabBottomDrawer bottomDrawer) {
    String selectedOptionNames = selectedOptionIds.isEmpty
        ? label
        : selectedOptionIds
            .map((id) {
              switch (key) {
                case 'Gym':
                  return _getGymNameById(id) ?? '';
                case 'User':
                  return _getUserNameById(id) ?? '';
                case 'Exercise':
                  return _getExerciseNameById(id) ?? '';
                case 'Workout plan':
                  return _getWorkoutPlanNameById(id) ?? '';
                default:
                  return '';
              }
            })
            .where((name) => name.isNotEmpty)
            .join(', ');

    return GestureDetector(
      onTap: () {
        bottomDrawer.showTabBottomDrawer(context, key);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        margin: const EdgeInsets.only(right: 8, bottom: 4),
        decoration: BoxDecoration(
          color: selectedOptionIds.isNotEmpty
              ? colorProvider.accent.withOpacity(0.2)
              : colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorProvider.accent.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedOptionNames,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorProvider.accent,
              ),
            ),
            if (selectedOptionIds.isNotEmpty) ...[
              const SizedBox(width: 8),
              Icon(Icons.edit, color: colorProvider.accent, size: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUserAndGymTab(
    BuildContext context,
    String label,
    List<int> selectedUserIds,
    List<int> selectedGymIds,
    TabBottomDrawer bottomDrawer,
  ) {
    final userNames =
        selectedUserIds.map((id) => _getUserNameById(id)).whereType<String>();
    final gymNames =
        selectedGymIds.map((id) => _getGymNameById(id)).whereType<String>();

    final allNames = [...userNames, ...gymNames];
    final hasSelected = allNames.isNotEmpty;
    final displayText = hasSelected ? allNames.join(', ') : label;

    return GestureDetector(
      onTap: () => bottomDrawer.showTabBottomDrawer(context, 'UserAndGym'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        margin: const EdgeInsets.only(right: 8, bottom: 4),
        decoration: BoxDecoration(
          color: hasSelected
              ? colorProvider.accent.withOpacity(0.2)
              : colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorProvider.accent.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorProvider.accent,
              ),
            ),
            if (hasSelected) ...[
              const SizedBox(width: 8),
              Icon(Icons.edit, color: colorProvider.accent, size: 16),
            ],
          ],
        ),
      ),
    );
  }

  void _printAllHiveData() {
    // Workout Notes – tylko ID
    print('---- WorkoutNoteBox ----');
    for (var note in WorkoutNoteBox.getAllNotes()) {
      print('userID: ${note.userID}, exerciseID: ${note.exerciseID}, note: ${note.note}');
    }

    // Session Data – tylko ID
    print('---- SessionDataBox ----');
    final session = SessionDataBox.getSession();
    if (session != null) {
      print('GymID: ${session.selectedGymID}');
      print('Date: ${session.selectedDate}');
      print('ExerciseIDs: ${session.selectedExerciseIDs}');
      print('WorkoutPlanIDs: ${session.selectedWorkoutPlanIDs}');
    } else {
      print('Brak danych w SessionDataBox.');
    }
  }

  String? _getGymNameById(int id) => GymBox.getGym(id)?.name;

  String? _getUserNameById(int id) => UserBox.getUserByID(id)?.username;

  String? _getExerciseNameById(int id) =>
      ExerciseBox.getExercisebyID(id)?.exerciseName;

  String? _getWorkoutPlanNameById(int id) =>
      ListExerciseBox.getExerciseListByID(id)?.exerciseListName;
}
