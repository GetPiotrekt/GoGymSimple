import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';
import '../../../../../../util/dates_and_time/days_ago.dart';
import '../../../../../../util/dialog/confirmation_dialog.dart';

class NotesList extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  final int workoutID;
  final void Function(int index) onEdit;

  const NotesList({
    super.key,
    required this.notes,
    required this.workoutID,
    required this.onEdit,
  });

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);

    if (widget.notes.isEmpty) {
      return _buildEmptyNoteBox(t, colorProvider);
    }

    final notesToDisplay = showAll ? widget.notes : widget.notes.take(2).toList();

    return Column(
      children: [
        ...notesToDisplay.asMap().entries.expand((entry) {
          final index = entry.key;
          final note  = entry.value;
          final widgets = <Widget>[
            _buildNoteItem(context, colorProvider, note, index),
          ];

          if (index == 1 && widget.notes.length > 2) {
            final remaining = widget.notes.length - 2;
            final buttonText = showAll
                ? t.notes_showLess
                : "${t.notes_showMore} ($remaining)";

            widgets.add(
              TextButton(
                onPressed: () {
                  setState(() => showAll = !showAll);
                },
                child: Text(
                  buttonText,
                  style: TextStyle(color: colorProvider.accent),
                ),
              ),
            );
          }

          return widgets;
        }),

        if (widget.notes.length > 2 &&
            widget.notes.length == 1 && !showAll)
          TextButton(
            onPressed: () {
              setState(() => showAll = !showAll);
            },
            child: Text(
              "${t.notes_showMore} (${widget.notes.length - 1})",
              style: TextStyle(color: colorProvider.accent),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyNoteBox(AppLocalizations t, ColorProvider colorProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.5,
          color: colorProvider.accent.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: Text(
          t.notes_empty,
          style: TextStyle(
            color: colorProvider.accent.withOpacity(0.6),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteItem(BuildContext context, ColorProvider colorProvider, Map<String, dynamic> note, int index) {
    final t = AppLocalizations.of(context)!;
    final String noteText = note['note'] ?? t.notes_emptyNote;
    final String rawDate = note['date'] ?? '';
    final formattedDate = _formatDate(context, rawDate);

    return GestureDetector(
      onTap: () => widget.onEdit(index),
      onLongPress: () => _confirmDeleteNote(context, index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: colorProvider.accent.withOpacity(0.5),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteText,
                  style: TextStyle(
                    color: colorProvider.accent.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: colorProvider.accent.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: -15,
              right: -15,
              child: IconButton(
                icon: Icon(Icons.copy, size: 18, color: colorProvider.accent.withOpacity(0.7)),
                tooltip: AppLocalizations.of(context)!.notes_copy,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: noteText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.notes_copied),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

      ),
    );
  }

  String _formatDate(BuildContext context, String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final relativeTime = DaysAgo.formatNoteDate(context, date);
      final locale = Localizations.localeOf(context).toString();

      if (date.hour == 0 && date.minute == 0 && date.second == 0) {
        return "${DateFormat("d MMM yyyy", locale).format(date)}  ($relativeTime)";
      } else {
        return "${DateFormat("d MMM yyyy · HH:mm", locale).format(date)}  ($relativeTime)";
      }
    } catch (_) {
      return "Invalid date";
    }
  }

  void _confirmDeleteNote(BuildContext context, int index) {
    final t = AppLocalizations.of(context)!;

    showConfirmationDialog(
      context: context,
      title: t.notes_deleteNoteTitle,
      content: t.notes_deleteNoteConfirm,
      onConfirmed: () {
        setState(() {
          widget.notes.removeAt(index);
        });
      },
    );
  }

}
