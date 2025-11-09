import 'package:GoGymSimple/main/landing_page/landing_page.dart';
import 'package:GoGymSimple/main/workout_screen/exercise_section/previous_notes_section.dart';
import 'package:GoGymSimple/main/workout_screen/exercise_section/quick_texts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../data/workout/workout_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/selected_options_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../../util/dialog/confirmation_dialog.dart';
import '../../landing_page/exercise_view/exercise_expansion/results_expansion/global_note.dart';
import '../../landing_page/exercise_view/exercise_view.dart';

class ExerciseNoteTile extends StatefulWidget {
  final String title;
  final int exerciseID;
  final int userID;
  final int index;
  final TextEditingController controller;
  final VoidCallback? onInfoTap;

  const ExerciseNoteTile({
    super.key,
    required this.title,
    required this.exerciseID,
    required this.userID,
    required this.index,
    required this.controller,
    this.onInfoTap,
  });

  @override
  State<ExerciseNoteTile> createState() => _ExerciseNoteTileState();
}

class _ExerciseNoteTileState extends State<ExerciseNoteTile> {
  bool _isEditing = false;
  bool _suppressNextEdit = false;
  bool _showExtraInfo = false;

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
    _suppressNextEdit = true;
    setState(() {
      _isEditing = false;
      _showExtraInfo = false;
    });
    FocusScope.of(context).unfocus();
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

    final matchingWorkout = workouts.firstWhere(
      (w) =>
          w.userID == widget.userID &&
          w.exerciseID == widget.exerciseID &&
          w.gymID == gymID,
      orElse: () => Workout(
        workoutID: -1,
        gymID: gymID ?? -1,
        userID: widget.userID,
        exerciseID: widget.exerciseID,
        globalNote: '',
        quickValue: '',
        notes: [],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Główny kontener z tytułem, ikoną i polem edycji
        Container(
          decoration: BoxDecoration(
            color: colorProvider.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Tytuł i ikona
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showExtraInfo = !_showExtraInfo;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.index + 1}. ${widget.title}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: colorProvider.accent,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) => FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  child: Text(
                                    _showExtraInfo ? t.notes_showLess : t.notes_showMore,
                                    key: ValueKey(_showExtraInfo),
                                    style: TextStyle(
                                      color: colorProvider.accent.withOpacity(0.7),
                                      fontSize: 14.5,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                AnimatedRotation(
                                  turns: _showExtraInfo ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: Icon(
                                    Icons.expand_more,
                                    size: 22,
                                    color: colorProvider.accent.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorProvider.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1.5,
                        color: colorProvider.accent.withOpacity(0.1),
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
                ],
              ),
              const SizedBox(height: 10),

              /// Pole edycji notatki
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: colorProvider.accent.withValues(alpha: 0.1))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: widget.controller,
                      maxLength: 200,
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: t.notes_hint,
                        hintStyle: TextStyle(color: colorProvider.accent),
                        border: InputBorder.none,
                          counter: Builder(
                            builder: (context) {
                              final text = widget.controller.text;
                              final currentLength = text.characters.length;
                              final isOverLimit = currentLength > 200;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Sugerowana długość
                                  Text(
                                    t.exerciseNoteTile_suggestedLength, // np. "Sugerowana długość: do 200 znaków"
                                    style: TextStyle(
                                      color: colorProvider.accent.withOpacity(0.6),
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),

                                  // Licznik + ikonka info
                                  Row(
                                    children: [
                                      Text(
                                        '$currentLength/200',
                                        style: TextStyle(
                                          color: isOverLimit
                                              ? colorProvider.accent
                                              : colorProvider.accent.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          ConfirmationDialog.show(
                                            context: context,
                                            title: t.exerciseNoteTile_infoTitle, // np. "Informacja o długości"
                                            content: t.exerciseNoteTile_infoContent, // np. "To ćwiczenie wymaga określenia czasu trwania."
                                          );
                                        },
                                        child: Icon(
                                          Icons.info_outline,
                                          size: 18,
                                          color: colorProvider.accent.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                        ),
                      ),
                      style: TextStyle(color: colorProvider.accent),
                    ),
                    Divider(color: colorProvider.accent.withOpacity(0.1), thickness: 1.5),

                    /// Szybkie wpisywanie
                    QuickNoteManager(
                      controller: widget.controller,
                      color: colorProvider.accent,
                    ),
                    if (_isEditing) ...[
                      const SizedBox(height: 4),
                      /// Zapisz notatkę
                      TextButton.icon(
                        onPressed: _submitNote,
                        icon: Icon(Icons.check, color: colorProvider.accent),
                        label: Text(
                          t.notes_saveNote,
                          style: TextStyle(color: colorProvider.accent),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          backgroundColor: colorProvider.accent.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              /// Oddzielny kontener na notatki globalne i wcześniejsze
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: _showExtraInfo
                    ? PreviousNotesSection(
                        colorProvider: colorProvider,
                        initialWorkout: matchingWorkout,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
