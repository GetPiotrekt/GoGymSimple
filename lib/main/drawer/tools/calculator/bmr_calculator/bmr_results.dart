import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';

class BMRResults extends StatelessWidget {
  final Map<String, double> bmrByActivity;
  final double weight;

  const BMRResults({super.key, required this.bmrByActivity, required this.weight});

  // Function to calculate protein range
  String _calculateProteinRange(double weight, String activityLevel, AppLocalizations t) {
    double minProtein, maxProtein;

    switch (activityLevel) {
      case 'Niska aktywność':
        minProtein = weight * 1.2;
        maxProtein = weight * 1.5;
        break;
      case 'Średnia aktywność':
        minProtein = weight * 1.6;
        maxProtein = weight * 2.2;
        break;
      case 'Wysoka aktywność':
        minProtein = weight * 1.8;
        maxProtein = weight * 2.4;
        break;
      case 'Bardzo wysoka aktywność':
        minProtein = weight * 2.0;
        maxProtein = weight * 3.0;
        break;
      default:
        minProtein = weight * 1.2;
        maxProtein = weight * 1.5;
    }

    // Wyświetlamy tylko zakres w gramach
    return t.bmrResults_proteinOnlyGrams(
      maxProtein.toStringAsFixed(0),
      minProtein.toStringAsFixed(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!; // Localized text

    if (bmrByActivity.isEmpty) {
      return Text(t.bmrResults_noData, style: TextStyle(color: colorProvider.accent));
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.bmrResults_title, // Using the translation for the title
            textAlign: TextAlign.center,
            style: TextStyle(color: colorProvider.accent),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: bmrByActivity.entries
                .map((entry) {
              final activityLevel = entry.key;
              final bmr = entry.value;
              final proteinRange = _calculateProteinRange(weight, activityLevel, t); // Pass t here

              String translatedActivityLevel;
              // Use translation keys directly for activity levels
              switch (activityLevel) {
                case 'Podstawowe zapotrzebowanie':
                  translatedActivityLevel = t.basicActivity;
                  break;
                case 'Niska aktywność':
                  translatedActivityLevel = t.lowActivity;
                  break;
                case 'Średnia aktywność':
                  translatedActivityLevel = t.moderateActivity;
                  break;
                case 'Wysoka aktywność':
                  translatedActivityLevel = t.highActivity;
                  break;
                case 'Bardzo wysoka aktywność':
                  translatedActivityLevel = t.veryHighActivity;
                  break;
                default:
                  translatedActivityLevel = activityLevel;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$translatedActivityLevel:', // Translated activity level
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: colorProvider.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${bmr.toStringAsFixed(0)} kcal',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: colorProvider.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      proteinRange,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: colorProvider.accent,
                      ),
                    ),
                  ],
                ),
              );
            })
                .expand((widget) => [
              widget,
              Divider(color: colorProvider.accent.withOpacity(0.4)),
            ]).toList(),
          ),
        ],
      ),
    );
  }
}
