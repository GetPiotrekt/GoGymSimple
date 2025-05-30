import 'package:flutter/material.dart';
import '../data/workout_db.dart'; // Zaimportuj poprawną ścieżkę do WorkoutBox

class LandingPageProvider extends ChangeNotifier {
  /// Pobiera globalną notatkę z Hive dla danego treningu
  String getGlobalNote(int workoutID) {
    final workout = WorkoutBox.getWorkoutByID(workoutID);
    return workout?.globalNote ?? '';
  }

  /// Aktualizuje globalną notatkę w Hive i powiadamia listenerów
  Future<void> updateGlobalNote(int workoutID, String note) async {
    final workout = WorkoutBox.getWorkoutByID(workoutID);
    if (workout != null) {
      final updatedWorkout = Workout(
        workoutID: workout.workoutID,
        gymID: workout.gymID,
        userID: workout.userID,
        exerciseID: workout.exerciseID,
        globalNote: note, // Aktualizacja notatki
        quickValue: workout.quickValue,
        notes: workout.notes,
      );

      await WorkoutBox.box.put(workoutID, updatedWorkout);
      notifyListeners();
    }
  }
}
