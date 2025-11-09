import 'package:flutter/material.dart';
import '../../../../../provider/color_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../util/input_form_field/input_decorations.dart';

class BmrInputForm extends StatelessWidget {
  final bool isPounds;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController heightFeetController;
  final TextEditingController heightInchesController;
  final TextEditingController ageController;
  final String gender;
  final VoidCallback onGenderToggle;
  final VoidCallback onChanged;

  const BmrInputForm({
    super.key,
    required this.isPounds,
    required this.weightController,
    required this.heightController,
    required this.heightFeetController,
    required this.heightInchesController,
    required this.ageController,
    required this.gender,
    required this.onGenderToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: CustomInputDecorations.buildInputDecoration(
                    context,
                    isPounds ? t.calculator1RM_weightLabelLbs : t.calculator1RM_weightLabelKg,
                  ),
                  onChanged: (_) => onChanged(),
                  onSubmitted: (_) {
                    onChanged();
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(
                    color: colorProvider.accent,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: ageController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: false),
                  decoration: CustomInputDecorations.buildInputDecoration(
                    context,
                    t.calculatorBmr_age_label,
                  ),
                  onChanged: (_) => onChanged(),
                  onSubmitted: (_) {
                    onChanged();
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(
                    color: colorProvider.accent,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: isPounds
                    ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: heightFeetController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        decoration: CustomInputDecorations.buildInputDecoration(
                          context,
                          t.calculatorBmr_height_label_imperial_feet,
                        ),
                        onChanged: (_) => onChanged(),
                        onSubmitted: (_) {
                          onChanged();
                          FocusScope.of(context).unfocus();
                        },
                        style: TextStyle(
                          color: colorProvider.accent,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: heightInchesController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        decoration: CustomInputDecorations.buildInputDecoration(
                          context,
                          t.calculatorBmr_height_label_imperial_inches,
                        ),
                        onChanged: (_) => onChanged(),
                        onSubmitted: (_) {
                          onChanged();
                          FocusScope.of(context).unfocus();
                        },
                        style: TextStyle(
                          color: colorProvider.accent,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
                    : TextField(
                  controller: heightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: CustomInputDecorations.buildInputDecoration(
                    context,
                    t.calculatorBmr_height_label_metric,
                  ),
                  onChanged: (_) => onChanged(),
                  onSubmitted: (_) {
                    onChanged();
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(
                    color: colorProvider.accent,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onGenderToggle,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: colorProvider.accent.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          gender == 'male' ? Icons.male : Icons.female,
                          color: colorProvider.accent,
                          size: 22,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          gender == 'male' ? t.calculatorBmr_male : t.calculatorBmr_female,
                          style: TextStyle(
                            color: colorProvider.accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
