
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
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>  with SingleTickerProviderStateMixin {
  final GlobalKey _workoutButtonKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final landingPageProvider = context.watch<LandingPageProvider>();

    if (landingPageProvider.isIconPressed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTutorial();
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
    )..show(context: context);

    // Automatyczne zakończenie tutoriala po 2 sekundach
    Future.delayed(const Duration(seconds: 2), () {
      if (tutorialCoachMark != null && tutorialCoachMark!.isShowing) {
        tutorialCoachMark!.finish();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkoutScreen()),
        );
      }
    });
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'GoGymSimple',
            style: TextStyle(
              fontFamily: 'BarlowSemiCondensed',
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: colorProvider.accent,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WorkoutScreen()),
                  );
                },
                child: AnimatedContainer(
                  key: _workoutButtonKey,
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: colorProvider.accent.withValues(alpha: 0.1), width: 1.5)
                  ),
                  child: workoutProvider.isStarted
                      ? Icon(
                        Icons.play_circle_fill,
                        size: 26,
                        color: colorProvider.accent,
                      )
                      : Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        size: 20,
                        color: colorProvider.accent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Start",
                        style: TextStyle(
                          color: colorProvider.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                ),
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

