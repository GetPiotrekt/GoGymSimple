import 'package:GoGymSimple/provider/color_provider.dart';
import 'package:GoGymSimple/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'main/drawer/tools/tracker/measurement_tracker/measurement_tracker.dart';
import 'main/drawer/tools/tracker/weight_tracker.dart';
import 'main/landing_page/landing_page.dart';
import 'main/welcome_screen/welcome_screen.dart';
import 'main/workout_screen/workout_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isFirstLaunch;

  const HomeScreen({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(
      builder: (context, colorProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GoGym',
          locale: Provider.of<SettingsProvider>(context).getAppLocale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pl'),
            Locale('en'),
            Locale('es', 'ES'),
            Locale('es', 'CO'),
            Locale('it'),
            Locale('de'),
            Locale('nl'),
          ],
          theme: ThemeData(
            primaryColor: colorProvider.primary,
            hintColor: colorProvider.accent,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: colorProvider.accent,
              selectionColor: colorProvider.accent.withOpacity(0.4),
              selectionHandleColor: colorProvider.accent,
            ),
            // inne właściwości theme, np. fontFamily, brightness itd.
          ),
          routes: {
            '/training': (context) => const WorkoutScreen(),
            '/weight': (context) => const WeightTracker(),
            '/measurements': (context) => const MeasurementTracker(),
          },
          home: isFirstLaunch ? const WelcomeScreen() : const LandingPage(),
        );
      },
    );
  }
}
