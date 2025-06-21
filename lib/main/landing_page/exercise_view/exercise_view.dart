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
import '../landing_page.dart';
import '../sort_sector/sort_sector.dart';
import '../tab_sector/add_exercise.dart';
import 'exercise_expansion/exercise_expansion.dart';

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

      Future.delayed(Duration(milliseconds: i * 40), () {
        if (mounted) controller.forward();
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

    return Consumer<ExerciseProvider>(
      builder: (context, exerciseProvider, _) {
        final selectedOptions = context.watch<SelectedOptionsProvider>();

        final allExercises = exerciseProvider.allExercises;
        final groupedWorkouts = exerciseProvider.groupedWorkouts;

        // Filtrowanie workoutów według gym/user
        final filteredGroupedWorkouts = <int, List<Workout>>{};
        groupedWorkouts.forEach((exerciseID, workouts) {
          filteredGroupedWorkouts[exerciseID] = _filterWorkouts(selectedOptions, workouts);
        });

        final selectedExercises = selectedOptions.selectedOptionsExercise;
        final selectedWorkoutPlans = selectedOptions.selectedOptionsWorkoutPlan;

        // Dozwolone ćwiczenia na podstawie planów
        Set<int> allowedExerciseIDs = {};
        if (selectedWorkoutPlans.isNotEmpty) {
          for (final planID in selectedWorkoutPlans) {
            final listExercise = ListExerciseBox.getExerciseListByID(planID);
            if (listExercise != null) {
              allowedExerciseIDs.addAll(listExercise.exerciseIDs);
            }
          }
        }

        var showAllExercises = selectedExercises.isEmpty &&
            selectedWorkoutPlans.isEmpty &&
            selectedOptions.searchQuery.isEmpty;

        List<int> includedWithWorkouts = [];
        List<int> includedWithoutWorkouts = [];

        for (final exercise in allExercises) {
          final exerciseID = exercise.exerciseID;
          final hasWorkouts = (filteredGroupedWorkouts[exerciseID]?.isNotEmpty ?? false);

          final matchesSearch = selectedOptions.searchQuery.isEmpty ||
              exercise.exerciseName.toLowerCase().contains(selectedOptions.searchQuery.toLowerCase());

          final matchesWorkoutPlans = selectedWorkoutPlans.isEmpty ||
              allowedExerciseIDs.contains(exerciseID);

          final matchesExerciseFilter = selectedExercises.isEmpty ||
              selectedExercises.contains(exerciseID);

          final shouldInclude = matchesSearch && (selectedWorkoutPlans.isNotEmpty
              ? matchesWorkoutPlans
              : matchesExerciseFilter);

          if (shouldInclude) {
            if (hasWorkouts) {
              includedWithWorkouts.add(exerciseID);
            } else {
              includedWithoutWorkouts.add(exerciseID);
            }
          }
        }

        showAllExercises = selectedExercises.isEmpty &&
            selectedWorkoutPlans.isEmpty &&
            selectedOptions.searchQuery.isEmpty;

        List<int> showOnlyWithoutFilters = [];
        if (showAllExercises) {
          for (final exercise in allExercises) {
            final exerciseID = exercise.exerciseID;
            final hasWorkouts = (filteredGroupedWorkouts[exerciseID]?.isNotEmpty ?? false);

            final isAlreadyIncluded = includedWithWorkouts.contains(exerciseID) ||
                includedWithoutWorkouts.contains(exerciseID);
            if (!isAlreadyIncluded) {
              if (hasWorkouts) {
                includedWithWorkouts.add(exerciseID);
              } else {
                showOnlyWithoutFilters.add(exerciseID);
              }
            }
          }
        }

        // Sortowanie
        sortByName(a, b) {
          final nameA = (ExerciseBox.getExercisebyID(a)?.exerciseName ?? t.unknownExercise).toLowerCase();
          final nameB = (ExerciseBox.getExercisebyID(b)?.exerciseName ?? t.unknownExercise).toLowerCase();
          return selectedOptions.sortExerciseView == "zToA"
              ? nameB.compareTo(nameA)
              : nameA.compareTo(nameB);
        }

        includedWithWorkouts.sort(sortByName);
        includedWithoutWorkouts.sort(sortByName);
        showOnlyWithoutFilters.sort(sortByName);

        final includedExercises = [
          ...includedWithWorkouts,
          ...includedWithoutWorkouts,
        ];
        includedExercises.sort(sortByName);

        // Oddziel ćwiczenia wybrane w filtrze ćwiczeń
        final filteredExercises = includedExercises
            .where((id) => selectedExercises.contains(id))
            .toList();

        final otherExercises = includedExercises
            .where((id) => !selectedExercises.contains(id))
            .toList();

// Posortuj obie grupy niezależnie
        filteredExercises.sort(sortByName);
        otherExercises.sort(sortByName);

// Połącz tak, aby te z filtra były na górze
        final sortedIncludedExercises = [
          ...filteredExercises,
          ...otherExercises,
        ];

        final allExerciseIDsToShow = [
          ...sortedIncludedExercises,
          ...showOnlyWithoutFilters,
        ];
        allExerciseIDsToShow.sort(sortByName);

        _initAnimations(allExerciseIDsToShow.length + 1);


        if (allExerciseIDsToShow.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SortSector(),
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
                        Icon(
                          Icons.info_outline,
                          size: 48,
                          color: colorProvider.accent,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          t.exerciseView_noExercisesMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorProvider.accent),
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

                    if (index == 0) return const SortSector();

                    if (index == allExerciseIDsToShow.length + 1) {
                      if (selectedOptions.selectedOptionsExercise.isNotEmpty) {
                        return const SizedBox.shrink();
                      }

                      final buttonIndex = allExerciseIDsToShow.length; // ostatnia animacja

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
  }
}
