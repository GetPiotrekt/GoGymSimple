import 'package:GoGymSimple/main/landing_page/exercise_view/exercise_expansion/exercise_expansion_helper/no_training_section.dart';
import 'package:GoGymSimple/main/landing_page/exercise_view/exercise_expansion/results_expansion/goal_and_best_set.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../data/workout/workout_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/exercise_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../util/dialog/confirmation_dialog.dart';
import '../exercise_stats_tile/exercise_stats_helper.dart';
import '../exercise_stats_tile/exercise_stats_tile.dart';
import 'exercise_expansion_helper/add_user_and_gym.dart';
import 'results_expansion/global_note.dart';
import 'results_expansion/notes/notes.dart';
import 'results_expansion/results_expansion.dart';

class ExerciseExpansion extends StatefulWidget {
  final int exerciseID;
  final List<Workout> workoutsForExercise;
  final bool isFirst;
  final bool isLast;

  const ExerciseExpansion({
    super.key,
    required this.exerciseID,
    required this.workoutsForExercise,
    required this.isFirst,
    required this.isLast,
  });

  @override
  _ExerciseExpansionState createState() => _ExerciseExpansionState();
}

class _ExerciseExpansionState extends State<ExerciseExpansion> {
  String? selectedIconPath;
  bool _isExpanded = false;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    final exercise = ExerciseBox.getAllExercises()
        .firstWhereOrNull((ex) => ex.exerciseID == widget.exerciseID);

    _noteController = TextEditingController(text: exercise?.note ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateExpansionState();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExpansionState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _updateExpansionState() {
    final selectedOptions = context.read<SelectedOptionsProvider>();
    final bool isSingleUserSelected = selectedOptions.user.length == 1;
    final bool isSingleGymSelected = selectedOptions.gym.length == 1;
    final bool isSingleExerciseSelected = selectedOptions.exercise.length == 1;

    setState(() {
      _isExpanded = isSingleUserSelected &&
          isSingleGymSelected ||
          isSingleExerciseSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = context.watch<ColorProvider>();
    final exercise = ExerciseBox.getAllExercises()
        .firstWhereOrNull((ex) => ex.exerciseID == widget.exerciseID);
    final String rawIconPath = selectedIconPath ?? exercise?.iconPath ?? '';
    final String iconPath = rawIconPath.trim();
    final workoutIDs = widget.workoutsForExercise.map((w) => w.workoutID).toList();
    final stats = ExerciseStatsHelper.getNoteStatisticsForWorkouts(workoutIDs);
    final totalNotes = stats['totalNotes'].toString();

    return GestureDetector(
      onLongPress: _isExpanded ? null : () => _confirmDeleteExercise(context),
      child: Opacity(
        opacity: widget.workoutsForExercise.isEmpty ? 0.7 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: colorProvider.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.fromLTRB(6, widget.isFirst ? 8 : 6, 6, 2),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                key: ValueKey(_isExpanded),
                iconColor: colorProvider.accent,
                collapsedIconColor: colorProvider.accent.withOpacity(0.7),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                initiallyExpanded: _isExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              exercise?.exerciseName ?? t.exerciseExpansion_unknownExercise,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorProvider.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (iconPath.isNotEmpty)
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colorProvider.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: buildExerciseIcon(iconPath, colorProvider.accent),
                        ),
                      ),
                  ],
                ),
                children: [
                  if (totalNotes != '0')
                    ExerciseStatsTile(
                      exerciseID: widget.exerciseID,
                      workoutIDs: workoutIDs,
                    ),
                  if (widget.workoutsForExercise.isEmpty)
                    NoTrainingSection(accentColor: colorProvider.accent)
                  else
                    ...widget.workoutsForExercise.mapIndexed((index, workout) {
                      final user = UserBox.getUserByID(workout.userID);
                      final gym = GymBox.getGym(workout.gymID);

                      return Container(
                        decoration: BoxDecoration(
                          color: colorProvider.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.fromLTRB(
                          10,
                          index == 0 ? 0 : 8,
                          10,
                          index == widget.workoutsForExercise.length - 1 ? 8 : 0,
                        ),
                        child: ResultsExpansion(
                          workoutID: workout.workoutID,
                          userName: user?.username ?? t.exerciseExpansion_unknownUser,
                          gymName: gym?.name ?? t.exerciseExpansion_unknownGym,
                          initiallyExpanded: false,
                          lastNoteDate: WorkoutBox.getLatestNoteDate(workout.workoutID),
                          bestSet: workout.getQuickValue('bestSet'),
                          goal: workout.getQuickValue('goal'),
                          children: [
                            Divider(
                              color: colorProvider.accent.withOpacity(0.2),
                              endIndent: 4,
                              indent: 4,
                              thickness: 2,
                            ),
                            GoalAndBestSet(workout: workout),
                            GlobalNote(
                              globalNote: workout.globalNote,
                              workoutID: workout.workoutID,
                            ),
                            Notes(
                              workoutID: workout.workoutID,
                              notes: workout.notes,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDeleteExercise(BuildContext context) {
    final exerciseProvider = context.read<ExerciseProvider>();

    ConfirmationDialog.show(
      context: context,
      title: AppLocalizations.of(context)!.exerciseExpansion_deleteExercise,
      content: AppLocalizations.of(context)!.exerciseExpansion_confirmDelete,
      onConfirmed: () {
        exerciseProvider.deleteExercise(widget.exerciseID);
      },
    );
  }

  Widget buildExerciseIcon(String iconPath, Color accentColor) {
    return Image.asset(
      iconPath,
      width: 32,
      height: 32,
      color: accentColor,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox.shrink();
      },
    );
  }
}
