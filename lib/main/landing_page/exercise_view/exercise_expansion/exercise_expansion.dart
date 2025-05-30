import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../data/workout_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/exercise_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../util/dialog/confirmation_dialog.dart';
import '../../../../util/dialog/text_input_dialog.dart';
import 'add_user_and_gym.dart';
import 'results_expansion/global_note.dart';
import 'icon_selection.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateExpansionState();
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateExpansionState();
  }

  void _updateExpansionState() {
    final selectedOptions = context.read<SelectedOptionsProvider>();
    final bool isSingleUserSelected = selectedOptions.user.isNotEmpty;
    final bool isSingleGymSelected = selectedOptions.gym.isNotEmpty;

    final shouldExpandBecauseEmptyFiltered = _shouldDimContainer(widget.workoutsForExercise);

    setState(() {
      _isExpanded = (isSingleUserSelected && isSingleGymSelected) || shouldExpandBecauseEmptyFiltered;
    });
  }

  // Filter workouts based on selected gym, user, and workout plan
  List<Workout> _filterWorkouts(List<Workout> workouts) {
    final selectedOptions = context.watch<SelectedOptionsProvider>();

    return workouts.where((workout) {
      final isGymSelected = selectedOptions.gym.isEmpty ||
          selectedOptions.gym.contains(workout.gymID);
      final isUserSelected = selectedOptions.user.isEmpty ||
          selectedOptions.user.contains(workout.userID);

      return isGymSelected && isUserSelected;
    }).toList();
  }

  void _showIconSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IconSelection(
          onIconSelected: (selectedIcon) {
            setState(() {
              selectedIconPath = selectedIcon;
              ExerciseBox.updateIconPath(widget.exerciseID, selectedIcon);
            });
          },
        );
      },
    );
  }

  void _openAddDrawer(BuildContext context) {
    final addDrawer = AddUserAndGym(widget.exerciseID);
    addDrawer.open(context);
  }

  bool _shouldDimContainer(List<Workout> workouts) {
    final selectedOptions = context.read<SelectedOptionsProvider>();
    final isFiltered =
        selectedOptions.user.isNotEmpty || selectedOptions.gym.isNotEmpty;
    return isFiltered && workouts.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // Localized text
    final colorProvider = context.watch<ColorProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final exercise = ExerciseBox.getAllExercises()
        .firstWhereOrNull((ex) => ex.exerciseID == widget.exerciseID);
    final String iconPath =
        selectedIconPath ?? exercise?.iconPath ?? 'assets/icons/default.png';
    final bottomMargin =
        widget.isLast ? (settingsProvider.getElementVisibility ? 80 : 16) : 8;

    // Filter the workouts based on selected gym, user, and workout plan
    final filteredWorkouts = _filterWorkouts(widget.workoutsForExercise);

    return GestureDetector(
      onLongPress: _isExpanded ? null : () => _confirmDeleteExercise(context),
      child: Opacity(
        opacity: _shouldDimContainer(filteredWorkouts) ? 0.6 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: colorProvider.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.fromLTRB(
              8, widget.isFirst ? 16 : 8, 8, bottomMargin.toDouble()),
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
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                initiallyExpanded: _isExpanded,
                onExpansionChanged: (expanded) {
                  // Update the expansion state dynamically when the tile is expanded or collapsed
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
                            child: GestureDetector(
                              onTap: () async {
                                final t = AppLocalizations.of(context)!;
                                final newName =
                                    await TextInputDialog.showTextInputDialog(
                                  context: context,
                                  title: t.exerciseExpansion_changeNameTitle,
                                  labelText: t.exerciseExpansion_enterNewName,
                                  initialText: exercise?.exerciseName ?? '',
                                );

                                if (newName != null && newName.isNotEmpty) {
                                  setState(() {
                                    exercise?.exerciseName = newName;
                                  });
                                }
                              },
                              child: Text(
                                (exercise?.exerciseName ??
                                        t.exerciseExpansion_unknownExercise)
                                    .toUpperCase(),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: colorProvider.accent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => _showIconSelection(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colorProvider.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:
                              buildExerciseIcon(iconPath, colorProvider.accent),
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  ...filteredWorkouts.mapIndexed((index, workout) {
                    final user = UserBox.getUserByID(workout.userID);
                    final gym = GymBox.getGym(workout.gymID);
                    final bool isWorkoutLast = index == filteredWorkouts.length - 1;

                    return Container(
                      decoration: BoxDecoration(
                        color: colorProvider.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.fromLTRB(16, index == 0 ? 0 : 8, 16, 8),
                      padding: const EdgeInsets.all(4.0),
                      child: ResultsExpansion(
                        workoutID: workout.workoutID,
                        quickValue: workout.quickValue,
                        userName: user?.username ?? t.exerciseExpansion_unknownUser,
                        gymName: gym?.name ?? t.exerciseExpansion_unknownGym,
                        iconPath: iconPath,
                        initiallyExpanded: false,
                        lastNoteDate:
                        WorkoutBox.getLatestNoteDate(workout.workoutID),
                        children: [
                          Divider(
                            color: colorProvider.accent.withOpacity(0.3),
                            endIndent: 4,
                            indent: 4,
                            thickness: 2,
                          ),
                          GlobalNote(
                            globalNote: workout.globalNote,
                            workoutID: workout.workoutID,
                          ),
                          Notes(
                            workoutID: workout.workoutID,
                            notes: workout.notes,
                          ),
                        ],
                      ),
                    );
                  }),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: colorProvider.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () => _openAddDrawer(context),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                t.exerciseExpansion_addUserGym,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: colorProvider.accent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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

    showConfirmationDialog(
      context: context,
      title: AppLocalizations.of(context)!.exerciseExpansion_deleteExercise,
      content: AppLocalizations.of(context)!.exerciseExpansion_confirmDelete,
      onConfirmed: () {
        exerciseProvider.deleteExercise(widget.exerciseID);
      },
    );
  }

  Widget buildExerciseIcon(String iconPath, Color accentColor) {
    if (iconPath.isEmpty) {
      return SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          Icons.edit_outlined,
          size: 24,
          color: accentColor,
        ),
      );
    } else {
      return Image.asset(
        iconPath,
        width: 36,
        height: 36,
        color: accentColor,
      );
    }
  }
}
