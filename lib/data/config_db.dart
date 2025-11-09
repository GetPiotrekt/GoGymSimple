import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Config {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String key;

  @HiveField(2)
  late String value;

  Config(this.id, this.key, this.value);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }
}

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 1;

  @override
  Config read(BinaryReader reader) {
    return Config(
      reader.readInt(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.key);
    writer.writeString(obj.value);
  }
}

class ConfigBox {
  static late Box<Config> _box;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ConfigAdapter());
    _box = await Hive.openBox<Config>('app_config');
    if (_box.isEmpty) {
      await addDefaultData();
    }
  }

  static Future<void> addDefaultData() async {
    await addConfig('language', 'en');
    await addConfig('pattern', '🌙');
    await addConfig('timeShow', 'true');
    await addConfig('units', 'metric');
    await addConfig('ads', '0');
    await addConfig('ads_today', '0');
    await addConfig('last_ad_date', '');
    await addConfig('welcome_screen', '0');
    await addConfig('next_ad_time', '');
    await addConfig('ad_visible', 'true');
    await addConfig('migration_v1_completed', 'false');
  }

  static Future<void> openBox() async {
    _box = await Hive.openBox<Config>('app_config');
  }

  static Future<void> closeBox() async {
    await _box.close();
  }

  static Future<void> updateConfig(String key, String value) async {
    final configToUpdate = _box.values.firstWhereOrNull((config) => config.key == key);
    if (configToUpdate != null) {
      configToUpdate.value = value;
      await _box.put(configToUpdate.id, configToUpdate);
      print("Config with key: $key updated.");
    } else {
      await addConfig(key, value);
    }
  }

  static Future<void> addConfig(String key, String value) async {
    final existingConfig = _box.values.firstWhereOrNull((config) => config.key == key);

    if (existingConfig == null) {
      final int newIndex = await _getMaxIndex() + 1;
      final newConfig = Config(newIndex, key, value);
      await _box.put(newIndex, newConfig);
    } else {
      existingConfig.value = value;
      await _box.put(existingConfig.id, existingConfig);
    }
  }

  static String? getConfig(String key) {
    final config = _box.values.firstWhereOrNull((config) => config.key == key);
    return config?.value;
  }

  static Future<int> _getMaxIndex() async {
    final configs = _box.values.toList();
    int maxIndex = 0;
    for (final config in configs) {
      if (config.id > maxIndex) {
        maxIndex = config.id;
      }
    }
    return maxIndex;
  }

  static Future<void> deleteConfig(int id) async {
    final configsToDelete = _box.values.where((config) => config.id == id);
    if (configsToDelete.isNotEmpty) {
      await _box.delete(configsToDelete.first.id);
      print("Config with ID: $id deleted.");
    } else {
      print("Config with ID: $id not found.");
    }
  }

  static List<Config> getAllConfigs() {
    return _box.values.toList();
  }

  static Future<void> deleteAllConfigs() async {
    await _box.clear();
  }

  static Future<String?> getLocaleCode() async {
  final box = await Hive.openBox('config');
  return box.get('language');
  }

  static Future<bool> isFirstLaunch() async {
    await openBox(); // upewniamy się, że box jest otwarty
    final value = getConfig('welcome_screen');
    return value != '1'; // '1' oznacza, że ekran był już pokazany
  }
}
