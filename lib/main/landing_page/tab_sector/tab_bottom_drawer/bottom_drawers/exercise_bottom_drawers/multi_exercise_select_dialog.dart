import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';
import '../../../../../../util/exercise_translations.dart';

class MultiExerciseSelectDialog {
  static final List<String> predefinedExercises = <String>[
    'barbellSquat',
    'deadlift',
    'benchPress',
    'overheadPress',
    'pullUp',
    'chinUp',
    'barbellRow',
    'dumbbellCurl',
    'tricepsDip',
    'latPulldown',
    'inclineBenchPress',
    'declineBenchPress',
    'legPress',
    'legCurl',
    'legExtension',
    'calfRaise',
    'seatedRow',
    'tBarRow',
    'pushUp',
    'sitUp',
    'crunch',
    'plank',
    'russianTwist',
    'jumpRope',
    'bicycleCrunch',
    'mountainClimbers',
    'kettlebellSwing',
    'sumoDeadlift',
    'frontSquat',
    'hackSquat',
    'hipThrust',
    'gluteBridge',
    'cableFly',
    'lateralRaise',
    'rearDeltFly',
    'hammerCurl',
    'skullCrusher',
    'facePull',
    'farmersWalk',
    'abWheelRollout',
    'cableRow',
    'inclineDumbbellCurl',
    'oneArmDumbbellRow',
    'dumbbellLunges',
    'gobletSquat',
    'bulgarianSplitSquat',
    'stepUp',
    'ezBarCurl',
    'arnoldPress',
  ];

    static Future<void> show(BuildContext context) async {
      final colorProvider = context.read<ColorProvider>();
      final t = AppLocalizations.of(context)!;

      final allExercises = ExerciseBox.getAllExercises();
      final existingNames = allExercises.map((e) => e.exerciseName).toSet();
      final selectedNames = <String>{};

      await showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Dialog(
                insetPadding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: colorProvider.secondary,
                child: Container(
                  width: constraints.maxWidth,
                  padding: const EdgeInsets.all(10),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.multiSelect_title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorProvider.accent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.multiSelect_subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: colorProvider.accent.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: colorProvider.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.5,
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: predefinedExercises.length,
                                itemBuilder: (context, index) {
                                  final key = predefinedExercises[index];
                                  final translatedName = ExerciseTranslationHelper.getTranslatedName(context, key);
                                  final isAlreadySaved = existingNames.contains(translatedName);
                                  final isSelected = selectedNames.contains(translatedName);

                                  return CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: colorProvider.accent,
                                    checkColor: colorProvider.secondary,
                                    side: BorderSide(color: colorProvider.accent, width: 2),
                                    fillColor: WidgetStateProperty.resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return colorProvider.accent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                    title: Text(
                                      translatedName + (isAlreadySaved ? ' (${t.multiSelect_added})' : ''),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isAlreadySaved
                                            ? colorProvider.accent.withOpacity(0.4) // przyciemnione
                                            : colorProvider.accent,
                                      ),
                                    ),
                                    value: isAlreadySaved
                                        ? true // zawsze zaznaczone
                                        : isSelected, // zaznaczenie dynamiczne
                                    onChanged: isAlreadySaved
                                        ? null // zablokowana zmiana
                                        : (checked) {
                                      setState(() {
                                        if (checked == true) {
                                          selectedNames.add(translatedName);
                                        } else {
                                          selectedNames.remove(translatedName);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: colorProvider.accent.withOpacity(0.4)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    t.dialog_cancel,
                                    style: TextStyle(color: colorProvider.accent),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorProvider.accent,
                                    foregroundColor: colorProvider.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final addedIds = <int>{};

                                    for (final name in selectedNames) {
                                      int id = await ExerciseBox.addExercise(name, '');
                                      addedIds.add(id);
                                    }

                                    Navigator.pop(context);
                                  },
                                  child: Text(t.dialog_confirm),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
