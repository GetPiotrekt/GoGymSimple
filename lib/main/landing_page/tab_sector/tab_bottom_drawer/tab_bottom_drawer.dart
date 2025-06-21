import 'package:GoGymSimple/main/landing_page/tab_sector/tab_bottom_drawer/bottom_drawers/workout_plan_bottom_drawer.dart';
import 'package:flutter/material.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../l10n/app_localizations.dart';
import 'bottom_drawers/exercise_bottom_drawer.dart';
import 'bottom_drawers/user_gym_bottom_drawer/user_gym_bottom_drawer.dart';

class TabBottomDrawer {
  final ColorProvider colorProvider;

  TabBottomDrawer({
    required this.colorProvider,
  });

  void showTabBottomDrawer(
    BuildContext context,
    String title, {
    bool isFromWorkout = false,
  }) {
    final t = AppLocalizations.of(context)!;
    if (title == 'UserAndGym') {
      UserGymBottomDrawer.show(context);
      return;
    }
    if (title == 'Exercise') {
      ExerciseBottomDrawer.show(context, isFromWorkout: isFromWorkout);
      return;
    }
    if (title == 'Workout plan') {
      WorkoutPlanBottomDrawer.show(context: context, isFromWorkout: isFromWorkout);
      return;
    }
  }
}
