import 'package:flutter/material.dart';
import '../../../../data/workout/workout_db.dart';
import '../../../../provider/color_provider.dart';

class ExerciseStatsHelper {
  static Map<String, dynamic> getNoteStatisticsForWorkouts(List<int> workoutIDs) {
    int totalNotes = 0;
    int totalLines = 0;
    int totalChars = 0;

    for (int id in workoutIDs) {
      final workout = WorkoutBox.getWorkoutByID(id);
      if (workout == null) continue;

      for (var noteEntry in workout.notes) {
        final note = noteEntry['note'] as String? ?? '';
        if (note.trim().isEmpty) continue;
        totalNotes++;
        totalLines += '\n'.allMatches(note).length + 1;
        totalChars += note.length;
      }
    }

    final avgLines = totalNotes > 0 ? totalLines / totalNotes : 0;
    final avgChars = totalNotes > 0 ? totalChars / totalNotes : 0;

    return {
      'totalNotes': totalNotes,
      'averageLinesPerNote': avgLines,
      'averageCharsPerNote': avgChars,
      'totalLines': totalLines,     // ✅ Dodane
      'totalChars': totalChars,     // ✅ Dodane
    };
  }

  static String formatToOneDecimal(String numberString) {
    final value = double.tryParse(numberString);
    if (value == null) return '';

    // Jeśli liczba jest całkowita (np. 5.0), pokaż jako int
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(1);
  }

  static Widget buildStatItem(BuildContext context, String label, String value, ColorProvider colorProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              label,
              style: TextStyle(color: colorProvider.accent.withOpacity(0.7)),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorProvider.accent,
            ),
          ),
        ],
      ),
    );
  }

  static Map<String, int> getTrainingDaysBreakdown(int exerciseID) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final workouts = WorkoutBox.getAllWorkouts();

    final daysLastWeek = <String>{};
    final daysThisMonth = <String>{};
    final daysThisYear = <String>{};

    for (final workout in workouts) {
      if (workout.exerciseID != exerciseID) continue;

      for (final note in workout.notes) {
        if (note.containsKey('date')) {
          final date = DateTime.tryParse(note['date']);
          if (date == null) continue;

          final justDate = '${date.year}-${date.month}-${date.day}';

          if (date.isAfter(sevenDaysAgo)) {
            daysLastWeek.add(justDate);
          }

          if (date.year == now.year && date.month == now.month) {
            daysThisMonth.add(justDate);
          }

          if (date.year == now.year) {
            daysThisYear.add(justDate);
          }
        }
      }
    }

    return {
      'lastWeek': daysLastWeek.length,
      'thisMonth': daysThisMonth.length,
      'thisYear': daysThisYear.length,
    };
  }


}
