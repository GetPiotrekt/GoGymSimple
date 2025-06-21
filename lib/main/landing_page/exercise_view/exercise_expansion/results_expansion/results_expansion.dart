import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/workout/workout_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../util/dates_and_time/days_ago.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/exercise_provider.dart';
import '../../../../../util/dialog/confirmation_dialog.dart';
import '../../../../../util/dialog/text_input_dialog.dart';

class ResultsExpansion extends StatefulWidget {
  final String userName;
  final String gymName;
  final DateTime? lastNoteDate;
  final List<Widget> children;
  final bool initiallyExpanded;
  final void Function()? onAddPressed;
  final String quickValue;
  final int workoutID;

  const ResultsExpansion({
    required this.userName,
    required this.gymName,
    required this.lastNoteDate,
    required this.children,
    this.initiallyExpanded = false,
    this.onAddPressed,
    required this.quickValue,
    required this.workoutID,
    super.key,
  });

  @override
  State<ResultsExpansion> createState() => _ResultsExpansionState();
}

class _ResultsExpansionState extends State<ResultsExpansion> {
  String? quickValue;
  String? selectedIconPath;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    quickValue = widget.quickValue;
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: GestureDetector(
        onLongPress: () {
          if (!_isExpanded) {
            _confirmDeleteWorkout(context);
          }
        },
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(right: 8),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          iconColor: colorProvider.accent,
          collapsedIconColor: colorProvider.accent.withOpacity(0.7),
          title: Row(
            children: [
              if (quickValue != null)
                GestureDetector(
                  onTap: () => _editQuickValue(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorProvider.accent.withOpacity(0.1),
                      border: Border.all(color: colorProvider.accent.withOpacity(0.5), width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: SizedBox(
                      width: 70,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: (quickValue == null || quickValue!.trim().isEmpty)
                            ? Icon(Icons.edit, size: 20, color: colorProvider.accent)
                            : Text(
                          quickValue!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorProvider.accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // Reszta treści, zajmująca dostępne miejsce
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        t.resultsExpansion_title(widget.userName, widget.gymName),
                        style: TextStyle(
                          fontSize: 16,
                          color: colorProvider.accent,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        DaysAgo.formatNoteDate(context, widget.lastNoteDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: colorProvider.accent.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          initiallyExpanded: widget.initiallyExpanded,
          children: widget.children,
        ),
      ),
    );
  }

  void _editQuickValue(BuildContext context) async {
    final t = AppLocalizations.of(context)!;

    final newQuickValue = await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.resultsExpansion_quickValue,
      labelText: t.resultsExpansion_quickValueSet,
      initialText: quickValue ?? '',
      inputType: TextInputType.text,
      maxLength: 16,
    );

    if (newQuickValue != null) {
      await WorkoutBox.updateQuickValue(widget.workoutID, newQuickValue); // <- musi obsługiwać String
      setState(() {
        quickValue = newQuickValue;
      });
    }
  }

  void _confirmDeleteWorkout(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;

    showConfirmationDialog(
      context: context,
      title: t.resultsExpansion_title(widget.gymName, widget.userName),
      content: t.resultsExpansion_deleteWorkoutConfirmation,
      onConfirmed: () {
        exerciseProvider.deleteWorkout(widget.workoutID);
      },
    );
  }
}
