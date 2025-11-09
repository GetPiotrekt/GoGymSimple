import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class Gym {
  @HiveField(0)
  final int gymID;

  @HiveField(1)
  String name;

  Gym(this.gymID, this.name);

  Map<String, dynamic> toJson() {
    return {
      'gymID': gymID,
      'name': name,
    };
  }
}

class GymAdapter extends TypeAdapter<Gym> {
  @override
  final int typeId = 2;

  @override
  Gym read(BinaryReader reader) {
    return Gym(
      reader.readInt(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Gym obj) {
    writer.writeInt(obj.gymID);
    writer.writeString(obj.name);
  }
}

class GymBox {
  static late Box<Gym> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GymAdapter());
    box = await Hive.openBox<Gym>('gym');
  }

  static Future<void> openBox() async {
    box = await Hive.openBox<Gym>('gym');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<int> addGym(String name) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newGym = Gym(newIndex, name);
    await box.put(newIndex, newGym);
    return newIndex;  // Zwracamy ID zapisanej siłowni
  }

  static Future<void> updateGym(int gymID, String newName) async {
    final gymToUpdate = box.values.firstWhereOrNull((gym) => gym.gymID == gymID);
    if (gymToUpdate != null) {
      gymToUpdate.name = newName;
      await box.put(gymID, gymToUpdate);
      print("Gym with ID: $gymID updated.");
    } else {
      print("Gym with ID: $gymID not found.");
    }
  }

  static Gym? getGym(int gymID) {
    return box.get(gymID);
  }

  static Future<int> _getMaxIndex() async {
    if (box.isEmpty) return 0;
    return box.values.map((gym) => gym.gymID).reduce((a, b) => a > b ? a : b);
  }

  static Future<void> deleteGym(int gymID) async {
    if (box.containsKey(gymID)) {
      await box.delete(gymID);
      print("Gym with ID: $gymID deleted.");
    } else {
      print("Gym with ID: $gymID not found.");
    }
  }

  static List<Gym> getAllGyms() {
    return box.values.toList();
  }

  static List<int> getAllGymIDs() {
    return box.values.map((gym) => gym.gymID).toList();
  }

  static Future<void> deleteAllGyms() async {
    await box.clear();
    print("All gyms deleted.");
  }
}
