import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../data/colors_db.dart';
import '../../data/config_db.dart';

class AppColors {
  static late Color primary;
  static late Color secondary;
  static late Color accent;

  static bool _initialized = false;

  static Future<void> init() async {
    if (!_initialized) {
      await _updateColors();
      _initialized = true;
    }
  }

  static bool get isInitialized => _initialized;

  static Future<void> _updateColors() async {
    final String pattern = await _getPatternFromAppConfig();
    final List<ColorCombination> colorCombinations = ColorCombinationBox.getAllColorCombinations();

    // Filter combinations based on the retrieved pattern
    final filteredCombinations = colorCombinations.where((comb) => comb.group == pattern);

    // Assign colors based on filtered combinations
    for (final combination in filteredCombinations) {
      switch (combination.type) {
        case 'primary':
          primary = Color(combination.color);
          break;
        case 'secondary':
          secondary = Color(combination.color);
          break;
        case 'accent':
          accent = Color(combination.color);
          break;
      }
    }
  }

  static Future<String> _getPatternFromAppConfig() async {
    final allConfigs = ConfigBox.getAllConfigs();
    final patternConfig = allConfigs.firstWhereOrNull((config) => config.key == 'pattern');

    if (patternConfig != null) {
      print(patternConfig.value);
      return patternConfig.value;
    } else {
      print("AppConfig with key 'pattern' not found. Using default pattern.");
      return 'Ciemny';
    }
  }

  static Future<void> refreshPalette() async {
    if (_initialized) {
      await _updateColors();
    }
  }
}
