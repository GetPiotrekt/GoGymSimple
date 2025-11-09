import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../sort_sector/sort_sector.dart';
import 'calendar_selector.dart';
import 'history_notes_container.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with TickerProviderStateMixin {
  List<Map<String, dynamic>> allNotesWithWorkout = [];
  List<Map<String, dynamic>> filteredNotesWithWorkout = [];
  late SelectedOptionsProvider selectedOptionsProvider;

  Map<String, Map<String, List<Map<String, dynamic>>>> groupedByDateAndUserGym = {};

  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _offsetAnimations = [];

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
    for (var controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
    _offsetAnimations.clear();
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
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );

      final animation = Tween<Offset>(
        begin: const Offset(0.0, 0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ));

      _controllers.add(controller);
      _offsetAnimations.add(animation);

      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) controller.forward();
      });
    }
  }

  void _groupByDateAndUserGym(List<Map<String, dynamic>> notes) {
    final Map<String, Map<String, List<Map<String, dynamic>>>> grouped = {};
    for (final note in notes) {
      final date = DateTime.parse(note['note']['date']);
      final dateKey = DateFormat('yyyy-MM-dd').format(date);

      final workout = note['workout'];
      final userID = workout.userID.toString();
      final gymID = workout.gymID.toString();

      final userGymKey = '${userID}_$gymID';

      grouped.putIfAbsent(dateKey, () => {});
      grouped[dateKey]!.putIfAbsent(userGymKey, () => []);
      grouped[dateKey]![userGymKey]!.add(note);
    }
    groupedByDateAndUserGym = grouped;
  }

  void _applyFiltersAndSorting() {
    if (!mounted) return;

    final selectedGyms = selectedOptionsProvider.gym;
    final selectedUsers = selectedOptionsProvider.user;
    final selectedExercises = selectedOptionsProvider.exercise;
    final selectedWorkoutPlans = selectedOptionsProvider.workoutPlan;
    final sortOrder = selectedOptionsProvider.sortHistoryView;

    final filtered = allNotesWithWorkout.where((data) {
      final workout = data['workout'];

      final gymMatch = selectedGyms.isEmpty || selectedGyms.contains(workout.gymID);
      final userMatch = selectedUsers.isEmpty || selectedUsers.contains(workout.userID);

      bool exerciseMatch = true;

      if (selectedWorkoutPlans.isNotEmpty) {
        Set<int> allowedExerciseIDs = {};
        for (final planID in selectedWorkoutPlans) {
          final listExercise = ListExerciseBox.getExerciseListByID(planID);
          if (listExercise != null) {
            allowedExerciseIDs.addAll(listExercise.exerciseIDs);
          }
        }
        exerciseMatch = allowedExerciseIDs.contains(workout.exerciseID);
      } else if (selectedExercises.isNotEmpty) {
        exerciseMatch = selectedExercises.contains(workout.exerciseID);
      }

      return gymMatch && userMatch && exerciseMatch;
    }).toList();

    filtered.sort((a, b) {
      final dateA = DateTime.parse(a['note']['date']);
      final dateB = DateTime.parse(b['note']['date']);
      return sortOrder!.toLowerCase() == 'newest'
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    if (!mounted) return;
    setState(() {
      filteredNotesWithWorkout = filtered;
      _groupByDateAndUserGym(filteredNotesWithWorkout);
      _initAnimations(groupedByDateAndUserGym.length);
    });
  }

  Future<void> _loadWorkouts() async {
    final allWorkouts = WorkoutBox.getAllWorkouts();
    if (!mounted) return;
    setState(() {
      allNotesWithWorkout = allWorkouts.expand((workout) {
        return workout.notes.map((note) {
          return {
            'note': note,
            'workout': workout,
          };
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

    final dateKeys = groupedByDateAndUserGym.keys.toList()
      ..sort((a, b) => selectedOptionsProvider.sortHistoryView!.toLowerCase() == 'newest'
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
                    Icon(Icons.info_outline, size: 48, color: colorProvider.accent),
                    const SizedBox(height: 16),
                    Text(
                      _anyFilterActive()
                          ? t.historyView_noWorkoutNotesFilteredMessage
                          : t.historyView_noWorkoutNotesMessage,
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
      )
          : RefreshIndicator(
        onRefresh: _loadWorkouts,
        child: ListView(
          children: [
            const SortSector(),
            /*CalendarSelector(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              groupedByDateAndUserGym: groupedByDateAndUserGym,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                final selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDay);
                if (groupedByDateAndUserGym.containsKey(selectedDateStr)) {
                  final filtered = allNotesWithWorkout.where((note) {
                    final date = DateTime.parse(note['note']['date']);
                    return DateFormat('yyyy-MM-dd').format(date) == selectedDateStr;
                  }).toList();

                  setState(() {
                    filteredNotesWithWorkout = filtered;
                    _groupByDateAndUserGym(filteredNotesWithWorkout);
                    _initAnimations(groupedByDateAndUserGym.length);
                  });
                }
              },
            ),  */
            ...List.generate(dateKeys.length, (i) {
              final dateKey = dateKeys[i];
              final date = DateTime.parse(dateKey);
              final locale = Localizations.localeOf(context).toString();
              final formattedDate = DateFormat("d MMM yyyy", locale).format(date);

              final userGymGroups = groupedByDateAndUserGym[dateKey]!;

              return SlideTransition(
                position: _offsetAnimations[i],
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      margin: const EdgeInsets.fromLTRB(0, 12, 0, 4),
                      decoration: BoxDecoration(color: colorProvider.accent),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorProvider.secondary,
                        ),
                      ),
                    ),
                    ...userGymGroups.entries.map((entry) {
                      final userGymKey = entry.key;
                      final notes = entry.value;
                      final isLastGroup = i == dateKeys.length - 1 &&
                          userGymKey == userGymGroups.keys.last;

                      return GroupedNotesContainer(
                        notes: notes,
                        isLastGroup: isLastGroup,
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
