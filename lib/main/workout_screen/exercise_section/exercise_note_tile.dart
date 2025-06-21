import 'package:GoGymSimple/main/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/selected_options_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../landing_page/exercise_view/exercise_view.dart';

class ExerciseNoteTile extends StatefulWidget {
  final String title;
  final int exerciseID;
  final int userID;
  final TextEditingController controller;
  final VoidCallback? onInfoTap;

  const ExerciseNoteTile({
    super.key,
    required this.title,
    required this.exerciseID,
    required this.userID,
    required this.controller,
    this.onInfoTap,
  });

  @override
  State<ExerciseNoteTile> createState() => _ExerciseNoteTileState();
}

class _ExerciseNoteTileState extends State<ExerciseNoteTile> {
  bool _isEditing = false;
  bool _suppressNextEdit = false; // zapobiegaj ponownemu ustawieniu _isEditing na true

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (_suppressNextEdit) {
      _suppressNextEdit = false;
      return;
    }

    final workoutProvider = context.read<WorkoutProvider>();
    final text = widget.controller.text;
    setState(() {
      _isEditing = text.trim().isNotEmpty;
    });
    workoutProvider.addExerciseResult(
      userId: widget.userID,
      exerciseId: widget.exerciseID,
      result: text,
    );
  }

  void _submitNote() {
    _suppressNextEdit = true; // zapobiegamy natychmiastowej reakcji listenera
    setState(() {
      _isEditing = false;
    });
    FocusScope.of(context).unfocus(); // ukryj klawiaturę
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final exercise = ExerciseBox.getExercisebyID(widget.exerciseID);
    final t = AppLocalizations.of(context)!;
    final workouts = WorkoutBox.getAllWorkouts();
    final int? gymID = workoutProvider.selectedGym?.gymID;

    final hasExtraInfo = gymID != null &&
        workouts.any((w) =>
        w.userID == widget.userID &&
            w.exerciseID == widget.exerciseID &&
            (w.globalNote.trim().isNotEmpty ||
                w.quickValue.trim().isNotEmpty ||
                w.notes.isNotEmpty));

    return Container(
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1.5,
                    color: colorProvider.accent.withOpacity(0.4),
                  ),
                ),
                child: Image.asset(
                  exercise!.iconPath,
                  width: 26,
                  height: 26,
                  color: colorProvider.accent,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/logo_bl.png',
                      width: 26,
                      height: 26,
                      color: colorProvider.accent,
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (hasExtraInfo) {
                      final selectedOptionsProvider =
                      context.read<SelectedOptionsProvider>();

                      selectedOptionsProvider.clearSelectedOption('User');
                      selectedOptionsProvider.clearSelectedOption('Exercise');
                      selectedOptionsProvider.clearSelectedOption('Gym');
                      selectedOptionsProvider
                          .clearSelectedOption('Workout plan');

                      selectedOptionsProvider.setSelectedOption(
                          'User', widget.userID);
                      selectedOptionsProvider.setSelectedOption(
                          'Exercise', widget.exerciseID);
                      selectedOptionsProvider.selectedViewMode = 'List';

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LandingPage(),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: colorProvider.accent,
                        ),
                      ),
                      if (!hasExtraInfo)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            t.workoutScreen_firstTime,
                            style: TextStyle(
                              color: colorProvider.accent.withOpacity(0.7),
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      if (hasExtraInfo)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            t.workoutScreen_showMoreInfo,
                            style: TextStyle(
                              color: colorProvider.accent.withOpacity(0.7),
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.fromLTRB(12, 6, _isEditing ? 0 : 12, 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: t.notes_hint,
                      hintStyle: TextStyle(color: colorProvider.accent),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: colorProvider.accent),
                  ),
                ),
                if (_isEditing)
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.check, color: colorProvider.accent),
                    onPressed: _submitNote,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
