import 'package:GoGymSimple/data/data_tab_sector/exercise_db.dart';
import 'package:GoGymSimple/data/data_tab_sector/list_exercise_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/selected_options_provider.dart';
import '../../../../../provider/workout_provider.dart';
import '../../../../../util/bottom_sheet/bottom_sheet.dart';
import '../../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../../util/snackbar_helper.dart';
import '../../add_exercise.dart';

class ExerciseBottomDrawer {
  final ColorProvider colorProvider;

  ExerciseBottomDrawer({required this.colorProvider});

  static void show(BuildContext context, {required bool isFromWorkout}) {
    final t = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final colorProvider = context.watch<ColorProvider>();
            final selectedOptionsProvider =
                Provider.of<SelectedOptionsProvider>(context, listen: false);
            final trainingSessionProvider =
                Provider.of<WorkoutProvider>(context, listen: false);

            List<int> selectedOptions = isFromWorkout
                ? trainingSessionProvider.getSelectedOptions('Exercise')
                : selectedOptionsProvider.getSelectedOptions('Exercise');

            List<Map<String, dynamic>> options = ExerciseBox.getAllExercises()
                .map((exercise) =>
                    {'id': exercise.exerciseID, 'name': exercise.exerciseName})
                .toList();

            return BottomSheetTemplate(
              onPressed: () => Navigator.pop(context),
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
                  if (options.isNotEmpty) const SizedBox(height: 12),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: options.map((option) {
                      final exercise =
                          ExerciseBox.getExercisebyID(option['id']);

                      final isSelected = selectedOptions.contains(option['id']);

                      List<String> selectedWorkoutPlanNames = [];
                      final selectedWorkoutPlanIds = isFromWorkout
                          ? trainingSessionProvider
                              .getSelectedOptions('Workout plan')
                          : selectedOptionsProvider
                              .getSelectedOptions('Workout plan');

                      for (var planId in selectedWorkoutPlanIds) {
                        final plan =
                            ListExerciseBox.getExerciseListByID(planId);
                        if (plan != null &&
                            plan.exerciseIDs.contains(option['id'])) {
                          selectedWorkoutPlanNames.add(plan.exerciseListName);
                        }
                      }

                      final belongsToWorkoutPlan =
                          selectedWorkoutPlanNames.isNotEmpty;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorProvider.accent.withOpacity(0.3)
                                : colorProvider.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(right: 16, left: 8),
                            title: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: colorProvider.accent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8), // zaokrąglone rogi
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: (exercise != null && exercise.iconPath.isNotEmpty)
                                        ? Image.asset(
                                      exercise.iconPath,
                                      width: 24,
                                      height: 24,
                                      color: colorProvider.accent,
                                    )
                                        : Icon(
                                      Icons.edit,
                                      color: colorProvider.accent,
                                    ),
                                    onPressed: () async {
                                      if (exercise != null) {
                                        await AddExerciseDialog.showExerciseInputDialog(
                                          context,
                                          isEditing: true,
                                          initialName: exercise.exerciseName,
                                          initialIconPath: exercise.iconPath,
                                          exerciseId: exercise.exerciseID,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    option['name'],
                                    style:
                                        TextStyle(color: colorProvider.accent),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            trailing: belongsToWorkoutPlan
                                ? Text(
                                    selectedWorkoutPlanNames.join(', '),
                                    style: TextStyle(
                                      color: colorProvider.accent,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                  )
                                : Icon(
                                    isSelected
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: colorProvider.accent,
                                  ),
                            onTap: () {
                              if (belongsToWorkoutPlan) return;

                              if (isFromWorkout) {
                                trainingSessionProvider.toggleOption(
                                    'Exercise', option['id']);
                              } else {
                                selectedOptionsProvider.toggleOption(
                                    'Exercise', option['id']);
                              }
                              setState(() {});
                            },
                            onLongPress: () async {
                              if (!isFromWorkout) {
                                final confirmed =
                                    await DeleteConfirmationDialog.show(
                                        context);
                                if (confirmed == true) {
                                  await ExerciseBox.deleteExercise(
                                      option['id']);
                                  setState(() {});
                                  SnackbarHelper.showSnackbar(
                                    context,
                                    t.tabBottomDrawer_refreshScreen,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (options.isNotEmpty) const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorProvider.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.add, color: colorProvider.accent),
                        title: Text(
                          t.tabBottomDrawer_addNewExercise,
                          style: TextStyle(color: colorProvider.accent),
                        ),
                        onTap: () {
                          AddExerciseDialog.showExerciseInputDialog(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
