import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 5)
class User {
  @HiveField(0)
  late int userID;

  @HiveField(1)
  late String username;

  User(this.userID, this.username);

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
    };
  }

  int get typeIdForHive => userID;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 5;

  @override
  User read(BinaryReader reader) {
    return User(
      reader.readInt(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeInt(obj.userID);
    writer.writeString(obj.username);
  }
}

class UserBox {
  static late Box<User> box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    box = await Hive.openBox<User>('user');
/*    if (box.isEmpty) {
      await addDefaultData();
    }*/
  }

/*  static Future<void> addDefaultData() async {
    await addUser('Piotrek');
    await addUser('Karol');
    await addUser('Albert');
  }*/

  static Future<void> openBox() async {
    box = await Hive.openBox<User>('user');
  }

  static Future<void> closeBox() async {
    await box.close();
  }

  static Future<int> addUser(String username) async {
    final existingUsers = box.values.where((user) => user.username == username);

    if (existingUsers.isEmpty) {
      final int newIndex = await _getMaxIndex() + 1;
      final newUser = User(newIndex, username);
      await box.put(newIndex, newUser);
      print("User '$username' added with ID: $newIndex");
      return newIndex;
    } else {
      print("User '$username' already exists.");
      return -1;
    }
  }

  static Future<int> _getMaxIndex() async {
    final users = box.values.toList();
    int maxIndex = 0;
    for (final user in users) {
      if (user.userID > maxIndex) {
        maxIndex = user.userID;
      }
    }
    return maxIndex;
  }

  static Future<void> deleteUser(int userID) async {
    final usersToDelete = box.values.where((user) => user.userID == userID);
    if (usersToDelete.isNotEmpty) {
      await box.delete(usersToDelete.first.userID);
      print("User with ID: $userID deleted.");
    } else {
      print("User with ID: $userID not found.");
    }
  }

  static List<User> getAllUsers() {
    return box.values.toList();
  }

  static User? getUserByID(int id) {
    return box.get(id);
  }

  static Future<void> deleteAllUsers() async {
    await box.clear();
  }

  static List<int> getAllUserIDs() {
    return box.values.map((user) => user.userID).toList();
  }
}
