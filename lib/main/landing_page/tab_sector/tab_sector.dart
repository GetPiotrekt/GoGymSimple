import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import 'tab_bottom_drawer.dart';

class TabSector extends StatelessWidget {
  final ColorProvider colorProvider;

  const TabSector({super.key, required this.colorProvider});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bottomDrawer = TabBottomDrawer(colorProvider: colorProvider);

    return Consumer<SelectedOptionsProvider>(
      builder: (context, selectedOptions, _) {
        return Container(
          width: double.maxFinite,
          color: colorProvider.secondary,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                _buildTab(context, t.tabSector_gym, 'Gym', selectedOptions.gym, bottomDrawer),
                _buildTab(context, t.tabSector_user, 'User', selectedOptions.user, bottomDrawer),
                _buildTab(context, t.tabSector_exercise, 'Exercise', selectedOptions.exercise, bottomDrawer),
                _buildTab(context, t.tabSector_workoutPlan, 'Workout plan', selectedOptions.workoutPlan, bottomDrawer),
                const SizedBox(width: 6),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(BuildContext context, String label, String key, List<int> selectedOptionIds, TabBottomDrawer bottomDrawer) {

    String selectedOptionNames = selectedOptionIds.isEmpty
        ? label
        : selectedOptionIds.map((id) {
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
    }).where((name) => name.isNotEmpty).join(', ');

    return GestureDetector(
      onTap: () {
        final provider = Provider.of<SelectedOptionsProvider>(context, listen: false);
        if (selectedOptionIds.isNotEmpty) {
          provider.clearSelectedOption(key);
        } else {
          bottomDrawer.showTabBottomDrawer(context, key);
        }
      },
      onLongPress: () {
        if (selectedOptionIds.isNotEmpty) {
          bottomDrawer.showDeleteConfirmationDialog(context, key, selectedOptionIds.first);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Chip(
          side: BorderSide(
            color: selectedOptionIds.isNotEmpty
                ? colorProvider.accent.withOpacity(0.7)
                : colorProvider.accent.withOpacity(0.3),
            width: 1.5,
          ),
          backgroundColor: selectedOptionIds.isNotEmpty
              ? colorProvider.accent
              : colorProvider.secondary,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Text(
                  selectedOptionNames,
                  style: TextStyle(
                    color: selectedOptionIds.isNotEmpty
                        ? colorProvider.secondary
                        : colorProvider.accent,
                  ),
                ),
                if (selectedOptionIds.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Icon(Icons.close, color: colorProvider.secondary, size: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getGymNameById(int id) {
    return GymBox.getGym(id)?.name;
  }

  String? _getUserNameById(int id) {
    return UserBox.getUserByID(id)?.username;
  }

  String? _getExerciseNameById(int id) {
    return ExerciseBox.getExercisebyID(id)?.exerciseName;
  }

  String? _getWorkoutPlanNameById(int id) {
    return ListExerciseBox.getExerciseListByID(id)?.exerciseListName;
  }
}
