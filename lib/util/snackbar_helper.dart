import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class SnackbarHelper {
  static DateTime? _lastSnackbarTime;

  static void showSnackbar(BuildContext context, String message) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final now = DateTime.now();

    // Sprawdzenie czy ostatni komunikat został wyświetlony mniej niż 10 sekund temu
    if (_lastSnackbarTime == null || now.difference(_lastSnackbarTime!) > const Duration(seconds: 10)) {
      _lastSnackbarTime = now; // Aktualizujemy czas ostatniego wyświetlenia

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            message,
            style: TextStyle(color: colorProvider.accent),
            textAlign: TextAlign.center,
          ),
          backgroundColor: colorProvider.secondary.withOpacity(0.9),
        ),
      );
    }
  }
}
