import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 12)
class WorkoutNote extends HiveObject {
  @HiveField(0)
  int userID;

  @HiveField(1)
  int exerciseID;

  @HiveField(2)
  String note;

  WorkoutNote({
    required this.userID,
    required this.exerciseID,
    required this.note,
  });
}

class WorkoutNoteDataAdapter extends TypeAdapter<WorkoutNote> {
  @override
  final int typeId = 12;

  @override
  WorkoutNote read(BinaryReader reader) {
    return WorkoutNote(
      userID: reader.readInt(),       // poprawna kolejność
      exerciseID: reader.readInt(),
      note: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutNote obj) {
    writer.writeInt(obj.userID);
    writer.writeInt(obj.exerciseID);
    writer.writeString(obj.note);
  }
}

class WorkoutNoteBox {
  static late Box<WorkoutNote> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WorkoutNoteDataAdapter());
    box = await Hive.openBox<WorkoutNote>('workoutNoteData');
  }

  static Future<void> openBox() async {
    box = await Hive.openBox<WorkoutNote>('workoutNoteData');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  /// Dodaj nową notatkę
  static Future<void> addNote(int userID, int exerciseID, String note) async {
    final newNote = WorkoutNote(
      userID: userID,
      exerciseID: exerciseID,
      note: note,
    );
    await box.add(newNote);
  }

  /// Pobierz wszystkie notatki
  static List<WorkoutNote> getAllNotes() {
    return box.values.toList();
  }

  /// Pobierz notatkę dla danego ćwiczenia i użytkownika (jeśli istnieje)
  static WorkoutNote? getNote(int userID, int exerciseID) {
    try {
      return box.values.firstWhere(
            (note) => note.userID == userID && note.exerciseID == exerciseID,
      );
    } catch (e) {
      return null;
    }
  }

  /// Zmień notatkę
  static Future<void> updateNote(int userID, int exerciseID, String newNote) async {
    final existingNote = getNote(userID, exerciseID);
    if (existingNote != null) {
      existingNote.note = newNote;
      await existingNote.save();
    }
  }

  /// Usuń notatkę dla konkretnego ćwiczenia i użytkownika
  static Future<void> deleteNote(int userID, int exerciseID) async {
    final note = getNote(userID, exerciseID);
    if (note != null) {
      await note.delete();
    }
  }

  /// Usuń wszystkie notatki
  static Future<void> deleteAllNotes() async {
    await box.clear();
  }
}
