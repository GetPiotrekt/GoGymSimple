import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import 'exercise_stats_helper.dart';

class ExerciseStatsTile extends StatelessWidget {
  final int exerciseID;
  final List<int> workoutIDs;

  const ExerciseStatsTile({
    super.key,
    required this.exerciseID,
    required this.workoutIDs,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!; // <== Skrót

    final stats = ExerciseStatsHelper.getNoteStatisticsForWorkouts(workoutIDs);
    final totalNotesCount = stats['totalNotes'];
    final averageLine = ExerciseStatsHelper.formatToOneDecimal(stats['averageLinesPerNote'].toString());
    final averageLength = '${stats['averageCharsPerNote'].toStringAsFixed(0)}';
    final totalLines = stats['totalLines'].toString();
    final totalChars = stats['totalChars'].toString();

    final trainingDays = ExerciseStatsHelper.getTrainingDaysBreakdown(exerciseID);
    final trainingsLastWeek = trainingDays['lastWeek'].toString();
    final trainingsThisMonth = trainingDays['thisMonth'].toString();
    final trainingsThisYear = trainingDays['thisYear'].toString();

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorProvider.accent.withOpacity(0.05),
      ),
      width: double.maxFinite,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                const SizedBox(width: 24),
                Icon(Icons.query_stats, color: colorProvider.accent),
                const SizedBox(width: 8),
                Text(
                  t.exerciseStats_title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorProvider.accent,
                  ),
                ),
              ],
            ),
          ),
          collapsedIconColor: colorProvider.accent.withValues(alpha: 0.7),
          iconColor: colorProvider.accent,
          childrenPadding: const EdgeInsets.all(10.0),
          tilePadding: const EdgeInsets.symmetric(horizontal: 10),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(
                  icon: Icons.calendar_today,
                  title: t.exerciseStats_timeStats,
                  color: colorProvider.accent,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 3,
                  children: _buildTimePeriodStats(
                    context,
                    totalNotesCount,
                    trainingsLastWeek,
                    trainingsThisMonth,
                    trainingsThisYear,
                    colorProvider,
                    t,
                  ),
                ),
                const SizedBox(height: 16),
                _sectionHeader(
                  icon: Icons.bar_chart,
                  title: t.exerciseStats_noteStats,
                  color: colorProvider.accent,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 3,
                  children: _buildAverageAndTotalStats(
                    context,
                    totalNotesCount,
                    averageLine,
                    averageLength,
                    totalLines,
                    totalChars,
                    colorProvider,
                    t,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimePeriodStats(
      BuildContext context,
      int totalNotesCount,
      String trainingsLastWeek,
      String trainingsThisMonth,
      String trainingsThisYear,
      ColorProvider colorProvider,
      AppLocalizations t,
      ) {
    final widgets = <Widget>[];

    widgets.add(
      ExerciseStatsHelper.buildStatItem(
        context,
        t.exerciseStats_totalNotes,
        totalNotesCount > 0 ? totalNotesCount.toString() : '0',
        colorProvider,
      ),
    );

    widgets.add(
      ExerciseStatsHelper.buildStatItem(
        context,
        t.exerciseStats_lastWeek,
        trainingsLastWeek != '0' ? trainingsLastWeek : '0',
        colorProvider,
      ),
    );

    if (totalNotesCount > 1 && trainingsThisMonth != '0') {
      widgets.add(
        ExerciseStatsHelper.buildStatItem(
          context,
          t.exerciseStats_lastMonth,
          trainingsThisMonth,
          colorProvider,
        ),
      );
    }

    if (totalNotesCount > 1 && trainingsThisYear != '0') {
      widgets.add(
        ExerciseStatsHelper.buildStatItem(
          context,
          t.exerciseStats_lastYear,
          trainingsThisYear,
          colorProvider,
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildAverageAndTotalStats(
      BuildContext context,
      int totalNotesCount,
      String averageLine,
      String averageLength,
      String totalLines,
      String totalChars,
      ColorProvider colorProvider,
      AppLocalizations t,
      ) {
    final widgets = <Widget>[];

    if (totalNotesCount > 1) {
      widgets.addAll([
        ExerciseStatsHelper.buildStatItem(
          context,
          t.exerciseStats_avgLines,
          averageLine.isNotEmpty ? averageLine : t.exerciseStats_none,
          colorProvider,
        ),
        ExerciseStatsHelper.buildStatItem(
          context,
          t.exerciseStats_avgChars,
          averageLength.isNotEmpty ? averageLength : t.exerciseStats_none,
          colorProvider,
        ),
      ]);
    }

    widgets.addAll([
      ExerciseStatsHelper.buildStatItem(
        context,
        t.exerciseStats_totalLines,
        totalLines != '0' ? totalLines : t.exerciseStats_none,
        colorProvider,
      ),
      ExerciseStatsHelper.buildStatItem(
        context,
        t.exerciseStats_totalChars,
        totalChars != '0' ? totalChars : t.exerciseStats_none,
        colorProvider,
      ),
    ]);

    return widgets;
  }
}
