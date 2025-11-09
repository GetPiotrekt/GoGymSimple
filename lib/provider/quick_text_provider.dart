import 'package:flutter/foundation.dart';
import '../../data/workout/quick_text_db.dart';

class QuickTextProvider extends ChangeNotifier {
  List<QuickText> _notes = [];

  List<QuickText> get notes => _notes;

  QuickTextProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = [
      ...QuickTextBox.getNotesByCategory(''),
      ...QuickTextBox.getNotesByCategory('Symbols'),
    ];
    notifyListeners();
  }

  Future<void> addNote(String text) async {
    await QuickTextBox.addQuickNote('', text);
    await loadNotes();
  }

  Future<void> editNote(int id, String newText) async {
    await QuickTextBox.updateQuickNote(id, '', newText);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await QuickTextBox.deleteNoteByID(id);
    await loadNotes();
  }
}
