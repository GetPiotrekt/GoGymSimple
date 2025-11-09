import 'package:flutter/material.dart';

import '../../data/data_tab_sector/gym_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../util/button_icon.dart';
import '../../util/input_form_field/input_form_field.dart';

class WelcomeGymLocationStep {
  static Widget build({
    required BuildContext context,
    required bool isHomeSelected,
    required bool isGymSelected,
    required List<TextEditingController> gymControllers,
    required VoidCallback onAddGymField,
    required Function(bool) onHomeToggle,
    required Function(bool) onGymToggle,
    required ColorProvider cp,
    required VoidCallback onNext,
  }) {
    final t = AppLocalizations.of(context)!;

    final atLeastOneGymFilled =
    gymControllers.any((c) => c.text.trim().isNotEmpty);

    final shouldShowNextButton =
        (isHomeSelected || isGymSelected) &&
            (isHomeSelected || atLeastOneGymFilled);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.welcomeGymLocationStep_workoutPreferences,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: cp.accent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.welcomeGymLocationStep_whereDoYouTrain,
                      style: TextStyle(
                        fontSize: 16,
                        color: cp.accent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildOptionButton(
                          label: t.welcomeGymLocationStep_homeWorkout,
                          icon: Icons.home,
                          isSelected: isHomeSelected,
                          onTap: () => onHomeToggle(!isHomeSelected),
                          color: cp.accent.withOpacity(0.1),
                          accent: cp.accent,
                        ),
                        const SizedBox(width: 12),
                        _buildOptionButton(
                          label: t.welcomeGymLocationStep_gym,
                          icon: Icons.fitness_center,
                          isSelected: isGymSelected,
                          onTap: () => onGymToggle(!isGymSelected),
                          color: cp.accent.withOpacity(0.1),
                          accent: cp.accent,
                        ),
                      ],
                    ),
                    if (isGymSelected) const SizedBox(height: 20),
                    if (isGymSelected)
                      ...gymControllers.asMap().entries.map((entry) {
                        final i = entry.key;
                        final controller = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: InputFormField(
                            labelText:
                            t.welcomeGymLocationStep_gymNameLabel(i + 1),
                            controller: controller,
                            keyboardType: TextInputType.text,
                            fontSize: 18,
                            onChanged: (val) {
                              if (i == gymControllers.length - 1 &&
                                  val.trim().isNotEmpty) {
                                onAddGymField();
                              }
                            },
                          ),
                        );
                      }),
                    if (shouldShowNextButton) const SizedBox(height: 16),
                    if (shouldShowNextButton)
                      SizedBox(
                        width: double.infinity,
                        child: ButtonIcon(
                          onPressed: () async {
                            if (isHomeSelected) {
                              await GymBox.addGym(
                                  t.welcomeGymLocationStep_homeWorkout);
                            }
                            if (isGymSelected) {
                              for (final controller in gymControllers) {
                                final name = controller.text.trim();
                                if (name.isNotEmpty) {
                                  await GymBox.addGym(name);
                                }
                              }
                            }
                            FocusScope.of(context).unfocus();
                            onNext();
                          },
                          iconData: Icons.arrow_forward,
                          labelText: t.welcomeGymLocationStep_next,
                          backgroundColor: cp.accent.withOpacity(0.1),
                          textColor: cp.accent,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget _buildOptionButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
    required Color accent,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? color : accent.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: accent, width: 1.5)
                : Border.all(color: accent.withOpacity(0.5)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: accent),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(color: accent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
