import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../data/colors_db.dart';
import '../data/config_db.dart';

class ColorProvider with ChangeNotifier {
  late Color _primaryColor;
  late Color _secondaryColor;
  late Color _accentColor;

  Color get primary => _primaryColor;
  Color get secondary => _secondaryColor;
  Color get accent => _accentColor;

  // Inicjacja kolorów na podstawie ustawionego w lokalnej bazie danych motywu (pattern)
  Future<void> loadColorsFromDatabase() async {
    // Pobieranie motywu
    String? selectedTheme = ConfigBox.getConfig('pattern');

    if (selectedTheme != null) {
      // Pobieranie odpowiednich wartości
      var primaryComb = ColorCombinationBox.getAllColorCombinations()
          .firstWhereOrNull((comb) => comb.group == selectedTheme && comb.type == 'primary');
      var secondaryComb = ColorCombinationBox.getAllColorCombinations()
          .firstWhereOrNull((comb) => comb.group == selectedTheme && comb.type == 'secondary');
      var accentComb = ColorCombinationBox.getAllColorCombinations()
          .firstWhereOrNull((comb) => comb.group == selectedTheme && comb.type == 'accent');

      if (primaryComb != null) _primaryColor = Color(primaryComb.color);
      if (secondaryComb != null) _secondaryColor = Color(secondaryComb.color);
      if (accentComb != null) _accentColor = Color(accentComb.color);
    }

    notifyListeners(); // Powiadomienie elementów interfejsu o nowych kolorach
  }

  // Zaktualizowanie kolorów
  Future<void> updateColors(Color primary, Color secondary, Color accent) async {
    _primaryColor = primary;
    _secondaryColor = secondary;
    _accentColor = accent;

    notifyListeners(); // Powiadomienie elementów interfejsu o nowych kolorach
  }

  // New method to update the current palette based on the selected group
  Future<void> updateCurrentPalette(String selectedGroup) async {
    // Retrieve colors associated with the selected palette
    var primaryComb = ColorCombinationBox.getAllColorCombinations()
        .firstWhereOrNull((comb) => comb.group == selectedGroup && comb.type == 'primary');
    var secondaryComb = ColorCombinationBox.getAllColorCombinations()
        .firstWhereOrNull((comb) => comb.group == selectedGroup && comb.type == 'secondary');
    var accentComb = ColorCombinationBox.getAllColorCombinations()
        .firstWhereOrNull((comb) => comb.group == selectedGroup && comb.type == 'accent');

    if (primaryComb != null) _primaryColor = Color(primaryComb.color);
    if (secondaryComb != null) _secondaryColor = Color(secondaryComb.color);
    if (accentComb != null) _accentColor = Color(accentComb.color);

    // Notify listeners to update the UI
    notifyListeners();
  }
}
