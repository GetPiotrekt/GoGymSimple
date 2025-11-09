import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../provider/color_provider.dart';
import '../../../../../../../provider/selected_options_provider.dart';
import '../../../../../../../provider/workout_provider.dart';
import '../../../../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../../../../util/snackbar_helper.dart';
import '../../../../add_exercise.dart';


class ExerciseListSection extends StatefulWidget {
  final bool isFromWorkout;

  const ExerciseListSection({super.key, required this.isFromWorkout});

  @override
  State<ExerciseListSection> createState() => _ExerciseListSectionState();
}

class _ExerciseListSectionState extends State<ExerciseListSection> {

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final selectedOptionsProvider =
    Provider.of<SelectedOptionsProvider>(context, listen: false);
    final trainingSessionProvider =
    Provider.of<WorkoutProvider>(context, listen: false);

    final selectedOptions = widget.isFromWorkout
        ? trainingSessionProvider.getSelectedOptions('Exercise')
        : selectedOptionsProvider.getSelectedOptions('Exercise');

    final options = ExerciseBox.getAllExercises()
        .map((e) => {'id': e.exerciseID, 'name': e.exerciseName})
        .toList();

    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: options.map((option) {
        final exercise = ExerciseBox.getExercisebyID(option['id'] as int);
        final isSelected = selectedOptions.contains(option['id'] as int);

        // Logika przeniesiona do pomocniczej funkcji:
        final selectedWorkoutPlanNames =
        _getWorkoutPlansForExercise(context, option['id'] as int);
        final belongsToWorkoutPlan = selectedWorkoutPlanNames.isNotEmpty;

        return _buildExerciseTile(
          context,
          colorProvider,
          exercise,
          option,
          isSelected,
          belongsToWorkoutPlan,
          selectedWorkoutPlanNames,
        );
      }).toList(),
    );
  }

  List<String> _getWorkoutPlansForExercise(BuildContext context, int id) {
    List<int> selectedWorkoutPlanIds;

    if (widget.isFromWorkout) {
      selectedWorkoutPlanIds =
          context.read<WorkoutProvider>().getSelectedOptions('Workout plan');
    } else {
      selectedWorkoutPlanIds =
          context.read<SelectedOptionsProvider>().getSelectedOptions('Workout plan');
    }

    final planNames = <String>[];

    for (var planId in selectedWorkoutPlanIds) {
      final plan = ListExerciseBox.getExerciseListByID(planId);
      if (plan != null && plan.exerciseIDs.contains(id)) {
        planNames.add(plan.exerciseListName);
      }
    }

    return planNames;
  }

  Widget _buildExerciseTile(
      BuildContext context,
      ColorProvider colorProvider,
      dynamic exercise,
      Map<String, dynamic> option,
      bool isSelected,
      bool belongsToWorkoutPlan,
      List<String> selectedWorkoutPlanNames,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorProvider.accent.withOpacity(0.3)
              : colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Row(
            children: [
              _buildIconButton(context, colorProvider, exercise),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  option['name'],
                  style: TextStyle(color: colorProvider.accent),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: belongsToWorkoutPlan
              ? Text(
            selectedWorkoutPlanNames.join(', '),
            style: TextStyle(
              color: colorProvider.accent,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          )
              : Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: colorProvider.accent,
          ),
          onTap: () => _onExerciseTap(context, option['id'], belongsToWorkoutPlan),
          onLongPress: () => _onExerciseLongPress(context, option['id']),
        ),
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context, ColorProvider colorProvider, dynamic exercise) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: (exercise != null && exercise.iconPath.isNotEmpty)
            ? Image.asset(
          exercise.iconPath,
          width: 24,
          height: 24,
          color: colorProvider.accent,
        )
            : Icon(Icons.edit, color: colorProvider.accent),
        onPressed: () {
          if (exercise != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AddExerciseDialog.showExerciseInputDialog(
                Navigator.of(context, rootNavigator: true).context,
                isEditing: true,
                initialName: exercise.exerciseName,
                initialIconPath: exercise.iconPath,
                exerciseId: exercise.exerciseID,
              );
            });
          }
        },
      ),
    );
  }

  void _onExerciseTap(BuildContext context, int id, bool blocked) {
    if (blocked) return;

    if (widget.isFromWorkout) {
      context.read<WorkoutProvider>().toggleOption('Exercise', id);
    } else {
      context.read<SelectedOptionsProvider>().toggleOption('Exercise', id);
    }

    setState(() {});
  }

  Future<void> _onExerciseLongPress(BuildContext context, int id) async {
    if (widget.isFromWorkout) return;
    final confirmed = await DeleteConfirmationDialog.show(context);
    if (confirmed == true) {
      await ExerciseBox.deleteExercise(id);
      setState(() {});
      SnackbarHelper.showSnackbar(
        context,
        AppLocalizations.of(context)!.tabBottomDrawer_refreshScreen,
      );
    }
  }
}