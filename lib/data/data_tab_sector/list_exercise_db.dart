import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 4)
class ListExercise {
  @HiveField(0)
  late int listExerciseID;

  @HiveField(1)
  late String exerciseListName;

  @HiveField(2)
  late List<int> exerciseIDs;


  ListExercise(this.listExerciseID, this.exerciseListName, this.exerciseIDs);

  Map<String, dynamic> toJson() {
    return {
      'exerciseListID': listExerciseID,
      'workoutName': exerciseListName,
      'exerciseIDs': exerciseIDs,
    };
  }
}

class ListExerciseAdapter extends TypeAdapter<ListExercise> {
  @override
  final int typeId = 4;

  @override
  ListExercise read(BinaryReader reader) {
    return ListExercise(
      reader.readInt(),
      reader.readString(),
      reader.readList().cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListExercise obj) {
    writer.writeInt(obj.listExerciseID);
    writer.writeString(obj.exerciseListName);
    writer.writeList(obj.exerciseIDs);
  }
}

class ListExerciseBox {
  static late Box<ListExercise> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ListExerciseAdapter());
    box = await Hive.openBox<ListExercise>('ExerciseLists');
/*    if (box.isEmpty) {
      await addDefaultData();
    }*/
  }

/*  static Future<void> addDefaultData() async {
    await addExerciseList('Push', [1, 2]);
    await addExerciseList('Pull', [2, 3]);
  }*/

  static Future<void> addExerciseList(String workoutName, List<int> exerciseIDs) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newExerciseList = ListExercise(newIndex, workoutName, exerciseIDs);
    await box.put(newIndex, newExerciseList);
  }

  static Future<int> _getMaxIndex() async {
    final exerciseLists = box.values.toList();
    int maxIndex = 0;
    for (final exerciseList in exerciseLists) {
      if (exerciseList.listExerciseID > maxIndex) {
        maxIndex = exerciseList.listExerciseID;
      }
    }
    return maxIndex;
  }

  static List<ListExercise> getAllExerciseLists() {
    return box.values.toList();
  }

  static Future<void> deleteAllExerciseLists() async {
    await box.clear();
  }

  static Future<void> updateExerciseList(int listExerciseID, String workoutName, List<int> exerciseIDs) async {
    final updatedExerciseList = ListExercise(listExerciseID, workoutName, exerciseIDs);
    await box.put(listExerciseID, updatedExerciseList);
  }


  static ListExercise? getExerciseListByID(int id) {
    return box.get(id);
  }

  static Future<void> deleteExerciseListByID(int id) async {
    await box.delete(id);
  }
}

