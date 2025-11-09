import 'package:flutter/material.dart';
import '../../../../../util/input_form_field/input_decorations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../l10n/app_localizations.dart';

class PlateInputField extends StatelessWidget {
  final TextEditingController barbellController;
  final TextEditingController totalController;
  final bool isPounds;
  final VoidCallback onChanged;
  final ColorProvider colorProvider;

  const PlateInputField({
    super.key,
    required this.barbellController,
    required this.totalController,
    required this.isPounds,
    required this.onChanged,
    required this.colorProvider,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final barbellLabel = isPounds
        ? t.plateCalculator_barbellWeightLabelLbs
        : t.plateCalculator_barbellWeightLabelKg;

    final totalLabel = isPounds
        ? t.plateCalculator_totalWeightLabelLbs
        : t.plateCalculator_totalWeightLabelKg;

    return Container(
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: barbellController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: CustomInputDecorations.buildInputDecoration(context, barbellLabel),
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
              controller: totalController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: CustomInputDecorations.buildInputDecoration(context, totalLabel),
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
    );
  }
}
