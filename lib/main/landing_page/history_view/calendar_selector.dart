import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../provider/color_provider.dart';

class CalendarSelector extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<String, Map<String, List<Map<String, dynamic>>>> groupedByDateAndUserGym;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;

  const CalendarSelector({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.groupedByDateAndUserGym,
    required this.onDaySelected,
  });

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final dateKey = day.toIso8601String().split('T').first;
    if (groupedByDateAndUserGym.containsKey(dateKey)) {
      final usersData = groupedByDateAndUserGym[dateKey]!;
      final allEvents = usersData.values.expand((events) => events).toList();
      return allEvents;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          height: 400,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: colorProvider.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TableCalendar(
            sixWeekMonthsEnforced: true,
            shouldFillViewport: true,
            firstDay: DateTime(2000),
            lastDay: DateTime.now().add(const Duration(days: 365 * 5)),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: onDaySelected,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month'
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: colorProvider.primary,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: colorProvider.accent,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.2)),
              defaultTextStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.9)),
              weekendTextStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.9)),
              disabledTextStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.2)),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: colorProvider.accent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: colorProvider.accent),
              rightChevronIcon: Icon(Icons.chevron_right, color: colorProvider.accent),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.7)),
              weekendStyle: TextStyle(
                  color: colorProvider.accent.withOpacity(0.7)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: colorProvider.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: colorProvider.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Zapisane wydarzenie', // Możesz podmienić na lokalizację
                style: TextStyle(
                  color: colorProvider.accent.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
