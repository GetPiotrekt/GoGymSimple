import 'package:flutter/material.dart';

import '../provider/color_provider.dart';

class CustomDropdown {
  static BoxDecoration dropdownDecoration(ColorProvider colorProvider, {bool showBorder = true}) {
    return BoxDecoration(
      color: colorProvider.accent.withOpacity(0.1), // Use color from provider
      borderRadius: BorderRadius.circular(10),
    );
  }

  static TextStyle hintTextStyle(ColorProvider colorProvider) {
    return TextStyle(color: colorProvider.accent); // Use color from provider
  }

  static TextStyle dropdownItemStyle(ColorProvider colorProvider) {
    return TextStyle(color: colorProvider.accent, fontWeight: FontWeight.bold, fontSize: 16); // Use color from provider
  }

  static InputDecoration dropdownInputDecoration(ColorProvider colorProvider) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      filled: true,
      fillColor: colorProvider.accent.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none, // brak widocznej ramki
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

}
