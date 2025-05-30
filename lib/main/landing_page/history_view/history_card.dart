import 'package:flutter/material.dart';
import '../../../data/data_tab_sector/gym_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/settings_provider.dart';
import '../../../util/dates_and_time/days_ago.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> noteData;
  final int index;
  final int listLength;
  final bool isLast; // ← dodano

  const HistoryCard({
    super.key,
    required this.noteData,
    required this.index,
    required this.listLength,
    required this.isLast, // ← dodano
  });

  String _formatDate(BuildContext context, String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final relativeTime = DaysAgo.formatNoteDate(context, date);
      final locale = Localizations.localeOf(context).toString();

      if (date.hour == 0 && date.minute == 0 && date.second == 0) {
        return "${DateFormat("d MMM yyyy", locale).format(date)}  ($relativeTime)";
      } else {
        return "${DateFormat("d MMM yyyy · HH:mm", locale).format(date)}  ($relativeTime)";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = context.watch<ColorProvider>();
    final settingsProvider = context.watch<SettingsProvider>(); // ← dodano

    final note = noteData['note'];
    final workout = noteData['workout'];

    final exercise = ExerciseBox.getExercisebyID(workout.exerciseID);
    final user = UserBox.getUserByID(workout.userID);
    final gym = GymBox.getGym(workout.gymID);

    final formattedDate = _formatDate(context, note['date']);

    final bottomMargin = isLast
        ? (settingsProvider.getElementVisibility ? 80.0 : 16.0)
        : 8.0;

    return Container(
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.fromLTRB(
        8,
        index == 0 ? 16 : 8,
        8,
        bottomMargin,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise?.exerciseName ?? t.historyView_exerciseNotFound,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorProvider.accent,
                      ),
                    ),
                    Text(
                      '${user?.username} • ${gym?.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorProvider.accent.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
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
                  width: 38,
                  height: 38,
                  color: colorProvider.accent,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/default.png',
                      width: 38,
                      height: 38,
                      color: colorProvider.accent,
                    );
                  },
                ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1.5,
                  color: colorProvider.accent.withOpacity(0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${note['note']}',
                    style: TextStyle(
                      color: colorProvider.accent.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: colorProvider.accent.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
