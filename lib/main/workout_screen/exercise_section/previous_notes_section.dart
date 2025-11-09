import 'package:flutter/material.dart';
import '../../../data/data_tab_sector/gym_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../provider/color_provider.dart';
import '../../landing_page/exercise_view/exercise_expansion/results_expansion/global_note.dart';
import '../../landing_page/exercise_view/exercise_expansion/results_expansion/goal_and_best_set.dart';
import '../../landing_page/exercise_view/exercise_expansion/results_expansion/notes/notes.dart';

class PreviousNotesSection extends StatefulWidget {
  final Workout initialWorkout;
  final ColorProvider colorProvider;

  const PreviousNotesSection({
    super.key,
    required this.initialWorkout,
    required this.colorProvider,
  });

  @override
  State<PreviousNotesSection> createState() => _PreviousNotesSectionState();
}

class _PreviousNotesSectionState extends State<PreviousNotesSection> {
  late Gym? currentGym;
  late int userID;
  late int exerciseID;

  @override
  void initState() {
    super.initState();
    userID = widget.initialWorkout.userID;
    exerciseID = widget.initialWorkout.exerciseID;

    // Pobranie siłowni
    currentGym = GymBox.getGym(widget.initialWorkout.gymID);
    currentGym ??= GymBox.getGym(1) ?? GymBox.getAllGyms().firstOrNull;
  }

  void _autoChangeGym() {
    final allGyms = GymBox.getAllGyms();
    if (allGyms.length <= 1) return;

    final currentIndex = allGyms.indexWhere((gym) => gym.gymID == currentGym?.gymID);
    final nextIndex = (currentIndex + 1) % allGyms.length;

    setState(() {
      currentGym = allGyms[nextIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final gyms = GymBox.getAllGyms();

    final matchingWorkout = WorkoutBox.getAllWorkouts().firstWhere(
          (w) =>
      w.userID == userID &&
          w.exerciseID == exerciseID &&
          w.gymID == currentGym?.gymID,
      orElse: () => Workout(
        workoutID: -1,
        gymID: currentGym?.gymID ?? -1,
        userID: userID,
        exerciseID: exerciseID,
        globalNote: '',
        quickValue: '',
        notes: [],
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 12),
      decoration: BoxDecoration(
        color: widget.colorProvider.accent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.colorProvider.accent.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.fitness_center, color: widget.colorProvider.accent, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      currentGym?.name ?? 'Nieznana siłownia',
                      key: ValueKey(currentGym?.gymID),
                      style: TextStyle(
                        color: widget.colorProvider.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (gyms.length > 1)
                  GestureDetector(
                    onTap: _autoChangeGym,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.sync_alt,
                        color: widget.colorProvider.accent,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(color: widget.colorProvider.accent.withOpacity(0.2), thickness: 1.5),
          Column(
            key: ValueKey(currentGym?.gymID),
            children: [
              GoalAndBestSet(
                workout: matchingWorkout,
              ),
              GlobalNote(
                globalNote: matchingWorkout.globalNote,
                workoutID: matchingWorkout.workoutID,
              ),
              Notes(
                isFromWorkout: true,
                workoutID: matchingWorkout.workoutID,
                notes: matchingWorkout.notes,
              ),
            ],
          ),
        ],
      ),

    );
  }
}
