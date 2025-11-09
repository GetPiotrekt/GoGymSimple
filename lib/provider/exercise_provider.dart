import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/data_tab_sector/exercise_db.dart';
import '../data/workout/workout_db.dart';

class ExerciseProvider extends ChangeNotifier {
  List<Exercise> _allExercises = [];
  List<Workout> _allWorkouts = [];
  Map<int, List<Workout>> _groupedWorkouts = {};

  List<Exercise> get allExercises => _allExercises;
  List<Workout> get allWorkouts => _allWorkouts;
  Map<int, List<Workout>> get groupedWorkouts => _groupedWorkouts;

  ExerciseProvider() {
    _loadData();

    // Nasłuchujemy zmian w Hive i odświeżamy dane
    WorkoutBox.box.listenable().addListener(() => _loadData());
    ExerciseBox.box.listenable().addListener(() => _loadData());
  }

  void _loadData() {
    print("Loading data...");

    _allExercises = ExerciseBox.getAllExercises();
    _allWorkouts = WorkoutBox.box.values.toList();

    // Grupowanie treningów według ID ćwiczenia
    _groupedWorkouts = {};
    for (var workout in _allWorkouts) {
      _groupedWorkouts.putIfAbsent(workout.exerciseID, () => []).add(workout);
    }

    notifyListeners();
  }

  // Funkcja do usuwania ćwiczenia
  Future<void> deleteExercise(int exerciseID) async {
    try {
      // Usuń powiązane treningi
      final workoutsToDelete = _allWorkouts.where((workout) => workout.exerciseID == exerciseID).toList();

      for (var workout in workoutsToDelete) {
        // Usuń trening z bazy danych
        await WorkoutBox.deleteWorkout(workout.workoutID);
        // Usuń trening z listy
        _allWorkouts.remove(workout);
      }

      // Usuń ćwiczenie z bazy danych
      await ExerciseBox.deleteExercise(exerciseID);

      // Usuń ćwiczenie z listy ćwiczeń w providerze
      _allExercises.removeWhere((exercise) => exercise.exerciseID == exerciseID);

      // Zaktualizuj grupowanie treningów
      _groupedWorkouts.remove(exerciseID);

      notifyListeners();
    } catch (e) {
      print('Error deleting exercise and its related data: $e');
    }
  }

  // Funkcja do usuwania treningu
  void deleteWorkout(int workoutID) {
    // Usuń trening z bazy danych
    WorkoutBox.deleteWorkout(workoutID);

    // Usuń trening z listy treningów w providerze
    _allWorkouts.removeWhere((workout) => workout.workoutID == workoutID);

    // Zaktualizuj grupowanie treningów
    _groupedWorkouts.clear();
    for (var workout in _allWorkouts) {
      _groupedWorkouts.putIfAbsent(workout.exerciseID, () => []).add(workout);
    }

    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    _allExercises.add(exercise);
    notifyListeners();
  }

  @override
  void dispose() {
    WorkoutBox.box.listenable().removeListener(_loadData);
    ExerciseBox.box.listenable().removeListener(_loadData);
    super.dispose();
  }

  Future<void> refreshData() async {
    _loadData();
  }
}
