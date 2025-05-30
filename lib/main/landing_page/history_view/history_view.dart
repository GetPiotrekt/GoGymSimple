import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/workout_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../sort_sector/sort_sector.dart';
import 'history_card.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<Map<String, dynamic>> allNotesWithWorkout = [];
  List<Map<String, dynamic>> filteredNotesWithWorkout = [];
  late SelectedOptionsProvider selectedOptionsProvider;
  Map<String, List<Map<String, dynamic>>> groupedNotesWithWorkout = {};

  @override
  void initState() {
    super.initState();
    selectedOptionsProvider = context.read<SelectedOptionsProvider>();
    selectedOptionsProvider.addListener(_applyFiltersAndSorting);
    _loadWorkouts();
  }

  @override
  void dispose() {
    selectedOptionsProvider.removeListener(_applyFiltersAndSorting);
    super.dispose();
  }

  Map<String, List<Map<String, dynamic>>> _groupByDate(
      List<Map<String, dynamic>> notes) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final note in notes) {
      final date = DateTime.parse(note['note']['date']);
      final dateKey = DateFormat('yyyy-MM-dd').format(date);
      grouped.putIfAbsent(dateKey, () => []).add(note);
    }
    return grouped;
  }

  void _applyFiltersAndSorting() {
    final selectedGyms = selectedOptionsProvider.gym;
    final selectedUsers = selectedOptionsProvider.user;
    final selectedExercises = selectedOptionsProvider.exercise;
    final selectedWorkoutPlans = selectedOptionsProvider.workoutPlan;
    final sortOrder = selectedOptionsProvider.sortHistoryView;

    setState(() {
      filteredNotesWithWorkout = allNotesWithWorkout.where((data) {
        final workout = data['workout'];

        final gymMatch = selectedGyms.isEmpty || selectedGyms.contains(workout.gymID);
        final userMatch = selectedUsers.isEmpty || selectedUsers.contains(workout.userID);

        bool exerciseMatch = true;

        if (selectedWorkoutPlans.isNotEmpty) {
          final listExerciseIDs = selectedOptionsProvider.workoutPlan;

          // Zbierz dozwolone exerciseIDs z wybranych planów treningowych
          Set<int> allowedExerciseIDs = {};
          if (selectedWorkoutPlans.isNotEmpty) {
            for (final planID in selectedWorkoutPlans) {
              final listExercise = ListExerciseBox.getExerciseListByID(planID);
              if (listExercise != null) {
                allowedExerciseIDs.addAll(listExercise.exerciseIDs);
              }
            }
          }

          exerciseMatch = allowedExerciseIDs.contains(workout.exerciseID);
        } else if (selectedExercises.isNotEmpty) {
          exerciseMatch = selectedExercises.contains(workout.exerciseID);
        }

        return gymMatch && userMatch && exerciseMatch;
      }).toList();

      groupedNotesWithWorkout = _groupByDate(filteredNotesWithWorkout);

      filteredNotesWithWorkout.sort((a, b) {
        final dateA = DateTime.parse(a['note']['date']);
        final dateB = DateTime.parse(b['note']['date']);
        return sortOrder == 'Newest'
            ? dateB.compareTo(dateA)
            : dateA.compareTo(dateB);
      });
    });
  }

  Future<void> _loadWorkouts() async {
    final allWorkouts = WorkoutBox.getAllWorkouts();
    setState(() {
      allNotesWithWorkout = allWorkouts.expand((workout) {
        return workout.notes.map((note) => {
              'note': note,
              'workout': workout,
            });
      }).toList();
      _applyFiltersAndSorting();
    });
  }

  bool _anyFilterActive() {
    return selectedOptionsProvider.gym.isNotEmpty ||
        selectedOptionsProvider.user.isNotEmpty ||
        selectedOptionsProvider.exercise.isNotEmpty ||
        selectedOptionsProvider.workoutPlan.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final dateKeys = groupedNotesWithWorkout.keys.toList()
      ..sort((a, b) => selectedOptionsProvider.sortHistoryView == 'newest'
          ? b.compareTo(a)
          : a.compareTo(b));

    return Scaffold(
      backgroundColor: colorProvider.primary,
      body: filteredNotesWithWorkout.isEmpty
          ? Column(
        children: [
          const SortSector(),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
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
                      _anyFilterActive()
                          ? t.historyView_noWorkoutNotesFilteredMessage
                          : t.historyView_noWorkoutNotesMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorProvider.accent),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )

          : ListView(
        children: [
          const SortSector(),
          ...() {
            final List<Widget> widgets = [];
            int globalIndex = 0;
            final totalNotes = filteredNotesWithWorkout.length;

            for (final dateKey in dateKeys) {
              final date = DateTime.parse(dateKey);
              final locale = Localizations.localeOf(context).toString();
              final formattedDate =
              DateFormat("d MMM yyyy", locale).format(date);

              final notes = groupedNotesWithWorkout[dateKey]!;

              widgets.add(
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                  decoration: BoxDecoration(
                    color: colorProvider.accent,
                  ),
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorProvider.secondary,
                    ),
                  ),
                ),
              );

              for (int i = 0; i < notes.length; i++) {
                final isLast = globalIndex == totalNotes - 1;
                widgets.add(
                  HistoryCard(
                    noteData: notes[i],
                    index: i,
                    listLength: notes.length,
                    isLast: isLast,
                  ),
                );
                globalIndex++;
              }
            }

            return widgets;
          }(),
        ],
      ),
    );

  }
}
