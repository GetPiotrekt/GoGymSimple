import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/workout/quick_text_db.dart';
import '../../../provider/quick_text_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../util/bottom_sheet/edit_delete_bottom_sheet.dart';
import '../../../util/dialog/text_input_dialog.dart';

class QuickNoteManager extends StatelessWidget {
  final TextEditingController controller;
  final Color color;

  const QuickNoteManager({
    super.key,
    required this.controller,
    required this.color,
  });

  void _insertQuickNote(BuildContext context, String text) {
    final currentText = controller.text;
    final selection = controller.selection;

    if (selection.start < 0 || selection.end < 0) {
      controller.text = currentText + text;
      controller.selection = TextSelection.collapsed(offset: controller.text.length);
    } else {
      final newText = currentText.replaceRange(
        selection.start,
        selection.end,
        text,
      );
      controller.text = newText;
      final newPosition = selection.start + text.length;
      controller.selection = TextSelection.collapsed(offset: newPosition);
    }
  }

  Future<void> _addNoteDialog(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final newNote = await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.workoutScreen_addNote,
      labelText: t.notes_hint,
    );

    if (newNote != null && newNote.trim().isNotEmpty) {
      await context.read<QuickTextProvider>().addNote(newNote.trim());
    }
  }

  Future<void> _editNoteDialog(BuildContext context, QuickText note) async {
    final t = AppLocalizations.of(context)!;

    await EditDeleteBottomSheet.show(
      context: context,
      title: t.tabBottomDrawer_editTitle,
      initialName: note.text,
      id: note.noteID,
      onEdit: (newName) async {
        await context.read<QuickTextProvider>().editNote(note.noteID, newName.trim());
      },
      onDelete: () async {
        await context.read<QuickTextProvider>().deleteNote(note.noteID);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quickNotes = context.watch<QuickTextProvider>().notes;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...quickNotes.map((note) {
            return Padding(
              padding: const EdgeInsets.only(right: 6, bottom: 4, top: 4),
              child: OutlinedButton(
                onPressed: () => _insertQuickNote(context, note.text),
                onLongPress: () => _editNoteDialog(context, note),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: color.withOpacity(0.1), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: color.withValues(alpha: 0.05),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  note.text,
                  style: TextStyle(color: color, fontSize: 12),
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () => _addNoteDialog(context),
            child: Icon(Icons.add_circle, color: color, size: 22),
          ),
        ],
      ),
    );
  }
}
