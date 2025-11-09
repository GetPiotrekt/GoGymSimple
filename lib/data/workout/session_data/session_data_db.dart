import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 11)
class SessionData extends HiveObject {
  @HiveField(0)
  DateTime selectedDate;

  @HiveField(1)
  int selectedGymID;

  @HiveField(2)
  List<int>? selectedExerciseIDs;

  @HiveField(3)
  List<int>? selectedWorkoutPlanIDs;

  SessionData({
    required this.selectedDate,
    required this.selectedGymID,
    this.selectedExerciseIDs,
    this.selectedWorkoutPlanIDs,
  });

  Map<String, dynamic> toJson() => {
    'selectedDate': selectedDate.toIso8601String(),
    'selectedGymID': selectedGymID,
    'selectedExerciseIDs': selectedExerciseIDs,
    'selectedWorkoutPlanIDs': selectedWorkoutPlanIDs,
  };
}


class SessionDataAdapter extends TypeAdapter<SessionData> {
  @override
  final int typeId = 11;

  @override
  SessionData read(BinaryReader reader) {
    return SessionData(
      selectedDate: DateTime.parse(reader.readString()),
      selectedGymID: reader.readInt(), // było readString
      selectedExerciseIDs: reader.readBool() ? reader.readList().cast<int>() : null,
      selectedWorkoutPlanIDs: reader.readBool() ? reader.readList().cast<int>() : null,
    );
  }

  @override
  void write(BinaryWriter writer, SessionData obj) {
    writer.writeString(obj.selectedDate.toIso8601String());
    writer.writeInt(obj.selectedGymID); // było writeString

    if (obj.selectedExerciseIDs != null) {
      writer.writeBool(true);
      writer.writeList(obj.selectedExerciseIDs!);
    } else {
      writer.writeBool(false);
    }

    if (obj.selectedWorkoutPlanIDs != null) {
      writer.writeBool(true);
      writer.writeList(obj.selectedWorkoutPlanIDs!);
    } else {
      writer.writeBool(false);
    }
  }
}

class SessionDataBox {
  static late Box<SessionData> box;
  static const _boxKey = 'currentSession'; // Jeden rekord przechowujący sesję

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SessionDataAdapter());
    box = await Hive.openBox<SessionData>('sessionData');
  }

  static Future<void> openBox() async {
    box = await Hive.openBox<SessionData>('sessionData');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<void> createOrUpdateSession(SessionData session) async {
    await box.put(_boxKey, session);
  }

  static SessionData? getSession() {
    return box.get(_boxKey);
  }

  // Aktualizacja daty
  static Future<void> updateDate(DateTime newDate) async {
    final session = getSession();
    if (session != null) {
      session.selectedDate = newDate;
      await session.save();
    }
  }

  // Aktualizacja siłowni
  static Future<void> updateGymID(int newGymID) async { // było String
    final session = getSession();
    if (session != null) {
      session.selectedGymID = newGymID;
      await session.save();
    }
  }

  static Future<void> addExerciseID(int exerciseID) async {
    final session = getSession();
    if (session != null) {
      session.selectedExerciseIDs ??= [];
      if (!session.selectedExerciseIDs!.contains(exerciseID)) {
        session.selectedExerciseIDs!.add(exerciseID);
        await session.save();
      }
    }
  }

  static Future<void> removeExerciseID(int exerciseID) async {
    final session = getSession();
    if (session != null && session.selectedExerciseIDs != null) {
      session.selectedExerciseIDs!.remove(exerciseID);
      await session.save();
    }
  }

  // Dodaj plan treningowy (jeśli nie ma)
  static Future<void> addWorkoutPlanID(int planID) async {
    final session = getSession();
    if (session != null) {
      session.selectedWorkoutPlanIDs ??= [];
      if (!session.selectedWorkoutPlanIDs!.contains(planID)) {
        session.selectedWorkoutPlanIDs!.add(planID);
        await session.save();
      }
    }
  }

  // Usuń plan treningowy
  static Future<void> removeWorkoutPlanID(int planID) async {
    final session = getSession();
    if (session != null && session.selectedWorkoutPlanIDs != null && session.selectedWorkoutPlanIDs!.contains(planID)) {
      session.selectedWorkoutPlanIDs!.remove(planID);
      await session.save();
    }
  }

  static Future<void> updateExerciseOrder(List<int> newOrder) async {
    final session = getSession();
    if (session != null) {
      session.selectedExerciseIDs = newOrder;
      await session.save();
    }
  }

  // Usuń całą sesję
  static Future<void> deleteSession() async {
    await box.clear();
  }
}
