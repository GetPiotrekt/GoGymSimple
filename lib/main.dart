import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'data/colors_db.dart';
import 'data/config_db.dart';
import 'data/data_tab_sector/gym_db.dart';
import 'data/data_tab_sector/list_exercise_db.dart';
import 'data/data_tab_sector/exercise_db.dart';
import 'data/data_tab_sector/user_data/user_db.dart';
import 'data/data_tab_sector/user_data/user_measurement_db.dart';
import 'data/data_tab_sector/user_data/user_weight_db.dart';
import 'data/notification_db.dart';
import 'data/workout_db.dart';
import 'l10n/app_localizations.dart';
import 'provider/color_provider.dart';
import 'provider/exercise_provider.dart';
import 'provider/landing_page_provider.dart';
import 'provider/notification_provider.dart';
import 'provider/selected_options_provider.dart';
import 'provider/settings_provider.dart';
import 'provider/time_provider.dart';
import 'main/notification_service.dart';
import 'main/theme/app_colors.dart';
import 'main/landing_page/landing_page.dart';
import 'main/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await MobileAds.instance.initialize();
  tz.initializeTimeZones();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  await ColorCombinationBox.initBox();
  await ConfigBox.initBox();
  await GymBox.initBox();
  await ExerciseBox.initBox();
  await ListExerciseBox.initBox();
  await UserBox.initBox();
  await WorkoutBox.initBox();
  await UserWeightBox.initBox();
  await UserMeasurementBox.initBox();
  await AppNotificationBox.initBox();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => SelectedOptionsProvider()),
        ChangeNotifierProvider(create: (_) => LandingPageProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _colorsLoaded = false;
  bool _showSplashScreen = true;
  bool _settingsLoaded = false;
  bool? _isFirstLaunch;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await AppColors.init();
    await Provider.of<ColorProvider>(context, listen: false).loadColorsFromDatabase();
    await Provider.of<SettingsProvider>(context, listen: false).loadSettings(); // Wczytaj język i ustawienia
    bool isFirstLaunch = await ConfigBox.isFirstLaunch(); // Await here

    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _colorsLoaded = true;
        _settingsLoaded = true;
        _showSplashScreen = false;
        _isFirstLaunch = isFirstLaunch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplashScreen) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black38,
          body: Center(
            child: Text(
              'GoGYM',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'BarlowSemiCondensed',
                fontSize: 40,
                fontWeight: FontWeight.w600,
                height: 0.9,
              ),
            ),
          ),
        ),
      );
    }

    if (!_colorsLoaded || !_settingsLoaded) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black38,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final locale = Provider.of<SettingsProvider>(context).getAppLocale;

    return MaterialApp(
      debugShowCheckedModeBanner: false, // <-- dodane

      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl'),
        Locale('en'),
        Locale('es', 'ES'), // Hiszpania
        Locale('es', 'CO'), // Kolumbia
        Locale('it'),
        Locale('de'),
        Locale('nl')
      ],
      title: 'GoGYM',
      home: _isFirstLaunch! ? const WelcomeScreen() : const LandingPage(),
    );
  }
}
