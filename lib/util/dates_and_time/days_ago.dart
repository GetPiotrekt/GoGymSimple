import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class DaysAgo {
  static String formatNoteDate(BuildContext context, DateTime? date) {
    final t = AppLocalizations.of(context)!;

    if (date == null) return t.daysAgo_noData;

    final now = DateTime.now();

    // Sprawdzenie czy data jest "dzisiaj"
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return t.measurementTile_today;  // nowy klucz lokalizacyjny np. "Dzisiaj"
    }

    final differenceInMinutes = now.difference(date).inMinutes;
    final differenceInHours = now.difference(date).inHours;
    final differenceInDays = now.difference(date).inDays;
    final differenceInWeeks = (differenceInDays / 7).floor();

    if (differenceInMinutes < 60) {
      return t.daysAgo_lessThanOneHour;
    } else if (differenceInHours < 24) {
      return t.daysAgo_hoursAgo(differenceInHours);
    } else if (differenceInDays < 7) {
      return t.daysAgo_daysAgo(differenceInDays);
    } else if (differenceInDays < 180) {
      return t.daysAgo_weeksAgo(differenceInWeeks);
    } else {
      return t.daysAgo_longTimeAgo;
    }
  }
}

