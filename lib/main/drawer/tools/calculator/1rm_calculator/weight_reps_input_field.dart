import 'package:flutter/material.dart';
import '../../../../../util/input_form_field/input_decorations.dart';
import '../../../../../provider/color_provider.dart';

class WeightRepsInputField extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController repsController;
  final bool isPounds;
  final VoidCallback onChanged;
  final ColorProvider colorProvider;
  final String weightLabel;
  final String repsLabel;

  const WeightRepsInputField({
    super.key,
    required this.weightController,
    required this.repsController,
    required this.isPounds,
    required this.onChanged,
    required this.colorProvider,
    required this.weightLabel,
    required this.repsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: CustomInputDecorations.buildInputDecoration(context, weightLabel),
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
              controller: repsController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: CustomInputDecorations.buildInputDecoration(context, repsLabel),
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
