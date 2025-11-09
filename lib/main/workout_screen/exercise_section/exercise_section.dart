import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../landing_page/tab_sector/tab_bottom_drawer/tab_bottom_drawer.dart';
import 'exercise_note_tile.dart';
import 'general_note_bottom_sheet.dart';

class ExerciseSection extends StatefulWidget {
  const ExerciseSection({super.key});

  @override
  State<ExerciseSection> createState() => _ExerciseSectionState();
}

class _ExerciseSectionState extends State<ExerciseSection> {
  int? _lastUserId;
  final Map<String, bool> _showNoteField = {};
  final Map<String, TextEditingController> _noteControllers = {};
  late TextEditingController _generalNoteController;

  String _userExerciseKey(int userId, int exerciseId) => '$userId-$exerciseId';

  @override
  void initState() {
    super.initState();
    _generalNoteController = TextEditingController();
  }

  @override
  void dispose() {
    _generalNoteController.dispose();
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

    final planNames =
        workoutProvider.selectedPlans.map((p) => p.exerciseListName).join(', ');
    final plansLabel = planNames.isEmpty ? t.workoutScreen_plans : planNames;

    final selectedExercises = workoutProvider.selectedExercises
        .map((id) => workoutProvider.getExerciseNameById(id.exerciseID))
        .whereType<Exercise>()
        .toList();

    _generalNoteController.text = workoutProvider.generalNote ?? '';

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
            onPlansTap: () =>
                _openBottomDrawer(context, colorProvider, 'Workout plan'),
          ),
          const SizedBox(height: 12),
          ...selectedExercises.asMap().entries.map((entry) {
            final index = entry.key;
            final exercise = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildExerciseItem(
                context,
                exercise.exerciseName,
                exercise.exerciseID,
                userId,
                index,
              ),
            );
          }),
          _buildAddExerciseButton(context, colorProvider, t),
          //const SizedBox(height: 8),
          //_buildGeneralNoteButton(context, colorProvider, t),
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
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(BuildContext context, String title, int exerciseID,
      int userID, int index) {
    final key = _userExerciseKey(userID, exerciseID);

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
      index: index,
    );
  }

  Widget _buildAddExerciseButton(
    BuildContext context,
    ColorProvider colorProvider,
    AppLocalizations t,
  ) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: ElevatedButton.icon(
              onPressed: () =>
                  _openBottomDrawer(context, colorProvider, 'Exercise'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),

        if (context.read<WorkoutProvider>().selectedExercises.length >= 2)
          const SizedBox(width: 8),

        // 👇 widoczne tylko, gdy dodano >= 2 ćwiczenia
        if (context.read<WorkoutProvider>().selectedExercises.length >= 2)
          SizedBox(
            child: IconButton(
              icon: Icon(Icons.format_list_numbered_rounded,
                  size: 24, color: colorProvider.accent),
              onPressed: () =>
                  _openBottomDrawer(context, colorProvider, 'ExerciseOrder'),
              style: IconButton.styleFrom(
                backgroundColor: colorProvider.accent.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGeneralNoteButton(
    BuildContext context,
    ColorProvider colorProvider,
    AppLocalizations t,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showGeneralNoteDialog(context),
        icon: Icon(Icons.notes, size: 20, color: colorProvider.accent),
        label: Text(
          t.workoutScreen_addGeneralNote,
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

  void _showGeneralNoteDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          GeneralNoteBottomSheet(controller: _generalNoteController),
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
