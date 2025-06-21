import 'package:GoGymSimple/splash_screen.dart';
import 'package:GoGymSimple/util/initializers/provider_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'main/drawer/settings/notification_screen/notification_service.dart';
import 'l10n/app_localizations.dart';
import 'main/drawer/tools/tracker/measurement_tracker/measurement_tracker.dart';
import 'main/drawer/tools/tracker/weight_tracker.dart';
import 'main/workout_screen/workout_screen.dart';
import 'provider/settings_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: getAppProviders(),
      child: const MyApp(),
    ),
  );

  // Opóźniona inicjalizacja cięższych zasobów (Delayed heavy initialization)
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final notificationService = NotificationService();
    await notificationService.initNotification();
    await MobileAds.instance.initialize();
    tz.initializeTimeZones();
  });

  // Błąd Fluttera – pokaż w trybie debug (Flutter error handler)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  // Blokuj orientację tylko do pionu (Lock portrait mode)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<SettingsProvider>(context).getAppLocale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      navigatorKey: navigatorKey,
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
      routes: {
        '/training': (context) => const WorkoutScreen(),
        '/weight': (context) => const WeightTracker(),
        '/measurements': (context) => const MeasurementTracker(),
      },
      title: 'GoGYM',
      home: const SplashScreen(),
    );
  }
}
