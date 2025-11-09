import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 6)
class Workout {
  @HiveField(0)
  late int workoutID;

  @HiveField(1)
  late int gymID;

  @HiveField(2)
  late int userID;

  @HiveField(3)
  late int exerciseID;

  @HiveField(4)
  late String globalNote;

  /// Trzymamy JSON string, który może zawierać mapę z 'goal' i 'bestSet'
  @HiveField(5)
  late String quickValue;

  @HiveField(6)
  late List<Map<String, dynamic>> notes;

  Workout({
    required this.workoutID,
    required this.gymID,
    required this.userID,
    required this.exerciseID,
    required this.globalNote,
    String? quickValue,
    List<Map<String, dynamic>>? notes,
  })  : quickValue = quickValue ?? '{}',
        notes = notes ?? [];

  Map<String, dynamic> toJson() {
    return {
      'workoutID': workoutID,
      'gymID': gymID,
      'userID': userID,
      'exerciseID': exerciseID,
      'globalNote': globalNote,
      'quickValue': quickValue,
      'notes': notes,
    };
  }

  int get typeIdForHive => workoutID;

  /// Parsowanie quickValue z JSON do mapy
  Map<String, dynamic> get quickValueMap {
    try {
      return quickValue.isEmpty ? {} : jsonDecode(quickValue);
    } catch (_) {
      return {};
    }
  }

  /// Aktualizacja quickValue z mapy
  set quickValueMap(Map<String, dynamic> map) {
    quickValue = jsonEncode(map);
  }

  /// Getter i setter dla pola goal
  String? get goal => quickValueMap['goal'] as String?;

  set goal(String? value) {
    final map = quickValueMap;
    if (value == null) {
      map.remove('goal');
    } else {
      map['goal'] = value;
    }
    quickValueMap = map;
  }

  /// Getter i setter dla pola bestSet
  String? get bestSet => quickValueMap['bestSet'] as String?;

  set bestSet(String? value) {
    final map = quickValueMap;
    if (value == null) {
      map.remove('bestSet');
    } else {
      map['bestSet'] = value;
    }
    quickValueMap = map;
  }
  /// Uniwersalny getter dla pola z quickValue
  dynamic getQuickValue(String key) => quickValueMap[key];

  /// Uniwersalny setter dla pola z quickValue
  void setQuickValue(String key, dynamic value) {
    final map = quickValueMap;
    if (value == null) {
      map.remove(key);
    } else {
      map[key] = value;
    }
    quickValueMap = map;
  }
}

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 6;

  @override
  Workout read(BinaryReader reader) {
    return Workout(
      workoutID: reader.readInt(),
      gymID: reader.readInt(),
      userID: reader.readInt(),
      exerciseID: reader.readInt(),
      globalNote: reader.readString(),
      quickValue: reader.readString(),
      notes: (reader.readList()
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList()),
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer.writeInt(obj.workoutID);
    writer.writeInt(obj.gymID);
    writer.writeInt(obj.userID);
    writer.writeInt(obj.exerciseID);
    writer.writeString(obj.globalNote);
    writer.writeString(obj.quickValue);
    writer.writeList(obj.notes.map((note) => Map<String, dynamic>.from(note)).toList());
  }
}

class WorkoutBox {
  static late Box<Workout> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WorkoutAdapter());
    box = await Hive.openBox<Workout>('workout');
  }

  static Future<void> openBox() async {
    box = await Hive.openBox<Workout>('workout');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<void> addWorkout(int gymID, int userID, int exerciseID,
      String globalNote, String quickValue,
      {List<Map<String, dynamic>>? notes}) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newWorkout = Workout(
      workoutID: newIndex,
      gymID: gymID,
      userID: userID,
      exerciseID: exerciseID,
      globalNote: globalNote,
      quickValue: quickValue,
      notes: notes ?? [],
    );
    await box.put(newIndex, newWorkout);
  }

  static Future<int> _getMaxIndex() async {
    final workouts = box.values.toList();
    int maxIndex = 0;
    for (final workout in workouts) {
      if (workout.workoutID > maxIndex) {
        maxIndex = workout.workoutID;
      }
    }
    return maxIndex;
  }

  static Future<void> deleteWorkout(int workoutID) async {
    if (box.containsKey(workoutID)) {
      await box.delete(workoutID);
      print("Workout with ID: $workoutID deleted.");
    } else {
      print("Workout with ID: $workoutID not found.");
    }
  }

  static List<Workout> getAllWorkouts() {
    return box.values.toList();
  }

  static Workout? getWorkoutByID(int id) {
    return box.get(id);
  }

  static Future<void> deleteAllWorkouts() async {
    await box.clear();
  }

  static List<Map<String, dynamic>> getNotes(int workoutID) {
    final workout = box.get(workoutID);
    return workout?.notes ?? [];
  }

  static Future<void> updateGlobalNote(
      int workoutID, String newGlobalNote) async {
    final workout = getWorkoutByID(workoutID);
    if (workout != null) {
      workout.globalNote = newGlobalNote;
      await box.put(workoutID, workout);
      print("Updated Global Note: ${workout.globalNote}");
    } else {
      print("Workout with ID: $workoutID not found.");
    }
  }

  static Future<void> updateQuickValue(
      int workoutID, String newQuickValue) async {
    final workout = getWorkoutByID(workoutID);
    if (workout != null) {
      workout.quickValue = newQuickValue;
      await box.put(workoutID, workout);
      print("Updated Quick Value: ${workout.quickValue}");
    } else {
      print("Workout with ID: $workoutID not found.");
    }
  }

  static DateTime? getLatestNoteDate(int workoutID) {
    final workout = getWorkoutByID(workoutID);
    if (workout == null || workout.notes.isEmpty) return null;

    return workout.notes
        .map((note) => DateTime.parse(note['date'] as String))
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  static Future<void> updateNote(int workoutID, int index,
      {required String newNote, required DateTime newDate}) async {
    final workoutKey = box.keys.firstWhere(
          (key) => box.get(key)!.workoutID == workoutID,
      orElse: () => null,
    );

    if (workoutKey == null) return;

    final workout = box.get(workoutKey);
    if (workout == null) return;

    if (index >= 0 && index < workout.notes.length) {
      workout.notes[index] = {
        'note': newNote,
        'date': newDate.toIso8601String(),
      };
    }

    await box.put(workoutKey, workout);
  }

  static Future<void> addNote(
      int workoutID, Map<String, dynamic> newNote) async {
    final workoutKey = box.keys.firstWhere(
          (key) => box.get(key)!.workoutID == workoutID,
      orElse: () => null,
    );

    if (workoutKey == null) return;

    final workout = box.get(workoutKey);
    if (workout == null) return;

    workout.notes.insert(0, newNote);
    await box.put(workoutKey, workout);
  }

  static Future<void> deleteNoteByDate(
      int workoutID, DateTime dateToDelete) async {
    final workoutKey = box.keys.firstWhere(
          (key) => box.get(key)!.workoutID == workoutID,
      orElse: () => null,
    );
    if (workoutKey == null) return;
    final workout = box.get(workoutKey);

    if (workout == null) return;
    final dateStr = dateToDelete.toIso8601String();

    workout.notes.removeWhere((note) => note['date'] == dateStr);
    await box.put(workoutKey, workout);
  }

  static Workout? getWorkoutByUserAndGym(int userID, int gymID) {
    return box.values.firstWhere(
          (w) => w.userID == userID && w.gymID == gymID,
    );
  }
}
