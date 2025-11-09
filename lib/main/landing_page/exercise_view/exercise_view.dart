import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/exercise_provider.dart';
import '../../../provider/selected_options_provider.dart';
import '../../../provider/settings_provider.dart';
import '../sort_sector/sort_sector.dart';
import '../tab_sector/add_exercise.dart';
import 'exercise_expansion/exercise_expansion.dart';
import 'exercise_expansion/exercise_expansion_helper/no_training_section.dart';
import 'exercise_filter_utils.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _offsetAnimations = [];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<bool> _hasNoWorkouts() async {
    final workouts = WorkoutBox.getAllWorkouts();
    return workouts.isEmpty;
  }

  void _initAnimations(int count) {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
    _offsetAnimations.clear();

    for (int i = 0; i < count; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      );

      final animation = Tween<Offset>(
        begin: const Offset(0.0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ));

      _controllers.add(controller);
      _offsetAnimations.add(animation);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          controller.forward();
        }
      });
    }
  }

  // Filtrowanie workoutów według siłowni i użytkownika (jeśli puste to zwróć wszystko)
  List<Workout> _filterWorkouts(SelectedOptionsProvider selectedOptions, List<Workout> workouts) {
    if (selectedOptions.gym.isEmpty && selectedOptions.user.isEmpty) {
      return workouts;
    }

    return workouts.where((workout) {
      final isGymSelected = selectedOptions.gym.isEmpty || selectedOptions.gym.contains(workout.gymID);
      final isUserSelected = selectedOptions.user.isEmpty || selectedOptions.user.contains(workout.userID);
      return isGymSelected && isUserSelected;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = context.watch<ColorProvider>();

    return FutureBuilder<bool>(
      future: _hasNoWorkouts(),
      builder: (context, snapshot) {
        final hasNoWorkouts = snapshot.data ?? false;

        return Consumer<ExerciseProvider>(
          builder: (context, exerciseProvider, _) {
            final selectedOptions = context.watch<SelectedOptionsProvider>();

            final allExercises = exerciseProvider.allExercises;
            final groupedWorkouts = exerciseProvider.groupedWorkouts;

            final filteredGroupedWorkouts = <int, List<Workout>>{};
            groupedWorkouts.forEach((exerciseID, workouts) {
              filteredGroupedWorkouts[exerciseID] = _filterWorkouts(selectedOptions, workouts);
            });

            final allExerciseIDsToShow = ExerciseFilterUtils.getSortedExerciseIDs(
              selectedOptions: selectedOptions,
              allExercises: allExercises,
              groupedWorkouts: groupedWorkouts,
              t: t,
            );
            _initAnimations(allExerciseIDsToShow.length + 1);

            if (allExerciseIDsToShow.isEmpty) {
              final bool filtersAreActive = selectedOptions.gym.isNotEmpty || selectedOptions.user.isNotEmpty;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SortSector(),
                  if (hasNoWorkouts) NoTrainingSection(accentColor: colorProvider.accent),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: colorProvider.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.info_outline, size: 48, color: colorProvider.accent),
                            const SizedBox(height: 16),
                            Text(
                              filtersAreActive
                                  ? t.historyView_noWorkoutNotesFilteredMessage
                                  : t.exerciseView_noExercisesMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorProvider.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context.read<ExerciseProvider>().refreshData();
                    },
                    child: ListView.builder(
                      itemCount: allExerciseIDsToShow.length + 3,
                      itemBuilder: (context, index) {
                        final settingsProvider = context.watch<SettingsProvider>();
                        final bottomMargin = (settingsProvider.getElementVisibility ? 80 : 8);

                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SortSector(),
                              if (hasNoWorkouts) NoTrainingSection(accentColor: colorProvider.accent, isGlobal: true),
                            ],
                          );
                        }

                        if (index == allExerciseIDsToShow.length + 1) {
                          if (selectedOptions.selectedOptionsExercise.isNotEmpty) {
                            return const SizedBox.shrink();
                          }

                          final buttonIndex = allExerciseIDsToShow.length;

                          return SlideTransition(
                            position: _offsetAnimations[buttonIndex],
                            child: FadeTransition(
                              opacity: _controllers[buttonIndex],
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      AddExerciseDialog.showExerciseInputDialog(context);
                                    },
                                    icon: const Icon(Icons.add),
                                    label: Text(t.addWorkoutPlan_addNewExercise),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: colorProvider.secondary,
                                      foregroundColor: colorProvider.accent,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        if (index == allExerciseIDsToShow.length + 2) {
                          return SizedBox(height: bottomMargin.toDouble());
                        }

                        final exerciseIndex = index - 1;
                        final exerciseID = allExerciseIDsToShow[exerciseIndex];
                        final workoutsForExercise = filteredGroupedWorkouts[exerciseID] ?? [];
                        final isLast = exerciseIndex == allExerciseIDsToShow.length - 1;

                        return SlideTransition(
                          position: _offsetAnimations[exerciseIndex],
                          child: FadeTransition(
                            opacity: _controllers[exerciseIndex],
                            child: ExerciseExpansion(
                              exerciseID: exerciseID,
                              workoutsForExercise: workoutsForExercise,
                              isFirst: exerciseIndex == 0,
                              isLast: isLast,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
