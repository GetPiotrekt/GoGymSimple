import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 8)
class UserMeasurement {
  @HiveField(0)
  late int userMeasurementID; // Unikalny identyfikator pomiaru

  @HiveField(1)
  final int userID;

  @HiveField(2)
  final String date; // Przechowujemy datę w formacie ISO 8601

  @HiveField(3)
  late final String bodyPart; // Część ciała (np. "klatka piersiowa", "brzuch")

  @HiveField(4)
  double value; // Wartość pomiaru (np. obwód)

  UserMeasurement({
    required this.userMeasurementID, // Unikalny identyfikator pomiaru
    required this.userID,
    required this.date,
    required this.bodyPart,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'userMeasurementID': userMeasurementID,
      'userID': userID,
      'date': date,
      'bodyPart': bodyPart,
      'value': value,
    };
  }
}

class UserMeasurementAdapter extends TypeAdapter<UserMeasurement> {
  @override
  final int typeId = 8;

  @override
  UserMeasurement read(BinaryReader reader) {
    return UserMeasurement(
      userMeasurementID: reader.readInt(),
      userID: reader.readInt(),
      date: reader.readString(),
      bodyPart: reader.readString(),
      value: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, UserMeasurement obj) {
    writer.writeInt(obj.userMeasurementID);
    writer.writeInt(obj.userID);
    writer.writeString(obj.date);
    writer.writeString(obj.bodyPart);
    writer.writeDouble(obj.value);
  }
}

class UserMeasurementBox {
  static late Box<UserMeasurement> box;

  static Future<void> initBox() async {
    Hive.registerAdapter(UserMeasurementAdapter());
    box = await Hive.openBox<UserMeasurement>('measurement_history');
  }

  static Future<void> updateCategoryName(int userID, String oldCategory, String newCategory) async {
    // Update the category name in the database, based on the userID and category name
    var box = await Hive.openBox<UserMeasurement>('user_measurements');
    var measurements = box.values.where((m) => m.userID == userID && m.bodyPart == oldCategory).toList();

    for (var measurement in measurements) {
      measurement.bodyPart = newCategory;
      await box.put(measurement.userMeasurementID, measurement);
    }
  }

  static Future<void> addMeasurement(int userID, String bodyPart, double value, DateTime date) async {
    String dateString = date.toIso8601String();

    // Ustalanie userMeasurementID na podstawie najwyższego istniejącego ID
    int userMeasurementID = await getMaxMeasurementIndex() + 1;

    // Sprawdzanie, czy istnieje już wpis na dany dzień i część ciała
    final existingEntryIndex = box.values.toList().indexWhere(
          (entry) => entry.userID == userID && entry.date == dateString && entry.bodyPart == bodyPart,
    );

    if (existingEntryIndex != -1) {
      // Aktualizacja istniejącego wpisu
      final existingEntry = box.values.toList()[existingEntryIndex];
      existingEntry.value = value;
      await box.put(existingEntry.userMeasurementID, existingEntry);
      print("Updated measurement for user $userID, body part $bodyPart on $dateString");
    } else {
      // Tworzenie nowego wpisu
      final newEntry = UserMeasurement(
        userMeasurementID: userMeasurementID,
        userID: userID,
        date: dateString,
        bodyPart: bodyPart,
        value: value,
      );
      await box.put(newEntry.userMeasurementID, newEntry);
      print("Added measurement for user $userID, body part $bodyPart on $dateString");
    }
  }

  // Funkcja do pobrania największego istniejącego ID pomiaru
  static Future<int> getMaxMeasurementIndex() async {
    final measurements = box.values.toList();
    int maxIndex = 0;
    for (final measurement in measurements) {
      if (measurement.userMeasurementID > maxIndex) {
        maxIndex = measurement.userMeasurementID;
      }
    }
    return maxIndex;
  }

  static List<UserMeasurement> getMeasurementHistory(int userID) {
    return box.values.where((entry) => entry.userID == userID).toList();
  }

  static Future<void> clearAll() async {
    await box.clear();
    print("Cleared all measurement entries.");
  }

  static Future<void> deleteMeasurementsByUserAndBodyPart(int userID, String bodyPart) async {
    final entriesToDelete = box.values.where((entry) => entry.userID == userID && entry.bodyPart == bodyPart).toList();

    if (entriesToDelete.isNotEmpty) {
      for (var entry in entriesToDelete) {
        await box.delete(entry.userMeasurementID);
        print("Deleted measurement for user $userID, body part $bodyPart on ${entry.date}");
      }
    } else {
      print("No measurements found for user $userID and body part $bodyPart.");
    }
  }

  static Future<bool> deleteMeasurementsByID(int userMeasurementID) async {
    final measurementToDelete = box.values.where((measurement) => measurement.userMeasurementID == userMeasurementID);
    if (measurementToDelete.isNotEmpty) {
      await box.delete(measurementToDelete.first.userMeasurementID);
      print("MeasurementID: $userMeasurementID deleted.");
      return true;
    } else {
      print("MeasurementID: $userMeasurementID not found.");
      return false;
    }
  }
}
