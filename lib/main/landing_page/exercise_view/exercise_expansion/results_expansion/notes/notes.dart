import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/workout/workout_db.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';
import '../../../../../../util/dates_and_time/date_picker.dart';
import 'notes_editor.dart';
import 'notes_list.dart';

class Notes extends StatefulWidget {
  final int workoutID;
  final List<Map<String, dynamic>> notes;
  final bool isFromWorkout; // nowy parametr

  const Notes({
    super.key,
    required this.workoutID,
    required this.notes,
    this.isFromWorkout = false, // domyślnie false
  });

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool _isEditing = false;
  int? _editingIndex;
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _toggleAddNote() {
    // Jeżeli jest z workoutu, blokujemy możliwość dodawania
    if (widget.isFromWorkout) return;

    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _noteController.clear();
        _selectedDate = DateTime.now();
        _editingIndex = null;
      }
    });
  }

  Future<void> _saveNote() async {
    final String noteText = _noteController.text.trim();
    if (noteText.isEmpty) return;

    try {
      if (_editingIndex != null) {
        await WorkoutBox.updateNote(
          widget.workoutID,
          _editingIndex!,
          newNote: noteText,
          newDate: _selectedDate,
        );
      } else {
        await WorkoutBox.addNote(widget.workoutID, {
          'note': noteText,
          'date': _selectedDate.toIso8601String(),
        });
      }
      _toggleAddNote();
    } catch (e) {
      // obsługa błędu (np. logowanie)
    }
  }

  void _editNote(int index) {
    // Jeżeli jest z workoutu, blokujemy możliwość edycji
    if (widget.isFromWorkout) return;

    setState(() {
      _isEditing = true;
      _editingIndex = index;
      _noteController.text = widget.notes[index]['note'];
      _selectedDate = DateTime.parse(widget.notes[index]['date']);
    });
  }

  Future<void> _pickDate() async {
    final picked = await showCustomDatePicker(context, _selectedDate, selectPastDates: true);
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.notes_title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorProvider.accent,
                ),
              ),
              if (!widget.isFromWorkout) // ukrywamy przycisk dodawania, jeśli z workoutu
                GestureDetector(
                  onTap: _toggleAddNote,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorProvider.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _isEditing ? t.notes_cancel : t.notes_addNote,
                      style: TextStyle(
                        color: colorProvider.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_isEditing)
          NotesEditor(
            controller: _noteController,
            selectedDate: _selectedDate,
            onSave: _saveNote,
            onCancel: _toggleAddNote,
            onPickDate: _pickDate,
            isEditing: _editingIndex != null,
          ),
        NotesList(
          isFromWorkout: widget.isFromWorkout,
          notes: widget.notes,
          workoutID: widget.workoutID,
          onEdit: widget.isFromWorkout ? (int _) {} : _editNote,
        ),
      ],
    );
  }
}
