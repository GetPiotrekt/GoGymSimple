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

  Exercise(this.exerciseID, this.exerciseName, this.iconPath);

  Map<String, dynamic> toJson() {
    return {
      'exerciseID': exerciseID,
      'name': exerciseName,
      'iconPath': iconPath,
    };
  }
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 3;

  @override
  Exercise read(BinaryReader reader) {
    return Exercise(
      reader.readInt(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer.writeInt(obj.exerciseID);
    writer.writeString(obj.exerciseName);
    writer.writeString(obj.iconPath);
  }
}

class ExerciseBox {
  static late Box<Exercise> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExerciseAdapter());
    box = await Hive.openBox<Exercise>('exercise');

/*    if (box.isEmpty) {
      await _addDefaultExercises();
    }*/
  }

/*  static Future<void> _addDefaultExercises() async {
    await addExercise('SQUAT', 'assets/icons/barbell.png');
    await addExercise('BENCH PRESS', 'assets/icons/dumbbell.png');
    await addExercise('PULL-UP', 'assets/icons/bodyweight.png');
  }*/

  static Future<void> openBox() async {
    box = await Hive.openBox<Exercise>('exercise');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<int> addExercise(String name, String iconPath) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newExercise = Exercise(newIndex, name, iconPath);
    await box.put(newIndex, newExercise);

    return newIndex;
  }


  static Future<void> updateExercise(int exerciseID, String newName, String newIconPath) async {
    final exerciseToUpdate = box.values.firstWhereOrNull((ex) => ex.exerciseID == exerciseID);
    if (exerciseToUpdate != null) {
      exerciseToUpdate.exerciseName = newName;
      exerciseToUpdate.iconPath = newIconPath;
      await box.put(exerciseID, exerciseToUpdate);
      print("Exercise with ID: $exerciseID updated.");
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
