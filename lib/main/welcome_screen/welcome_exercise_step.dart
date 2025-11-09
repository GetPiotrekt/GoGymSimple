import 'package:flutter/material.dart';
import 'package:GoGymSimple/provider/color_provider.dart';

import '../../data/data_tab_sector/exercise_db.dart';
import '../../l10n/app_localizations.dart';
import '../../util/button_icon.dart';
import '../../util/input_form_field/input_form_field.dart';

class WelcomeExerciseStep {
  static Locale? _previousLocale;

  static Widget build({
    required BuildContext context,
    required Locale locale,
    required List<String> allExercises,
    required Set<String> selectedExercises,
    required void Function(String exercise, bool selected) onExerciseToggle,
    required VoidCallback onNext,
    required VoidCallback onAddExercise,
    required TextEditingController newExerciseController,
    required ColorProvider cp,
    required void Function() onResetSelectedExercises,
  }) {
    if (_previousLocale != null && _previousLocale != locale) {
      onResetSelectedExercises();
    }
    _previousLocale = locale;

    final t = AppLocalizations.of(context)!;
    final shouldShowNextButton = selectedExercises.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cp.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.welcomeExerciseStep_favoriteExercises,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: cp.accent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.welcomeExerciseStep_selectFew,
                      style: TextStyle(color: cp.accent.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: allExercises.map((exercise) {
                        final isSelected = selectedExercises.contains(exercise);
                        return ChoiceChip(
                          label: Text(exercise),
                          selected: isSelected,
                          selectedColor: cp.secondary.withOpacity(0.8),
                          backgroundColor: cp.secondary.withOpacity(0.6),
                          checkmarkColor: cp.accent,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? cp.accent
                                : cp.accent.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected
                                  ? cp.accent.withOpacity(0.5)
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onSelected: (selected) {
                            onExerciseToggle(exercise, selected);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      t.welcomeExerciseStep_addYourOwn,
                      style: TextStyle(
                        color: cp.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    StatefulBuilder(
                      builder: (context, setState) {
                        newExerciseController.addListener(() {
                          setState(() {}); // odśwież widok, gdy tekst się zmienia
                        });

                        final hasText = newExerciseController.text.trim().isNotEmpty;

                        return Row(
                          children: [
                            Expanded(
                              child: InputFormField(
                                labelText: t.welcomeExerciseStep_exampleExercise,
                                controller: newExerciseController,
                                keyboardType: TextInputType.text,
                                fontSize: 16,
                                enabled: true,
                                onSubmitted: (_) => hasText ? onAddExercise() : null,
                              ),
                            ),
                            if (hasText) ...[
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: onAddExercise,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cp.accent,
                                  foregroundColor: cp.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(t.welcomeExerciseStep_addButton),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    if (shouldShowNextButton) const SizedBox(height: 24),
                    if (shouldShowNextButton)
                      SizedBox(
                        width: double.maxFinite,
                        child: ButtonIcon(
                          onPressed: () async {
                            for (final exercise in selectedExercises) {
                              final exists = ExerciseBox.getAllExercises()
                                  .any((e) => e.exerciseName.toLowerCase() == exercise.toLowerCase());
                              if (!exists) {
                                await ExerciseBox.addExercise(exercise, '');
                              }
                            }

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
          ),
        );
      },
    );
  }
}
