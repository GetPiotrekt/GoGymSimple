import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 7)
class UserWeight {
  @HiveField(0)
  final int userID;

  @HiveField(1)
  final String date; // Przechowujemy jako String ISO 8601

  @HiveField(2)
  double weight;

  UserWeight({
    required this.userID,
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'date': date,
      'weight': weight,
    };
  }
}

class UserWeightAdapter extends TypeAdapter<UserWeight> {
  @override
  final int typeId = 7;

  @override
  UserWeight read(BinaryReader reader) {
    return UserWeight(
      userID: reader.readInt(),
      date: reader.readString(),
      weight: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, UserWeight obj) {
    writer.writeInt(obj.userID);
    writer.writeString(obj.date);
    writer.writeDouble(obj.weight);
  }
}

class UserWeightBox {
  static late Box<UserWeight> box;

  static Future<void> initBox() async {
    Hive.registerAdapter(UserWeightAdapter());
    box = await Hive.openBox<UserWeight>('weight_history');
  }

  static Future<void> addWeight(int userID, double weight, DateTime date) async {
    String dateString = date.toIso8601String();

    // Sprawdzamy, czy wpis dla tego dnia już istnieje
    final existingEntryIndex = box.values.toList().indexWhere(
          (entry) => entry.userID == userID && entry.date == dateString,
    );

    if (existingEntryIndex != -1) {
      // Aktualizacja istniejącego wpisu
      final existingEntry = box.values.toList()[existingEntryIndex];
      existingEntry.weight = weight;
      await box.put(existingEntryIndex, existingEntry);
      print("Updated weight for user $userID on $dateString");
    } else {
      // Tworzymy nowy wpis
      final newEntry = UserWeight(userID: userID, date: dateString, weight: weight);
      await box.add(newEntry);
      print("Added weight for user $userID on $dateString");
    }
  }

  static List<UserWeight> getWeightHistory(int userID) {
    return box.values.where((entry) => entry.userID == userID).toList();
  }

  static Future<void> deleteUserWeight(int userID, DateTime date) async {
    String dateString = date.toIso8601String();
    final entryToDelete = box.values.firstWhere(
          (entry) => entry.userID == userID && entry.date == dateString,
      orElse: () => throw Exception("Entry not found"),
    );

    await box.delete(entryToDelete);
    print("Deleted weight entry for user $userID on $dateString");
    }

  static Future<void> clearAll() async {
    await box.clear();
    print("Cleared all weight entries.");
  }
}
