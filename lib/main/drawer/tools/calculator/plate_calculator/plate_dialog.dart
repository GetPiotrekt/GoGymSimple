import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/snackbar_helper.dart';

class PlateDialog {
  static Future<void> calculateRequiredPlates(
      BuildContext context,
      double targetWeight,
      double barbellWeight,
      List<double> availablePlates,
      ) async {
    final t = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final unitLabel = settingsProvider.getUnits == 'imperial' ? 'lbs' : 'kg';

    if (targetWeight == 0) {
      SnackbarHelper.showSnackbar(context, t.plateDialog_invalidWeight);
      return;
    }

    if (targetWeight < barbellWeight) {
      SnackbarHelper.showSnackbar(context, t.plateDialog_invalidTargetWeight);
      return;
    }

    List<double> plates = List.from(availablePlates);
    plates.sort((a, b) => b.compareTo(a));

    double weightPerSide = (targetWeight - barbellWeight) / 2;

    if (weightPerSide < 0) {
      SnackbarHelper.showSnackbar(context, t.plateDialog_invalidTargetWeight);
      return;
    }

    List<List<double>> allCombinations = [];

    for (int exclusionIndex = 0; exclusionIndex < 5; exclusionIndex++) {
      if (exclusionIndex >= plates.length) break;
      List<double> filteredPlates = plates.sublist(exclusionIndex);
      List<List<double>> combinations = _findPlateCombinationsByLargestFirst(weightPerSide, filteredPlates);
      if (combinations.isNotEmpty) {
        allCombinations.add(combinations.first);
      }
    }

    allCombinations = _filterPlateCombinations(allCombinations);

    if (allCombinations.isEmpty) {
      SnackbarHelper.showSnackbar(context, t.plateDialog_noCombinationFound);
      return;
    }

    _showRequiredPlatesDialog(context, allCombinations, t, unitLabel);
  }

  static List<List<double>> _findPlateCombinationsByLargestFirst(
      double targetWeight, List<double> plates) {
    List<List<double>> combinations = [];

    void findCombination(double remainingWeight, List<double> currentCombination, int index) {
      if (remainingWeight == 0) {
        combinations.add(List.from(currentCombination));
        return;
      }

      for (int i = index; i < plates.length; i++) {
        final plate = plates[i];

        if (plate <= remainingWeight) {
          currentCombination.add(plate);
          findCombination(remainingWeight - plate, currentCombination, i);
          currentCombination.removeLast();
        }
      }
    }

    findCombination(targetWeight, [], 0);
    return combinations;
  }

  static List<List<double>> _filterPlateCombinations(List<List<double>> allCombinations) {
    Set<String> seenCombinations = {};
    List<List<double>> filteredCombinations = [];

    for (var combination in allCombinations) {
      String combinationString = combination.map((plate) => plate.toString()).join(',');

      Map<double, int> plateCounts = {};
      for (var plate in combination) {
        plateCounts[plate] = (plateCounts[plate] ?? 0) + 1;
      }

      bool shouldAdd = !seenCombinations.contains(combinationString) &&
          !plateCounts.values.any((count) => count > 6);

      if (shouldAdd) {
        seenCombinations.add(combinationString);
        filteredCombinations.add(combination);
      }
    }

    return filteredCombinations;
  }

  static void _showRequiredPlatesDialog(
      BuildContext context,
      List<List<double>> plateCombinations,
      AppLocalizations t,
      String unitLabel,
      ) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorProvider.secondary,
          title: FittedBox(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${t.plateDialog_proposedPlates} ',
                    style: TextStyle(color: colorProvider.accent),
                  ),
                  TextSpan(
                    text: t.plateDialog_forSide,
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(plateCombinations.length, (index) {
              Map<double, int> plateCounts = {};
              for (var plate in plateCombinations[index]) {
                plateCounts[plate] = (plateCounts[plate] ?? 0) + 1;
              }

              List<Widget> plateWidgets = plateCounts.entries.map((entry) {
                String weightText = entry.key % 1 == 0
                    ? entry.key.toStringAsFixed(0)
                    : entry.key.toString();
                String plateText = entry.value > 1
                    ? '$weightText $unitLabel x ${entry.value}'
                    : '$weightText $unitLabel';

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    plateText,
                    style: TextStyle(color: colorProvider.accent, fontSize: 16),
                  ),
                );
              }).toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          t.plateDialog_option((index + 1).toString()),
                          style: TextStyle(color: colorProvider.accent, fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: plateWidgets,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: colorProvider.accent.withOpacity(0.5),
                    endIndent: 16,
                    indent: 8,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Center(
                child: Text(
                  t.plateDialog_close,
                  style: TextStyle(color: colorProvider.accent),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
