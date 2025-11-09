import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/color_provider.dart';
import '../../provider/settings_provider.dart';
import 'home_screen.dart';
import 'util/initializers/app_initializer.dart';
import 'data/config_db.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  double _progress = 0.0;
  double _targetProgress = 0.0;

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_progressController)
      ..addListener(() {
        if (mounted) setState(() => _progress = _progressAnimation.value);
      });

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.fastOutSlowIn),
    );

    _startInitialization();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  Future<void> _startInitialization() async {
    await AppInitializer.initialize((step) {
      _targetProgress = step / 10;
      _progressAnimation = Tween<double>(
        begin: _progress,
        end: _targetProgress,
      ).animate(CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ));

      _progressController
        ..reset()
        ..forward();
    });

    if (!mounted) return;

    try {
      await Provider.of<ColorProvider>(context, listen: false).loadColorsFromDatabase();
      await Provider.of<SettingsProvider>(context, listen: false).loadSettings();
    } catch (e) {
      print('⚠️ Provider load error: $e');
    }
    final isFirstLaunch = await ConfigBox.isFirstLaunch();

    // ⏳ Poczekaj sekundę po pełnym pasku
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    try {
      await Provider.of<ColorProvider>(context, listen: false).loadColorsFromDatabase();
      await Provider.of<SettingsProvider>(context, listen: false).loadSettings();
    } catch (e) {
      print('⚠️ Provider load error: $e');
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Przejdź do HomeScreen z MaterialApp
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(isFirstLaunch: isFirstLaunch),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) => Opacity(
                opacity: _opacityAnimation.value,
                child: child,
              ),
              child: const Text(
                'GoGymSimple',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'BarlowSemiCondensed',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white24,
                color: Colors.white,
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
