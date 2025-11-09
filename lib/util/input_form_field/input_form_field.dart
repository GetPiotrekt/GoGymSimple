import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../snackbar_helper.dart';
import 'input_decorations.dart';

class InputFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorMessage;
  final List<TextInputFormatter>? inputFormatters;
  final double fontSize;
  final void Function(dynamic value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLength;

  const InputFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    this.errorMessage,
    this.inputFormatters,
    this.fontSize = 20.0,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textAlign = TextAlign.left,
    this.textAlignVertical = TextAlignVertical.center,
    this.focusNode,
    this.enabled = true,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return TextField(
      maxLength: maxLength,
      maxLines: null,
      minLines: 1,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: enabled ? inputFormatters : [],
      decoration: CustomInputDecorations.buildInputDecoration(
        context,
        labelText,
        isLabelVisible: true, // teraz zawsze pokazujemy label w środku pola
      ),
      style: TextStyle(
        color: enabled
            ? colorProvider.accent
            : colorProvider.accent.withOpacity(0.5),
        fontSize: fontSize,
      ),
      cursorColor: enabled
          ? colorProvider.accent
          : colorProvider.accent.withOpacity(0.5),
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      focusNode: enabled ? (focusNode ?? FocusNode()) : null,
      enabled: enabled,
      onTap: enabled
          ? () {
        if (controller.text.isEmpty) {
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        }
      }
          : null,
      onChanged: enabled
          ? (value) {
        if (value.isEmpty) {
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }

        if (value.contains(',')) {
          controller.text = value.replaceAll(',', '.');
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }

        if (value.contains('.') &&
            value.indexOf('.') != value.lastIndexOf('.')) {
          controller.text = value.replaceAll('.', '');
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        }

        if (onChanged != null) {
          onChanged!(value);
        }
      }
          : null,
      onEditingComplete: enabled
          ? () {
        bool isValid = _handleEditingComplete(context, t);
        if (onEditingComplete != null) {
          onEditingComplete!();
        }

        if (isValid) {
          FocusScope.of(context).unfocus();
        }
      }
          : null,
      onSubmitted: enabled
          ? (value) {
        bool isValid = _handleEditingComplete(context, t);
        if (onSubmitted != null) {
          onSubmitted!(value);
        }

        if (isValid) {
          FocusScope.of(context).unfocus();
        }
      }
          : null,
    );
  }

  bool _handleEditingComplete(BuildContext context, AppLocalizations t) {
    if (controller.text.isEmpty || double.tryParse(controller.text) == null) {
      SnackbarHelper.showSnackbar(context, t.inputFormField_invalidValue);
      return false;
    }

    double value = double.tryParse(controller.text) ?? 0;

    if (keyboardType == const TextInputType.numberWithOptions(decimal: false)) {
      controller.text = value.round().toString();
    }

    // Schowaj klawiaturę
    FocusScope.of(context).unfocus();

    // Usuń zaznaczenie (pozostaw tylko kursor na końcu)
    controller.selection = TextSelection.collapsed(offset: controller.text.length);

    return true;
  }
}
