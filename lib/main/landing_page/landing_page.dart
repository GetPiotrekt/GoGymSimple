import 'dart:ui';

import 'package:GoGymSimple/main/drawer/tools/time/timer_floating_button.dart';
import 'package:GoGymSimple/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../provider/color_provider.dart';
import '../../provider/landing_page_provider.dart';
import '../../provider/selected_options_provider.dart';
import '../drawer/drawer.dart';
import '../workout_screen/workout_screen.dart';
import 'exercise_view/exercise_view.dart';
import 'history_view/history_view.dart';
import 'tab_sector/tab_sector.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>  with SingleTickerProviderStateMixin {
  final GlobalKey _workoutButtonKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final landingPageProvider = context.watch<LandingPageProvider>();

    if (landingPageProvider.isIconPressed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTutorial();

        // Zresetuj flagę po pokazaniu tutoriala
        context.read<LandingPageProvider>().isIconPressed == false;
      });
    }
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black54,
      paddingFocus: 25,
      opacityShadow: 0.8,
      hideSkip: true,
      onClickTarget: (target) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkoutScreen()),
        );
      },
    )..show(context: context);
  }

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: "workout_button",
        keyTarget: _workoutButtonKey,
        paddingFocus: 25,
        contents: [],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final selectedOptions = context.watch<SelectedOptionsProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: AppBar(
        backgroundColor: colorProvider.secondary,
        foregroundColor: colorProvider.accent,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'GoGymSimple',
          style: TextStyle(
            fontFamily: 'BarlowSemiCondensed',
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: colorProvider.accent,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WorkoutScreen()),
                );
              },
              child: Icon(
                key: _workoutButtonKey,
                workoutProvider.isStarted ? Icons.pause : Icons.play_arrow,
                size: 24,
                color: colorProvider.accent,
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabSector(
            colorProvider: colorProvider,
          ),
          Container(
            height: 1,
            color: colorProvider.secondary,
            child: Container(height: 1, color: colorProvider.accent.withOpacity(0.4)),
          ),
          Expanded(
            child: selectedOptions.viewMode == 'List'
                ? const ExerciseView()
                : const HistoryView(),
          ),
        ],
      ),
      floatingActionButton: const TimerFloatingButton(),
    );
  }
}

