import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../input_form_field/input_form_field.dart';

class TextInputDialog {
  static Future<String?> showTextInputDialog({
    required BuildContext context,
    required String title,
    required String labelText,
    String? initialText,
    TextInputType inputType = TextInputType.text,
    Widget? extraWidget,
    int? maxLength,
  }) async {
    final TextEditingController controller = TextEditingController(text: initialText);
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final t = AppLocalizations.of(context)!;

        return Dialog(
          backgroundColor: colorProvider.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: colorProvider.accent, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                InputFormField(
                  labelText: labelText,
                  controller: controller,
                  keyboardType: inputType,
                  maxLength: maxLength,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.pop(context, value);
                    }
                  },
                ),
                if (extraWidget != null) ...[
                  const SizedBox(height: 12),
                  extraWidget, // 👉 wstawiamy widget jeśli jest
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(t.dialog_cancel, style: TextStyle(color: colorProvider.accent)),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          Navigator.pop(context, controller.text);
                        }
                      },
                      child: Text(t.dialog_save, style: TextStyle(color: colorProvider.accent)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
