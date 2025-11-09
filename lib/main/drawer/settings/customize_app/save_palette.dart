import 'package:flutter/material.dart';

import '../../../../data/colors_db.dart';
import '../../../../data/config_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../util/dialog/text_input_dialog.dart';
import '../../../../util/snackbar_helper.dart';

class SavePalette {
  // Zapisz kolory (Save colors)
  static void saveColors(BuildContext context, String name, Color primaryColor, Color secondaryColor, Color accentColor) async {
    await ColorCombinationBox.addColorCombination(
      name,
      'primary', // Główny kolor (Primary color)
      primaryColor.value,
    );
    await ColorCombinationBox.addColorCombination(
      name,
      'secondary', // Kolor pomocniczy (Secondary color)
      secondaryColor.value,
    );
    await ColorCombinationBox.addColorCombination(
      name,
      'accent', // Kolor akcentowy (Accent color)
      accentColor.value,
    );
    await ConfigBox.updateConfig('theme', name); // Ustawienie nowego motywu (Set new theme)

    // Get localized strings using AppLocalizations
    final t = AppLocalizations.of(context)!;

    // Wyświetlenie komunikatu o zapisaniu motywu (Display message about saving the theme)
    SnackbarHelper.showSnackbar(context, t.savePalette_themeSaved(name)); // Pass 'name' as an argument
  }

  // Wyświetlenie okna dialogowego do wpisania nazwy motywu (Display dialog for entering theme name)
  static Future<String?> showColorNameDialog(BuildContext context) async {
    final t = AppLocalizations.of(context)!; // Get localized strings using AppLocalizations

    return await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.savePalette_saveTheme, // Using localized text for the title
      labelText: t.savePalette_themeName, // Using localized text for the label
    );
  }
}
