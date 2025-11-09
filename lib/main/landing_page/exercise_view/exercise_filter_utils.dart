
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/selected_options_provider.dart';

class ExerciseFilterUtils {
  /// Filtrowanie workoutów po gym/user
  static List<Workout> filterWorkouts(SelectedOptionsProvider selectedOptions, List<Workout> workouts) {
    if (selectedOptions.gym.isEmpty && selectedOptions.user.isEmpty) return workouts;

    return workouts.where((workout) {
      final gymOK = selectedOptions.gym.isEmpty || selectedOptions.gym.contains(workout.gymID);
      final userOK = selectedOptions.user.isEmpty || selectedOptions.user.contains(workout.userID);
      return gymOK && userOK;
    }).toList();
  }

  /// Główna logika do filtrowania i sortowania
  static List<int> getSortedExerciseIDs({
    required SelectedOptionsProvider selectedOptions,
    required List<Exercise> allExercises,
    required Map<int, List<Workout>> groupedWorkouts,
    required AppLocalizations t,
  }) {
    final selectedExercises = selectedOptions.selectedOptionsExercise;
    final selectedWorkoutPlans = selectedOptions.selectedOptionsWorkoutPlan;

    Set<int> allowedExerciseIDs = {};
    if (selectedWorkoutPlans.isNotEmpty) {
      for (final planID in selectedWorkoutPlans) {
        final listExercise = ListExerciseBox.getExerciseListByID(planID);
        if (listExercise != null) {
          allowedExerciseIDs.addAll(listExercise.exerciseIDs);
        }
      }
    }

    final bool showAll = selectedOptions.gym.isEmpty && selectedOptions.user.isEmpty;

    List<int> includedWithWorkouts = [];
    List<int> includedWithoutWorkouts = [];

    for (final exercise in allExercises) {
      final id = exercise.exerciseID;
      final workouts = groupedWorkouts[id] ?? [];

      // Jeśli wybrano siłownię/użytkownika → ignoruj ćwiczenia bez pasujących workoutów
      if (!showAll) {
        final hasValidWorkout = workouts.any((workout) {
          final gymOK = selectedOptions.gym.isEmpty || selectedOptions.gym.contains(workout.gymID);
          final userOK = selectedOptions.user.isEmpty || selectedOptions.user.contains(workout.userID);
          return gymOK && userOK;
        });

        if (!hasValidWorkout) continue;
      }

      final matchesSearch = exercise.exerciseName.toLowerCase().contains(selectedOptions.searchQuery.toLowerCase());
      final matchesWorkoutPlans = selectedWorkoutPlans.isEmpty || allowedExerciseIDs.contains(id);
      final matchesExerciseFilter = selectedExercises.isEmpty || selectedExercises.contains(id);

      final shouldInclude = matchesSearch &&
          (selectedWorkoutPlans.isNotEmpty ? matchesWorkoutPlans : matchesExerciseFilter);

      if (shouldInclude) {
        if ((groupedWorkouts[id]?.isNotEmpty ?? false)) {
          includedWithWorkouts.add(id);
        } else {
          includedWithoutWorkouts.add(id);
        }
      }
    }

    // Jeżeli nie ma żadnych filtrów → pokaż wszystko
    List<int> showOnlyWithoutFilters = [];
    if (showAll && selectedExercises.isEmpty && selectedWorkoutPlans.isEmpty) {
      for (final exercise in allExercises) {
        final id = exercise.exerciseID;
        if (!includedWithWorkouts.contains(id) && !includedWithoutWorkouts.contains(id)) {
          if ((groupedWorkouts[id]?.isNotEmpty ?? false)) {
            includedWithWorkouts.add(id);
          } else {
            showOnlyWithoutFilters.add(id);
          }
        }
      }
    }

    // Sortowanie
    int sortByName(int a, int b) {
      final nameA = (ExerciseBox.getExercisebyID(a)?.exerciseName ?? t.unknownExercise).toLowerCase();
      final nameB = (ExerciseBox.getExercisebyID(b)?.exerciseName ?? t.unknownExercise).toLowerCase();
      return selectedOptions.sortExerciseView == "zToA" ? nameB.compareTo(nameA) : nameA.compareTo(nameB);
    }

    final included = [...includedWithWorkouts, ...includedWithoutWorkouts];
    final filtered = included.where((id) => selectedExercises.contains(id)).toList()..sort(sortByName);
    final rest = included.where((id) => !selectedExercises.contains(id)).toList()..sort(sortByName);
    final sortedIncluded = [...filtered, ...rest];

    final result = [...sortedIncluded, ...showOnlyWithoutFilters]..sort(sortByName);
    return result;
  }
}
