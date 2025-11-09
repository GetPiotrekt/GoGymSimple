import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart'; // Dodany import

class InfoDialogBMR extends StatelessWidget {
  const InfoDialogBMR({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final settingsProvider = context.watch<SettingsProvider>(); // Uzyskaj dostęp do ustawień
    final t = AppLocalizations.of(context)!;

    final bool isImperial = settingsProvider.getUnits == 'imperial'; // Sprawdź jednostki

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: colorProvider.secondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.bmrInfo_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorProvider.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                t.bmrInfo_text1,
                style: TextStyle(color: colorProvider.accent),
              ),
              const SizedBox(height: 10),
              Text(
                t.bmrInfo_text2,
                style: TextStyle(color: colorProvider.accent),
              ),
              const SizedBox(height: 15),
              Text(
                t.bmrInfo_recommended,
                style: TextStyle(color: colorProvider.accent),
              ),
              const SizedBox(height: 10),
              _buildProteinInfo(colorProvider, t, isImperial),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorProvider.secondary,
                  foregroundColor: colorProvider.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(t.bmrInfo_close),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProteinInfo(ColorProvider colorProvider, AppLocalizations t, bool isImperial) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProteinLevelInfo(colorProvider, t, 'low', 1.2, 1.5, isImperial),
        _buildProteinLevelInfo(colorProvider, t, 'medium', 1.6, 2.2, isImperial),
        _buildProteinLevelInfo(colorProvider, t, 'high', 1.8, 2.4, isImperial),
        _buildProteinLevelInfo(colorProvider, t, 'very_high', 2.0, 2.5, isImperial),
      ],
    );
  }

  Widget _buildProteinLevelInfo(
      ColorProvider colorProvider,
      AppLocalizations t,
      String level,
      double min,
      double max,
      bool isImperial,
      ) {
    String levelText;
    switch (level) {
      case 'low':
        levelText = t.lowActivity;
        break;
      case 'medium':
        levelText = t.moderateActivity;
        break;
      case 'high':
        levelText = t.highActivity;
        break;
      case 'very_high':
        levelText = t.veryHighActivity;
        break;
      default:
        levelText = '';
    }

    final String unit = isImperial ? t.perPound : t.perKilogram;

    // Konwersja do jednostek imperialnych jeśli potrzeba
    double displayMin = isImperial ? min / 2.20462 : min;
    double displayMax = isImperial ? max / 2.20462 : max;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '$levelText: ${displayMin.toStringAsFixed(2)} - ${displayMax.toStringAsFixed(2)}g $unit',
        style: TextStyle(color: colorProvider.accent),
      ),
    );
  }

}
