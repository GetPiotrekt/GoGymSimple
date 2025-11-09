import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';

class BMRResults extends StatelessWidget {
  final Map<String, double> bmrByActivity;
  final double weight; // weight in kg or lbs depending on system
  final bool isMetric; // true = metric (kg), false = imperial (lbs)

  const BMRResults({
    super.key,
    required this.bmrByActivity,
    required this.weight,
    required this.isMetric,
  });

  // Konwersja wagi na kg jeśli jest w lbs
  double _getWeightInKg() {
    if (isMetric) {
      return weight;
    } else {
      return weight / 2.20462; // lbs -> kg
    }
  }

  String _calculateProteinRange(double weight, String activityLevel, AppLocalizations t) {
    double minProteinKg, maxProteinKg;

    switch (activityLevel) {
      case 'Niska aktywność':
        minProteinKg = weight * 1.2;
        maxProteinKg = weight * 1.5;
        break;
      case 'Średnia aktywność':
        minProteinKg = weight * 1.6;
        maxProteinKg = weight * 2.2;
        break;
      case 'Wysoka aktywność':
        minProteinKg = weight * 1.8;
        maxProteinKg = weight * 2.4;
        break;
      case 'Bardzo wysoka aktywność':
        minProteinKg = weight * 2.0;
        maxProteinKg = weight * 3.0;
        break;
      default:
        minProteinKg = weight * 1.2;
        maxProteinKg = weight * 1.5;
    }

      final minProtein = (minProteinKg).round();
      final maxProtein = (maxProteinKg).round();
      return t.bmrResults_proteinOnlyGrams(
        maxProtein.toString(),
        minProtein.toString(),
      );

  }


  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    if (bmrByActivity.isEmpty) {
      return Text(t.bmrResults_noData, style: TextStyle(color: colorProvider.accent));
    }

    final weightInKg = _getWeightInKg();

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
            t.bmrResults_title,
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
              final proteinRange = _calculateProteinRange(weightInKg, activityLevel, t);

              String translatedActivityLevel;
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
                            '$translatedActivityLevel:',
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

