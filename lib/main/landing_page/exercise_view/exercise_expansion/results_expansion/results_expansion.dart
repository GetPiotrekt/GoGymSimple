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
  final String? goal;
  final String? bestSet;
  final int workoutID;

  const ResultsExpansion({
    required this.userName,
    required this.gymName,
    required this.lastNoteDate,
    required this.children,
    this.initiallyExpanded = false,
    this.onAddPressed,
    required this.workoutID,
    this.goal,
    this.bestSet,
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
          tilePadding: const EdgeInsets.only(right: 8, left: 16),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          iconColor: colorProvider.accent,
          collapsedIconColor: colorProvider.accent.withOpacity(0.7),
          title: Row(
            children: [
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
                    const SizedBox(height: 4),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: colorProvider.accent.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              DaysAgo.formatNoteDate(context, widget.lastNoteDate),
                              style: TextStyle(fontSize: 12, color: colorProvider.accent.withOpacity(0.7)),
                            ),
                          ],
                        ),
                        if (widget.bestSet != null && widget.bestSet!.trim().isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 14, color: colorProvider.accent.withOpacity(0.7)),
                              const SizedBox(width: 4),
                              Text(
                                widget.bestSet!,
                                style: TextStyle(fontSize: 12, color: colorProvider.accent.withOpacity(0.7)),
                              ),
                            ],
                          ),

                        if (widget.goal != null && widget.goal!.trim().isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.flag, size: 14, color: colorProvider.accent.withOpacity(0.7)),
                              const SizedBox(width: 4),
                              Text(
                                widget.goal!,
                                style: TextStyle(fontSize: 12, color: colorProvider.accent.withOpacity(0.7)),
                              ),
                            ],
                          ),
                      ],
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

  void _confirmDeleteWorkout(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;

    ConfirmationDialog.show(
      context: context,
      title: t.resultsExpansion_title(widget.gymName, widget.userName),
      content: t.resultsExpansion_deleteWorkoutConfirmation,
      onConfirmed: () {
        exerciseProvider.deleteWorkout(widget.workoutID);
      },
    );
  }
}
