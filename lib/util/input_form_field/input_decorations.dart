import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/color_provider.dart';

class CustomInputDecorations {
  static InputDecoration buildInputDecoration(
    BuildContext context,
    String labelText, {
    bool isLabelVisible = true,
  }) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return InputDecoration(
      labelText: isLabelVisible ? labelText : null,
      labelStyle: TextStyle(color: colorProvider.accent.withOpacity(0.8)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: TextStyle(color: colorProvider.accent.withOpacity(0.5)),
      errorStyle: TextStyle(color: colorProvider.accent),
      counterStyle: TextStyle(color: colorProvider.accent),
      filled: true,
      fillColor:
          colorProvider.accent.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: colorProvider.accent.withOpacity(0.1), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorProvider.accent.withOpacity(0.5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorProvider.accent.withOpacity(0.5)),
      ),
    );
  }
}
