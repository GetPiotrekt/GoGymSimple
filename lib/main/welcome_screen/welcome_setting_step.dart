import 'package:flutter/material.dart';
import '../../data/colors_db.dart';
import '../../data/config_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../util/button_icon.dart';

class WelcomeSettingStep {
  static Widget build({
    required BuildContext context,
    required bool isMetric,
    required Color selectedColor,
    required void Function(bool) onMeasurementChanged,
    required void Function(Color) onThemeChanged,
    required VoidCallback onNext,
    required VoidCallback onAddCustomTheme,
    required ColorProvider cp,
  }) {
    final t = AppLocalizations.of(context)!;
    String? selectedTheme = ConfigBox.getConfig('pattern');

    Color tempSelectedColor = selectedColor != Colors.transparent
        ? selectedColor
        : ColorCombinationBox.getAllColorCombinations()
        .firstWhere((c) => c.type == 'primary')
        .color as Color;

    return StatefulBuilder(
      builder: (context, setState) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cp.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.welcomeSettingStep_appSettings,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: cp.accent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pomiar
                  Text(
                    t.welcomeSettingStep_measurementSystem,
                    style: TextStyle(color: cp.accent.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildToggleChip(
                        t.welcomeSettingStep_metric,
                        isMetric,
                            () => onMeasurementChanged(true),
                        cp,
                      ),
                      const SizedBox(width: 8),
                      _buildToggleChip(
                        t.welcomeSettingStep_imperial,
                        !isMetric,
                            () => onMeasurementChanged(false),
                        cp,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Motywy
                  Text(
                    t.welcomeSettingStep_appTheme,
                    style: TextStyle(color: cp.accent.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ..._buildColorThemesFromHive(
                          selectedColor: tempSelectedColor,
                          onTap: (newColor, themeName) {
                            debugPrint("Clicked on: $themeName");
                            if (tempSelectedColor.value != newColor.value) {
                              setState(() {
                                tempSelectedColor = newColor;
                                debugPrint("Selected theme: $themeName");
                              });
                            }
                          },
                        ),
                        _addThemeCircle(onAddCustomTheme, cp),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Przycisk zatwierdzający
                  SizedBox(
                    width: double.maxFinite,
                    child: ButtonIcon(
                      onPressed: () async {
                        if (tempSelectedColor == Colors.transparent) return;
                        await ConfigBox.updateConfig('welcome_screen', '1');
                        onThemeChanged(tempSelectedColor);
                        onNext();
                      },
                      iconData: Icons.check_circle_rounded,
                      labelText: t.welcomeSettingStep_enterGoGymSimple,
                      backgroundColor: cp.accent.withOpacity(0.1),
                      textColor: cp.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _themeCircleFromCombination({
    required Color primaryColor,
    required Color secondaryColor,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: selected ? 48 : 40,
        height: selected ? 48 : 40,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          border: selected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Container(
            width: selected ? 24 : 20,
            height: selected ? 24 : 20,
            decoration: BoxDecoration(
              color: secondaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }


  static Widget _addThemeCircle(VoidCallback onTap, ColorProvider cp) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: cp.accent.withOpacity(0.7), width: 1.5),
        ),
        child: Center(
          child: Icon(Icons.add, color: cp.accent.withOpacity(0.7), size: 20),
        ),
      ),
    );
  }

  static Widget _buildToggleChip(
      String label,
      bool selected,
      VoidCallback onTap,
      ColorProvider cp,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? cp.accent : cp.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(color: selected ? cp.secondary : cp.accent)),
      ),
    );
  }

  static List<Widget> _buildColorThemesFromHive({
    required Color selectedColor,
    required void Function(Color, String) onTap,
  }) {
    final combinations = ColorCombinationBox.getAllColorCombinations();

    // Grupy unikalne (np. ☀, 🌙)
    final groups = combinations.map((e) => e.group).toSet();

    List<Widget> widgets = [];

    for (final group in groups) {
      final primary = combinations.firstWhere((c) => c.group == group && c.type == 'primary', orElse: () => ColorCombination(0, '', '', 0));
      final secondary = combinations.firstWhere((c) => c.group == group && c.type == 'secondary', orElse: () => ColorCombination(0, '', '', 0));
      final accent = combinations.firstWhere((c) => c.group == group && c.type == 'accent', orElse: () => ColorCombination(0, '', '', 0));

      // Skip if incomplete theme
      if ([primary, secondary, accent].any((c) => c.color == 0)) continue;

      widgets.add(
        _themeCircleFromCombination(
          primaryColor: Color(primary.color),
          secondaryColor: Color(secondary.color),
          selected: selectedColor.value == Color(primary.color).value,
          onTap: () => onTap(Color(primary.color), group), // 👈 pass group as name
        ),
      );

    }

    return widgets;
  }
}
