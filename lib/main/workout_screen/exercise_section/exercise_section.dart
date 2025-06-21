import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../landing_page/tab_sector/tab_bottom_drawer/tab_bottom_drawer.dart';
import 'exercise_note_tile.dart';

class ExerciseSection extends StatefulWidget {
  const ExerciseSection({super.key});

  @override
  State<ExerciseSection> createState() => _ExerciseSectionState();
}

class _ExerciseSectionState extends State<ExerciseSection> {
  int? _lastUserId;
  final Map<String, bool> _showNoteField = {};
  final Map<String, TextEditingController> _noteControllers = {};
  String _userExerciseKey(int userId, int exerciseId) => '$userId-$exerciseId';

  @override
  void dispose() {
    for (var controller in _noteControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final userId = workoutProvider.currentUser?.userID ?? 1;
    final t = AppLocalizations.of(context)!;

    // Reset jeśli user się zmienił
    if (_lastUserId != userId) {
      _noteControllers.clear();
      _showNoteField.clear();
      _lastUserId = userId;
    }

    final planNames = workoutProvider.selectedPlans
        .map((p) => p.exerciseListName)
        .join(', ');
    final plansLabel = planNames.isEmpty ? t.workoutScreen_plans : planNames;

    final selectedExercises = workoutProvider.selectedExercises
        .map((id) => workoutProvider.getExerciseNameById(id.exerciseID))
        .whereType<Exercise>()
        .toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            context,
            title: t.workoutScreen_exercises,
            plansLabel: plansLabel,
            onPlansTap: () => _openBottomDrawer(context, colorProvider, 'Workout plan'),
          ),
          const SizedBox(height: 12),
          ...selectedExercises.map((exercise) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildExerciseItem(
              context,
              exercise.exerciseName,
              exercise.exerciseID,
              userId,
            ),
          )),
          _buildAddExerciseButton(context, colorProvider, t),
        ],
      ),
    );
  }


  Widget _buildSectionHeader(
      BuildContext context, {
        required String title,
        required String plansLabel,
        required VoidCallback onPlansTap,
      }) {
    final colorProvider = context.watch<ColorProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorProvider.accent,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onPlansTap,
          icon: Icon(Icons.list, size: 24, color: colorProvider.accent),
          label: Text(
            plansLabel,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: colorProvider.accent),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: colorProvider.accent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(
      BuildContext context, String title, int exerciseID, int userID) {
    final key = _userExerciseKey(userID, exerciseID);
    final showNote = _showNoteField[key] ?? false;

    final controller = _noteControllers.putIfAbsent(key, () {
      final textController = TextEditingController();
      final note =
      context.read<WorkoutProvider>().getExerciseResult(userID, exerciseID);
      textController.text = note ?? '';

      textController.addListener(() {
        context.read<WorkoutProvider>().addExerciseResult(
          userId: userID,
          exerciseId: exerciseID,
          result: textController.text,
        );
      });

      return textController;
    });

    return ExerciseNoteTile(
      title: title,
      exerciseID: exerciseID,
      userID: userID,
      controller: controller,
    );
  }

  Widget _buildAddExerciseButton(
      BuildContext context,
      ColorProvider colorProvider,
      AppLocalizations t,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _openBottomDrawer(context, colorProvider, 'Exercise'),
        icon: Icon(Icons.add, size: 20, color: colorProvider.accent),
        label: Text(
          t.workoutScreen_addExercise,
          style: TextStyle(color: colorProvider.accent, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorProvider.accent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _openBottomDrawer(
      BuildContext context,
      ColorProvider colorProvider,
      String title,
      ) {
    final bottomDrawer = TabBottomDrawer(colorProvider: colorProvider);
    bottomDrawer.showTabBottomDrawer(context, title, isFromWorkout: true);
  }
}
