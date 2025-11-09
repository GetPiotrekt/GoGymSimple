import 'package:flutter/material.dart';
import 'package:GoGymSimple/data/data_tab_sector/list_exercise_db.dart';
import 'package:GoGymSimple/util/dialog/delete_confirmation_dialog.dart';
import 'package:GoGymSimple/l10n/app_localizations.dart';
import 'package:GoGymSimple/provider/workout_provider.dart';
import 'package:GoGymSimple/provider/selected_options_provider.dart';
import 'package:GoGymSimple/provider/color_provider.dart';
import 'package:GoGymSimple/util/bottom_sheet/bottom_sheet.dart';
import 'package:GoGymSimple/main/landing_page/tab_sector/tab_bottom_drawer/tab_bottom_drawer_service.dart';
import 'package:GoGymSimple/main/landing_page/tab_sector/add_workout_plan.dart';
import 'package:provider/provider.dart';

import '../../../../../data/data_tab_sector/exercise_db.dart';

class WorkoutPlanBottomDrawer {
  static void show({
    required BuildContext context,
    required bool isFromWorkout,
  }) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;
    final selectedOptionsProvider = Provider.of<SelectedOptionsProvider>(context, listen: false);
    final trainingSessionProvider = Provider.of<WorkoutProvider>(context, listen: false);

    List<int> selectedOptions = isFromWorkout
        ? trainingSessionProvider.getSelectedOptions('Workout plan')
        : selectedOptionsProvider.getSelectedOptions('Workout plan');

    List<Map<String, dynamic>> options = TabBottomDrawerService.getOptions('Workout plan');

    // Usuń plany, które nie zawierają żadnych poprawnych ćwiczeń
    options.removeWhere((option) => _getExerciseIdString(option['id']) == null);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BottomSheetTemplate(
          onPressed: () => Navigator.pop(context),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (options.isNotEmpty)
                      Center(
                        child: Text(
                          t.tabBottomDrawer_showOnly,
                          style: TextStyle(
                            fontSize: 22,
                            color: colorProvider.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (options.isNotEmpty)
                      const SizedBox(height: 12),
                    if (options.isNotEmpty)
                      ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: options.map((option) {
                        final exerciseText = _getExerciseIdString(option['id']);
                        if (exerciseText == null) return const SizedBox.shrink();

                        final isSelected = selectedOptions.contains(option['id']);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorProvider.accent.withOpacity(0.3)
                                  : colorProvider.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(right: 16, left: 8),
                              title: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: colorProvider.accent.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.edit, color: colorProvider.accent),
                                      onPressed: () {
                                        _openEditWorkoutPlan(context, option['id']);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          option['name'],
                                          style: TextStyle(color: colorProvider.accent, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          exerciseText,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: colorProvider.accent.withOpacity(0.8),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                isSelected ? Icons.check_circle : Icons.circle_outlined,
                                color: colorProvider.accent,
                              ),
                              onTap: () {
                                if (isFromWorkout) {
                                  trainingSessionProvider.toggleOption('Workout plan', option['id']);

                                  final plan = ListExerciseBox.getExerciseListByID(option['id']);
                                  if (plan != null) {
                                    final isNowSelected = trainingSessionProvider
                                        .getSelectedOptions('Workout plan')
                                        .contains(option['id']);
                                    for (var exerciseId in plan.exerciseIDs) {
                                      trainingSessionProvider.setOptionChecked('Exercise', exerciseId, isNowSelected);
                                    }
                                  }
                                } else {
                                  selectedOptionsProvider.toggleOption('Workout plan', option['id']);

                                  final plan = ListExerciseBox.getExerciseListByID(option['id']);
                                  if (plan != null) {
                                    final isNowSelected = selectedOptionsProvider
                                        .getSelectedOptions('Workout plan')
                                        .contains(option['id']);
                                    for (var exerciseId in plan.exerciseIDs) {
                                      selectedOptionsProvider.setOptionChecked('Exercise', exerciseId, isNowSelected);
                                    }
                                  }
                                }

                                setState(() {});
                              },
                              onLongPress: () => _showDeleteConfirmationDialog(context, option['id']),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorProvider.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.add, color: colorProvider.accent),
                                title: Text(
                                  TabBottomDrawerService.getAddNewTitle(t, 'Workout plan'),
                                  style: TextStyle(color: colorProvider.accent),
                                ),
                                onTap: () => _showAddWorkoutPlan(context),
                              ),
                            ),
                          ),
                          if (selectedOptions.isNotEmpty && !isFromWorkout)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorProvider.accent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.close, color: colorProvider.accent),
                                  onPressed: () {
                                    selectedOptionsProvider.clearSelectedOption('Workout plan');
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Future<void> _showDeleteConfirmationDialog(BuildContext context, int id) async {
    final confirmed = await DeleteConfirmationDialog.show(context);
    if (confirmed == true) {
      TabBottomDrawerService.deleteItem('Workout plan', id);
    }
  }

  static void _showAddWorkoutPlan(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddWorkoutPlan()));
  }

  static void _openEditWorkoutPlan(BuildContext context, int planId) {
    final plan = ListExerciseBox.getExerciseListByID(planId);
    if (plan == null) return;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddWorkoutPlan(
          initialPlanName: plan.exerciseListName,
          initialExercises: plan.exerciseIDs,
        ),
      ),
    );
  }

  static String? _getExerciseIdString(int planId) {
    final plan = ListExerciseBox.getExerciseListByID(planId);
    if (plan == null || plan.exerciseIDs.isEmpty) return null;

    final exerciseNames = plan.exerciseIDs.map((id) {
      final exercise = ExerciseBox.getExercisebyID(id);
      return exercise?.exerciseName;
    }).where((name) => name != null && name.isNotEmpty).cast<String>().toList();

    if (exerciseNames.isEmpty) {
      // Usuń plan, jeśli nie ma żadnych ćwiczeń z nazwą
      TabBottomDrawerService.deleteItem('Workout plan', planId);
      return null;
    }

    return exerciseNames.join(', ');
  }
}
