import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ColorCombination {
  @HiveField(0)
  late int colorID;

  @HiveField(1)
  late String group;

  @HiveField(2)
  late String type;

  @HiveField(3)
  late int color;

  ColorCombination(this.colorID, this.group, this.type, this.color);

  Map<String, dynamic> toJson() {
    return {
      'id': colorID,
      'group': group,
      'type': type,
      'color': color,
    };
  }
}

class ColorCombinationAdapter extends TypeAdapter<ColorCombination> {
  @override
  final int typeId = 0;

  @override
  ColorCombination read(BinaryReader reader) {
    return ColorCombination(
      reader.readInt(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ColorCombination obj) {
    writer.writeInt(obj.colorID);
    writer.writeString(obj.group);
    writer.writeString(obj.type);
    writer.writeInt(obj.color);
  }
}

class ColorCombinationBox {
  static late Box<ColorCombination> _box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ColorCombinationAdapter());
    _box = await Hive.openBox<ColorCombination>('color_combination');
    if (_box.isEmpty) {
      await addDefaultData();
    }
  }

  static Future<void> addDefaultData() async {
    await addColorCombination('🌙', 'primary', 4280361249); // ciemny
    await addColorCombination('🌙', 'secondary', 4282532418);
    await addColorCombination('🌙', 'accent', 4294638330);

    await addColorCombination('☀', 'primary', 0xFFE0E0E0); // jasny
    await addColorCombination('☀', 'secondary', 0xFFF5F5F5);
    await addColorCombination('☀', 'accent', 0xFF424242);

    await addColorCombination('🌊', 'primary', 4283002247); // morski
    await addColorCombination('🌊', 'secondary', 4279182147);
    await addColorCombination('🌊', 'accent', 4294967295);

    await addColorCombination('☕', 'primary', 4290155128); // kawa
    await addColorCombination('☕', 'secondary', 4293975228);
    await addColorCombination('☕', 'accent', 4278190080);
  }

  static Future<void> openBox() async {
    _box = await Hive.openBox<ColorCombination>('color_combination');
  }

  static Future<void> closeBox() async {
    await _box.close();
  }

  static Future<void> addColorCombination(String group, String type, int color) async {
    final existingColorCombinations = _box.values.where((comb) => comb.group == group && comb.type == type);

    if (existingColorCombinations.isEmpty) {
      final int newIndex = await _getMaxIndex() + 1;
      final newCombination = ColorCombination(newIndex, group, type, color);
      await _box.put(newIndex, newCombination);
    } else {
      print("Color combination with group '$group' and type '$type' already exists.");
    }
  }

  static Future<int> _getMaxIndex() async {
    final combinations = _box.values.toList();
    int maxIndex = 0;
    for (final comb in combinations) {
      if (comb.colorID > maxIndex) {
        maxIndex = comb.colorID;
      }
    }
    return maxIndex;
  }

  static Future<void> deleteColorCombination(int id) async {
    final combinationsToDelete = _box.values.where((comb) => comb.colorID == id);
    if (combinationsToDelete.isNotEmpty) {
      await _box.delete(combinationsToDelete.first.colorID);
      print("Color combination with ID: $id deleted.");
    } else {
      print("Color combination with ID: $id not found.");
    }
  }

  static List<ColorCombination> getAllColorCombinations() {
    return _box.values.toList();
  }

  static Future<void> deleteAllColorCombinations() async {
    await _box.clear();
  }
}
