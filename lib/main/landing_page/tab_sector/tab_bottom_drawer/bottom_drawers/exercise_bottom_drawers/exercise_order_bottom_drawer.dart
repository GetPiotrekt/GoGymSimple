import 'package:GoGymSimple/data/data_tab_sector/exercise_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';
import '../../../../../../provider/workout_provider.dart';
import '../../../../../../util/bottom_sheet/bottom_sheet.dart';

class ExerciseOrderBottomDrawer {
  final ColorProvider colorProvider;

  ExerciseOrderBottomDrawer({required this.colorProvider});

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
        return Consumer2<WorkoutProvider, ColorProvider>(
          builder: (context, workoutProvider, colorProvider, child) {
            final exercises = workoutProvider.selectedExercises;

            return BottomSheetTemplate(
              onPressed: () => Navigator.pop(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      t.tabBottomDrawer_reorderExercises,
                      style: TextStyle(
                        fontSize: 22,
                        color: colorProvider.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ReorderableListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false, // wyłączamy domyślne
                    proxyDecorator: (child, index, animation) {
                      return Material(
                        color: Colors.transparent,
                        child: Opacity(
                          opacity:
                              0.6, // półprzezroczystość elementu w trakcie przesuwania
                          child: child,
                        ),
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      workoutProvider.reorderExercises(oldIndex, newIndex);
                    },
                    children: [
                      for (final exercise in exercises)
                        ReorderableDragStartListener(
                          key: ValueKey(exercise.exerciseID),
                          index: exercises.indexOf(exercise),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colorProvider.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              leading: (exercise.iconPath.isNotEmpty)
                                  ? Image.asset(
                                      exercise.iconPath,
                                      width: 28,
                                      height: 28,
                                      color: colorProvider.accent,
                                    )
                                  : Icon(Icons.fitness_center,
                                      color: colorProvider.accent),
                              title: Text(
                                exercise.exerciseName,
                                style: TextStyle(color: colorProvider.accent),
                              ),
                              trailing: Icon(
                                Icons.menu,
                                color: colorProvider.accent,
                              ),
                            ),
                          ),
                        ),
                    ],
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
