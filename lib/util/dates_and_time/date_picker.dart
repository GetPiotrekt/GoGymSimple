import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/color_provider.dart';

Future<DateTime?> showCustomDatePicker(
    BuildContext context,
    DateTime initialDate, {
      bool selectPastDates = false,
    }) async {
  final colorProvider = Provider.of<ColorProvider>(context, listen: false);

  // Pobierz aktualny język aplikacji
  final locale = Localizations.localeOf(context);

  // Zakres dostępnych dat
  DateTime firstDate = selectPastDates ? DateTime(2000) : DateTime.now();
  DateTime lastDate = selectPastDates ? DateTime.now() : DateTime(DateTime.now().year + 100);

  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    locale: locale,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          primaryColor: colorProvider.primary,
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: colorProvider.accent),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          colorScheme: ColorScheme.dark(
            primary: colorProvider.accent.withOpacity(0.5),
            onPrimary: colorProvider.accent,
            onSurface: colorProvider.accent,
            surface: colorProvider.secondary,
          ),
        ),
        child: Builder(
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: colorProvider.accent,
                ),
              ),
              child: child!,
            );
          },
        ),
      );
    },
  );
}
