import 'package:GoGymSimple/main/workout_screen/workout_dialog/save_workout_dialog.dart';
import 'package:GoGymSimple/main/workout_screen/users_row.dart';
import 'package:GoGymSimple/provider/ad_provider.dart';
import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data_tab_sector/exercise_db.dart';
import '../../data/data_tab_sector/gym_db.dart';
import '../../data/data_tab_sector/user_data/user_db.dart';
import '../../data/workout/session_data/session_data_db.dart';
import '../../data/workout/session_data/workout_note_db.dart';
import '../../data/workout/workout_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../provider/selected_options_provider.dart';
import '../../provider/settings_provider.dart';
import '../../provider/workout_provider.dart';
import '../../util/snackbar_helper.dart';
import '../drawer/settings/notification_screen/notification_service.dart';
import '../drawer/support/watch_ad/watch_ad.dart';
import '../drawer/tools/time/timer_floating_button.dart';
import '../landing_page/landing_page.dart';
import 'ad_icon_timer.dart';
import 'exercise_section/exercise_section.dart';
import 'gym_date_section.dart';
import 'workout_dialog/interrupted_workout_dialog.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  bool hasAnyNoteValue = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndRestoreSession(); // sprawdzenie sesji
      _checkIfAnyNoteIsFilled();
    });
  }

  void _checkAndRestoreSession() {
    final session = SessionDataBox.getSession();
    final note = WorkoutNoteBox.getAllNotes();
    final workoutProvider = context.read<WorkoutProvider>();
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);

    if (session != null &&
        session.selectedGymID != 0 &&
        workoutProvider.isStarted == false) {
      _showRestoreSessionDialog(session, note, colorProvider);
    }
  }

  void _showRestoreSessionDialog(
      SessionData session, List<WorkoutNote> note, ColorProvider cp) {
    final gym = GymBox.getGym(session.selectedGymID);
    final gymName = gym?.name ?? '';

    final participants = note
        .map((n) => UserBox.getUserByID(n.userID)?.username ?? '')
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();

    if (participants.isEmpty) {
      final fallbackUser = UserBox.getUserByID(1);
      if (fallbackUser != null) {
        participants.add(fallbackUser.username);
      }
    }

    final exercises = session.selectedExerciseIDs == null ||
        session.selectedExerciseIDs!.isEmpty
        ? <String>[]
        : session.selectedExerciseIDs!
        .map<String>((id) => ExerciseBox.getExercisebyID(id)?.exerciseName ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

    showDialog(
      context: context,
      builder: (context) => InterruptedWorkoutDialog(
        gymLocation: gymName,
        participants: participants,
        exercises: exercises,
        date: session.selectedDate,
        onRestore: () {
          final workoutProvider = context.read<WorkoutProvider>();
          workoutProvider.restoreSessionFromData(session, note);
          Navigator.of(context).pop();
        },
        onStartFresh: () {
          SessionDataBox.deleteSession();
          WorkoutNoteBox.deleteAllNotes();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _checkIfAnyNoteIsFilled() {
    final workoutProvider = context.read<WorkoutProvider>();
    final results = workoutProvider.results;

    bool anyFilled = results.values.any((exerciseMap) =>
        exerciseMap.values.any((note) => note.trim().isNotEmpty));

    if (hasAnyNoteValue != anyFilled) {
      setState(() {
        hasAnyNoteValue = anyFilled;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _checkIfAnyNoteIsFilled());
  }

  void _endWorkout() {
    SaveWorkoutDialog.show(
      context,
      onSave: () => _saveWorkout(),
    );
  }

  void _saveWorkout() async {
    final workoutProvider = context.read<WorkoutProvider>();
    final t = AppLocalizations.of(context)!;

    final gymID = workoutProvider.selectedGymId.isNotEmpty
        ? int.tryParse(workoutProvider.selectedGymId) ?? 0
        : 0;

    if (gymID == 0) {
      SnackbarHelper.showSnackbar(context, t.workoutScreen_noGymSelected);
      return;
    }

    final allData = workoutProvider.results;

    // Pobierz datę z providera, jeśli jest null to ustaw DateTime.now()
    final String dateToUse = workoutProvider.selectedDate!.toIso8601String();

    for (var userEntry in allData.entries) {
      final userId = userEntry.key;
      final exerciseMap = userEntry.value;

      for (var exerciseEntry in exerciseMap.entries) {
        final exerciseId = exerciseEntry.key;
        final noteText = exerciseEntry.value;

        if (noteText.isEmpty) {
          // Pomijamy puste notatki
          continue;
        }

        const globalNote = '';
        const quickValue = '';
        final notes = [
          {
            'note': noteText,
            'date': dateToUse,
          }
        ];

        final workoutKey = WorkoutBox.box.keys.firstWhere(
          (key) {
            final workout = WorkoutBox.box.get(key);
            return workout != null &&
                workout.userID == userId &&
                workout.exerciseID == exerciseId &&
                workout.gymID == gymID;
          },
          orElse: () => null,
        );

        if (workoutKey != null) {
          final workout = WorkoutBox.box.get(workoutKey);
          for (final note in notes) {
            await WorkoutBox.addNote(workout!.workoutID, note);
          }
        } else {
          await WorkoutBox.addWorkout(
            gymID,
            userId,
            exerciseId,
            globalNote,
            quickValue,
            notes: notes,
          );
        }
      }
    }

    SnackbarHelper.showSnackbar(context, t.workoutScreen_saved);
    final selectedOptionsProvider = context.read<SelectedOptionsProvider>();

    selectedOptionsProvider.clearSelectedOption('User');
    selectedOptionsProvider.clearSelectedOption('Exercise');
    selectedOptionsProvider.clearSelectedOption('Gym');
    selectedOptionsProvider.clearSelectedOption('Workout plan');

    selectedOptionsProvider.selectedViewMode = 'List';
    NotificationService().cancelTrainingOngoingNotification();
    workoutProvider.endWorkout(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final t = AppLocalizations.of(context)!;
    final settingsProvider = context.watch<SettingsProvider>();
    final adProvider = context.watch<AdProvider>();
    final DateTime adIconVisibleFrom = DateTime(2025, 7, 15); // yyyy, mm, dd

    final bottomMargin = (settingsProvider.getElementVisibility ? 60.0 : 8.0);

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.workoutScreen_title,
        actions: (workoutProvider.selectedGymId.isNotEmpty &&
            adProvider.isHidden &&
            DateTime.now().isAfter(adIconVisibleFrom))
            ? [
          const AdIconOrTimer(),
        ]
            : null,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(8, 8, 8, bottomMargin),
            child: Column(
              children: [
                if (workoutProvider.selectedGymId.isNotEmpty) ...[
                  const GymDateSection(),
                  const SizedBox(height: 8),
                  _buildExerciseSection(context),
                ] else ...[
                  _buildExerciseSection(context),
                  const SizedBox(height: 8),
                  const GymDateSection(),
                ],

                if (hasAnyNoteValue) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _endWorkout,
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: colorProvider.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .saveWorkoutDialog_save_workout_button,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorProvider.accent,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.check_circle_rounded,
                              size: 22,
                              color: colorProvider.accent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: bottomMargin),
                ],
                if (!hasAnyNoteValue && workoutProvider.isStarted) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Przerwij trening
                      workoutProvider.endWorkout(context);
                      SnackbarHelper.showSnackbar(context, t.workoutScreen_workoutCancelled);
                      // Przenieś do LandingPage
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LandingPage()),
                            (Route<dynamic> route) => false, // usuwa wszystkie poprzednie ekrany
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: colorProvider.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.workoutScreen_cancelWorkout,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorProvider.accent,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.cancel_rounded,
                              size: 22,
                              color: colorProvider.accent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: bottomMargin),
                ],
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const TimerFloatingButton(),
    );
  }

  Widget _buildExerciseSection(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = context.watch<ColorProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final bool isGymSelected = workoutProvider.selectedGymId.isEmpty;

    return Stack(
      children: [
        Opacity(
          opacity: (!isGymSelected) ? 1.0 : 0.10,
          child: const Column(
            children: [
              UsersRow(),
              SizedBox(height: 8),
              ExerciseSection(),
            ],
          ),
        ),
        if (isGymSelected)
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock, size: 44, color: colorProvider.accent),
                  const SizedBox(height: 8),
                  Text(
                    t.workoutScreen_selectGymFirst,
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
