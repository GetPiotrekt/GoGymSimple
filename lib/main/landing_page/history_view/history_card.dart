import 'package:flutter/material.dart';
import '../../../data/data_tab_sector/gym_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/selected_options_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> noteData;
  final int index;
  final int listLength;
  final bool isLast;
  final bool isGrouped;

  const HistoryCard({
    super.key,
    required this.noteData,
    required this.index,
    required this.listLength,
    required this.isLast,
    this.isGrouped = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final note = noteData['note'];
    final workout = noteData['workout'];

    final user = UserBox.getUserByID(workout.userID);
    final gym = GymBox.getGym(workout.gymID);
    final exercise = ExerciseBox.getExercisebyID(workout.exerciseID);
    final String noteText = (note['note'] ?? '').toString().trim();

    final date = DateTime.parse(note['date']);
    final formattedDate = DateFormat('dd MMM yyyy', Localizations.localeOf(context).toString()).format(date);

    return GestureDetector(
      onTap: () {
        final selectedOptionsProvider = context.read<SelectedOptionsProvider>();

        selectedOptionsProvider.clearSelectedOption('User');
        selectedOptionsProvider.clearSelectedOption('Exercise');
        selectedOptionsProvider.clearSelectedOption('Gym');
        selectedOptionsProvider.clearSelectedOption('Workout plan');

        selectedOptionsProvider.setSelectedOption('User', user!.userID);
        selectedOptionsProvider.setSelectedOption('Exercise', exercise!.exerciseID);
        selectedOptionsProvider.setSelectedOption('Gym', gym!.gymID);
        selectedOptionsProvider.selectedViewMode = 'List';
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorProvider.accent.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikona + nazwa ćwiczenia
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    exercise?.exerciseName ?? t.historyView_exerciseNotFound,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorProvider.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (exercise?.iconPath?.isNotEmpty ?? false)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1.5,
                      color: colorProvider.accent.withOpacity(0.4),
                    ),
                  ),
                  child: Image.asset(
                    exercise?.iconPath ?? 'assets/icons/default.png',
                    width: 24,
                    height: 24,
                    color: colorProvider.accent,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/icons/default.png',
                        width: 24,
                        height: 24,
                        color: colorProvider.accent,
                      );
                    },
                  ),
                ),
              ],
            ),

            // Notatka
            if (noteText.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1.5,
                    color: colorProvider.accent.withOpacity(0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // wyrównanie do lewej
                  children: [
                    Text(
                      noteText,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorProvider.accent,
                      ),
                    ),
                    Divider(height: 6, color: colorProvider.accent.withOpacity(0.5),),
                    Align(
                      alignment: Alignment.center, // data na środku
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorProvider.accent.withOpacity(0.6),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
