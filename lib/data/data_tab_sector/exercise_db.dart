import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 3)
class Exercise {
  @HiveField(0)
  final int exerciseID;

  @HiveField(1)
  String exerciseName;

  @HiveField(2)
  String iconPath;

  @HiveField(3, defaultValue: null)
  String? note; // 🆕 Notatka (opcjonalna)

  Exercise(this.exerciseID, this.exerciseName, this.iconPath, [this.note]);

  Map<String, dynamic> toJson() {
    return {
      'exerciseID': exerciseID,
      'name': exerciseName,
      'iconPath': iconPath,
      'note': note,
    };
  }
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 3;

  @override
  Exercise read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final icon = reader.readString();

    String? note;

    // Sprawdzamy, czy są dostępne jeszcze jakieś bajty do odczytu
    if (reader.availableBytes > 0) {
      final hasNote = reader.readBool();
      if (hasNote) {
        note = reader.readString();
      }
    } else {
      note = null;
    }

    return Exercise(id, name, icon, note);
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer.writeInt(obj.exerciseID);
    writer.writeString(obj.exerciseName);
    writer.writeString(obj.iconPath);
    writer.writeBool(obj.note != null);
    if (obj.note != null) {
      writer.writeString(obj.note!);
    }
  }
}

class ExerciseBox {
  static late Box<Exercise> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExerciseAdapter());
    box = await Hive.openBox<Exercise>('exercise');
  }

  static Future<void> openBox() async {
    box = await Hive.openBox<Exercise>('exercise');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<int> addExercise(String name, String iconPath, [String? note]) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newExercise = Exercise(newIndex, name, iconPath, note);
    await box.put(newIndex, newExercise);
    return newIndex;
  }

  static Future<void> updateExercise(int exerciseID, String newName, String newIconPath, [String? newNote]) async {
    final exerciseToUpdate = box.values.firstWhereOrNull((ex) => ex.exerciseID == exerciseID);
    if (exerciseToUpdate != null) {
      exerciseToUpdate.exerciseName = newName;
      exerciseToUpdate.iconPath = newIconPath;
      exerciseToUpdate.note = newNote;
      await box.put(exerciseID, exerciseToUpdate);
      print("Exercise with ID: $exerciseID updated.");
    } else {
      print("Exercise with ID: $exerciseID not found.");
    }
  }

  static Future<void> updateNote(int exerciseID, String? newNote) async {
    final exercise = box.get(exerciseID);
    if (exercise != null) {
      exercise.note = newNote;
      await box.put(exerciseID, exercise);
      print("Note for exercise ID $exerciseID updated.");
    } else {
      print("Exercise with ID: $exerciseID not found.");
    }
  }

  static Exercise? getExercisebyID(int exerciseID) {
    return box.get(exerciseID);
  }

  static Future<int> _getMaxIndex() async {
    if (box.isEmpty) return 0;
    return box.values.map((ex) => ex.exerciseID).reduce((a, b) => a > b ? a : b);
  }

  static Future<void> deleteExercise(int exerciseID) async {
    if (box.containsKey(exerciseID)) {
      await box.delete(exerciseID);
      print("Exercise with ID: $exerciseID deleted.");
    } else {
      print("Exercise with ID: $exerciseID not found.");
    }
  }

  static List<Exercise> getAllExercises() {
    return box.values.toList();
  }

  static Future<void> deleteAllExercises() async {
    await box.clear();
    print("All exercises deleted.");
  }

  static Future<void> updateIconPath(int exerciseID, String newIconPath) async {
    final exerciseToUpdate = box.values.firstWhereOrNull((ex) => ex.exerciseID == exerciseID);
    if (exerciseToUpdate != null) {
      exerciseToUpdate.iconPath = newIconPath;
      await box.put(exerciseID, exerciseToUpdate);
      print("Icon path for exercise ID $exerciseID updated.");
    } else {
      print("Exercise with ID: $exerciseID not found.");
    }
  }
}