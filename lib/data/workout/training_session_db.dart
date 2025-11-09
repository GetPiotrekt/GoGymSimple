import 'package:GoGymSimple/data/workout/workout_db.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 14)
class TrainingSession {
  @HiveField(0)
  late int sessionID;

  @HiveField(1)
  late DateTime startDateTime;

  @HiveField(2)
  late int durationMinutes;

  @HiveField(3)
  String? preNote;

  @HiveField(4)
  String? postNote;

  @HiveField(5)
  late List<int> workoutIDs;

  @HiveField(6)
  List<String>? planNames; // teraz opcjonalne

  TrainingSession({
    required this.sessionID,
    required this.startDateTime,
    required this.durationMinutes,
    this.preNote,
    this.postNote,
    required this.workoutIDs,
    this.planNames,
  });
}

class TrainingSessionAdapter extends TypeAdapter<TrainingSession> {
  @override
  final int typeId = 14;

  @override
  TrainingSession read(BinaryReader reader) {
    return TrainingSession(
      sessionID: reader.readInt(),
      startDateTime: DateTime.parse(reader.readString()),
      durationMinutes: reader.readInt(),
      preNote: reader.readString(),
      postNote: reader.readString(),
      workoutIDs: List<int>.from(reader.readList()),
      planNames: reader.readBool() ? List<String>.from(reader.readList()) : null,
    );
  }

  @override
  void write(BinaryWriter writer, TrainingSession obj) {
    writer.writeInt(obj.sessionID);
    writer.writeString(obj.startDateTime.toIso8601String());
    writer.writeInt(obj.durationMinutes);
    writer.writeString(obj.preNote ?? '');
    writer.writeString(obj.postNote ?? '');
    writer.writeList(obj.workoutIDs);
    writer.writeBool(obj.planNames != null);
    if (obj.planNames != null) {
      writer.writeList(obj.planNames!);
    }
  }
}


class TrainingSessionBox {
  static late Box<TrainingSession> box;

  static Future<void> initBox() async {
    Hive.registerAdapter(TrainingSessionAdapter());
    box = await Hive.openBox<TrainingSession>('training_sessions');
  }

  static Future<void> addSession({
    required DateTime startDateTime,
    required int durationMinutes,
    String? preNote,
    String? postNote,
    required List<int> workoutIDs,
    required List<String> planNames,
  }) async {
    final int newIndex = await _getMaxIndex() + 1;
    final session = TrainingSession(
      sessionID: newIndex,
      startDateTime: startDateTime,
      durationMinutes: durationMinutes,
      preNote: preNote,
      postNote: postNote,
      workoutIDs: workoutIDs,
      planNames: planNames,
    );
    await box.put(newIndex, session);
  }

  static Future<int> _getMaxIndex() async {
    int maxIndex = 0;
    for (final session in box.values) {
      if (session.sessionID > maxIndex) {
        maxIndex = session.sessionID;
      }
    }
    return maxIndex;
  }

  static Future<void> migrateWorkoutsToSession() async {
    final workouts = WorkoutBox.getAllWorkouts();
    if (workouts.isEmpty) {
      print("Brak workoutów do migracji.");
      return;
    }

    // Mapowanie dat (yyyy-MM-dd) na listę workoutID
    final Map<String, Set<int>> sessionsMap = {};

    for (final workout in workouts) {
      for (final note in workout.notes) {
        if (note.containsKey('date') && note['date'] != null) {
          try {
            final dateTime = DateTime.parse(note['date'] as String);
            // Grupujemy po roku-miesiącu-dniu (ignorujemy czas)
            final dayKey = "${dateTime.year.toString().padLeft(4, '0')}-"
                "${dateTime.month.toString().padLeft(2, '0')}-"
                "${dateTime.day.toString().padLeft(2, '0')}";

            sessionsMap.putIfAbsent(dayKey, () => <int>{});
            sessionsMap[dayKey]!.add(workout.workoutID);
          } catch (e) {
            print("Błąd parsowania daty notatki: ${note['date']}");
          }
        }
      }
    }

    if (sessionsMap.isEmpty) {
      print("Nie znaleziono żadnych dat notatek do migracji.");
      return;
    }

    int maxSessionID = await _getMaxSessionID(); // Funkcja zwraca max ID sesji w bazie

    for (final entry in sessionsMap.entries) {
      final dateParts = entry.key.split('-');
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      final sessionDate = DateTime(year, month, day);

      maxSessionID++;
      final session = TrainingSession(
        sessionID: maxSessionID,
        startDateTime: sessionDate,
        durationMinutes: 0, // oznacza trening z przeszłości
        workoutIDs: entry.value.toList(),
        preNote: null,
        postNote: null,
        planNames: null,
      );

      await box.put(session.sessionID, session);
      print("Dodano sesję ID: ${session.sessionID} dla dnia $sessionDate z workoutami: ${entry.value}");
    }

    print("Migracja zakończona. Dodano ${sessionsMap.length} sesji.");
  }

// Pomocnicza metoda do pobrania max ID sesji (implementacja zależna od box sesji)
  static Future<int> _getMaxSessionID() async {
    final allSessions = box.values.toList();
    if (allSessions.isEmpty) return 0;

    int maxId = 0;
    for (final session in allSessions) {
      if (session.sessionID > maxId) {
        maxId = session.sessionID;
      }
    }
    return maxId;
  }

  static List<TrainingSession> getAllSessions() => box.values.toList();
}
