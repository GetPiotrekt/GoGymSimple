import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 13)
class QuickText {
  @HiveField(0)
  late int noteID;

  @HiveField(1)
  String? category;

  @HiveField(2)
  late String text;

  QuickText(this.noteID, this.category, this.text);

  Map<String, dynamic> toJson() {
    return {
      'noteID': noteID,
      'category': category,
      'text': text,
    };
  }
}

class QuickTextAdapter extends TypeAdapter<QuickText> {
  @override
  final int typeId = 13;

  @override
  QuickText read(BinaryReader reader) {
    return QuickText(
      reader.readInt(),
      reader.read() as String?,
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, QuickText obj) {
    writer.writeInt(obj.noteID);
    writer.write(obj.category);
    writer.writeString(obj.text);
  }
}

class QuickTextBox {
  static late Box<QuickText> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(QuickTextAdapter());
    box = await Hive.openBox<QuickText>('QuickTexts');
    if (box.isEmpty) {
      await addDefaultData();
    }
  }

  static Future<void> addDefaultData() async {
    await addQuickNote('Symbols', 'kg');
    await addQuickNote('Symbols', 'lbs');
    await addQuickNote('Symbols', '✓');
    await addQuickNote('Symbols', '✗');
  }

  static Future<void> addQuickNote(String? category, String text) async {
    final int newIndex = await _getMaxIndex() + 1;
    final newNote = QuickText(newIndex, category, text);
    await box.put(newIndex, newNote);
  }

  static Future<int> _getMaxIndex() async {
    final notes = box.values.toList();
    int maxIndex = 0;
    for (final note in notes) {
      if (note.noteID > maxIndex) {
        maxIndex = note.noteID;
      }
    }
    return maxIndex;
  }

  static List<QuickText> getAllNotes() {
    return box.values.toList();
  }

  static List<QuickText> getNotesByCategory(String? category) {
    return box.values.where((note) => note.category == category).toList();
  }

  static Future<void> updateQuickNote(int noteID, String? category, String text) async {
    final updatedNote = QuickText(noteID, category, text);
    await box.put(noteID, updatedNote);
  }

  static QuickText? getNoteByID(int id) {
    return box.get(id);
  }

  static Future<void> deleteNoteByID(int id) async {
    await box.delete(id);
  }

  static Future<void> deleteAllNotes() async {
    await box.clear();
  }
}
