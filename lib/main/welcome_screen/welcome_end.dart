import 'package:GoGymSimple/main/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/color_provider.dart';
import '../../l10n/app_localizations.dart';

class WelcomeEnd extends StatefulWidget {
  const WelcomeEnd({super.key});

  @override
  _WelcomeEndState createState() => _WelcomeEndState();
}

class _WelcomeEndState extends State<WelcomeEnd> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); // Access color provider

    final t = AppLocalizations.of(context)!; // Get localized strings

    return WillPopScope(
      onWillPop: () async => false, // Disable back gesture
      child: Scaffold(
        backgroundColor: colorProvider.secondary, // Use color from provider
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events,
                  color: colorProvider.accent, // Use color from provider
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  t.welcomeEnd_welcome, // Use localized text
                  style: TextStyle(
                    color: colorProvider.accent, // Use color from provider
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    // Navigate back to ResultsMain with an animation
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LandingPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
