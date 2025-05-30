import 'package:flutter/material.dart';

ThemeData buildCustomTheme({
  required Color primary,
  required Color secondary,
  required Color accent,
}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      onPrimary: accent,
      onSecondary: accent,
    ),
    scaffoldBackgroundColor: primary,
    cardColor: secondary,
    dividerColor: accent.withOpacity(0.5),
    focusColor: accent,
    highlightColor: accent.withOpacity(0.3),
    hintColor: accent.withOpacity(0.7),
    hoverColor: accent.withOpacity(0.2),
    indicatorColor: accent,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: accent),
      bodyMedium: TextStyle(color: accent),
      bodySmall: TextStyle(color: accent.withOpacity(0.8)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: secondary,
      titleTextStyle: const TextStyle(fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondary,
      selectedItemColor: accent,
      unselectedItemColor: accent.withOpacity(0.7),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: secondary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: accent,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondary,
      foregroundColor: accent,
    ),
    iconTheme: IconThemeData(color: accent),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(secondary),
      checkColor: WidgetStateProperty.all(accent),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(accent),
      trackColor: WidgetStateProperty.all(secondary),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: secondary,
      titleTextStyle: TextStyle(color: accent, fontSize: 18),
      contentTextStyle: TextStyle(color: accent),
    ),
    cardTheme: CardThemeData(
      color: secondary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
