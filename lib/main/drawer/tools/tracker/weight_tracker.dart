import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/user_data/user_weight_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../util/dates_and_time/days_ago.dart';
import '../../../../util/input_form_field/input_form_field.dart';
import '../../../../util/button_icon.dart';
import 'package:table_calendar/table_calendar.dart';

class WeightTracker extends StatefulWidget {
  const WeightTracker({super.key});

  @override
  _WeightTrackerState createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  final TextEditingController _weightController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isWeightSaved = false;
  bool _isPounds = false;

  @override
  void initState() {
    super.initState();
    // Sprawdź domyślną jednostkę z ustawień
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _isPounds = settingsProvider.getUnits == 'imperial';

    _loadWeightHistory(); // Load history AFTER _isPounds is set
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  // Helper function to format weight string
  String _formatWeightString(double weight) {
    if (weight == weight.toInt()) {
      return weight.toInt().toString(); // Return as integer if it's a whole number
    }
    return weight.toStringAsFixed(1); // Otherwise, format to one decimal place
  }

  void _toggleUnits() {
    setState(() {
      _isPounds = !_isPounds;

      // Aktualizuj jednostkę w ustawieniach
      Provider.of<SettingsProvider>(context, listen: false)
          .changeUnits(_isPounds ? 'imperial' : 'metric');

      double? weight = double.tryParse(_weightController.text);
      if (weight != null) {
        _weightController.text = _isPounds
            ? _formatWeightString(weight * 2.20462) // Apply new formatter
            : _formatWeightString(weight / 2.20462); // Apply new formatter
      }
    });
  }

  Future<void> _loadWeightHistory() async {
    try {
      const userID = 1; // ID użytkownika
      final weightHistory = UserWeightBox.getWeightHistory(userID); // Załaduj historię wag z bazy danych

      // Sprawdź, czy dla wybranej daty istnieje wpis
      final entry = weightHistory.firstWhere(
            (entry) => isSameDay(DateTime.parse(entry.date), _selectedDate),
        orElse: () => UserWeight(
            userID: userID,
            date: _selectedDate.toIso8601String(),
            weight: 0.0), // Tworzymy pusty wpis
      );

      setState(() {
        if (entry.weight > 0) {
          // Convert to current display unit first before formatting
          double displayWeight = entry.weight;
          if (_isPounds) { // If currently in pounds, convert stored kg to lbs
            displayWeight = displayWeight * 2.20462;
          }
          _isWeightSaved = true;
          _weightController.text = _formatWeightString(displayWeight); // Apply new formatter
        } else {
          _isWeightSaved = false;
          _weightController.clear();
        }
      });
    } catch (e) {
      print("Error loading weight history: $e");
      setState(() {
        _isWeightSaved = false;
        _weightController.clear();
      });
    }
  }

  void _saveWeight() async {
    if (_weightController.text.isNotEmpty) {
      double weight = double.parse(_weightController.text);
      const userID = 1;

      // If currently displaying in pounds, convert back to kg for storage
      if (_isPounds) {
        weight = weight / 2.20462;
      }

      await UserWeightBox.addWeight(userID, weight, _selectedDate);

      setState(() {
        _isWeightSaved = true;
      });
    }
  }

  void _updateWeight() async {
    // This method is identical to _saveWeight, so it can reuse the logic
    _saveWeight();
  }

  void _updateWeightFromCalendar(DateTime selectedDay) async {
    const userID = 1; // ID użytkownika
    final entry = UserWeightBox.getWeightHistory(userID).firstWhere(
          (entry) => isSameDay(DateTime.parse(entry.date), selectedDay),
      orElse: () => UserWeight(
          userID: userID, date: selectedDay.toIso8601String(), weight: 0.0),
    );

    setState(() {
      _selectedDate = selectedDay;
      _focusedDay = selectedDay; // Also update focused day when selecting
      _isWeightSaved = entry.weight > 0;

      if (entry.weight > 0) {
        // Convert to current display unit before formatting
        double displayWeight = entry.weight;
        if (_isPounds) { // If currently in pounds, convert stored kg to lbs
          displayWeight = displayWeight * 2.20462;
        }
        _weightController.text = _formatWeightString(displayWeight); // Apply new formatter
      } else {
        _weightController.clear();
      }
    });
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    const userID = 1;
    final weightHistory = UserWeightBox.getWeightHistory(userID);
    final entry = weightHistory.firstWhere(
          (entry) => isSameDay(DateTime.parse(entry.date), day),
      orElse: () =>
          UserWeight(userID: userID, date: day.toIso8601String(), weight: 0.0),
    );
    return entry.weight > 0 ? [entry.toJson()] : [];
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // Localized text

    return Consumer<ColorProvider>(builder: (context, colorProvider, child) {
      return Scaffold(
        backgroundColor: colorProvider.primary,
        appBar: CustomAppBar(title: t.weightTracker_title),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: colorProvider.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TableCalendar(
                    locale: Localizations.localeOf(context).toString(),
                    sixWeekMonthsEnforced: true,
                    shouldFillViewport: true,
                    firstDay: DateTime.utc(2020, 01, 01),
                    lastDay: DateTime.now(),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDate, day),
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek
                        .monday, // Początek tygodnia od poniedziałku
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay; // Update focused day here too
                      });
                      _updateWeightFromCalendar(selectedDay);
                    },
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
                      // This is the marker that indicates a saved weight
                      markerDecoration: BoxDecoration(
                        color: colorProvider.accent, // Color of the marker
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
                      leftChevronIcon:
                      Icon(Icons.chevron_left, color: colorProvider.accent),
                      rightChevronIcon: Icon(Icons.chevron_right,
                          color: colorProvider.accent),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: colorProvider.accent.withOpacity(0.7)),
                      weekendStyle: TextStyle(
                          color: colorProvider.accent.withOpacity(0.7)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Spacing between calendar and legend
              // === LEGEND START ===
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
                        color: colorProvider.accent, // Use the same color as markerDecoration
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.weightTracker_legendWeightSaved, // Translate this text
                      style: TextStyle(
                        color: colorProvider.accent.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // === LEGEND END ===
              const SizedBox(height: 8), // Spacing between legend and input field
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "${t.weightTracker_yourWeight}${!isSameDay(_selectedDate, DateTime.now()) ? ' (${DaysAgo.formatNoteDate(context, _selectedDate)})' : ''}",
                      style:
                      TextStyle(fontSize: 18, color: colorProvider.accent),
                    ),
                    const SizedBox(height: 10),
                    InputFormField(
                      labelText: _isPounds
                          ? t.weightTracker_enterWeightLbs
                          : t.weightTracker_enterWeightKg,
                      controller: _weightController,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _isWeightSaved
                              ? ButtonIcon(
                            onPressed: _updateWeight,
                            iconData: Icons.update,
                            labelText: t.weightTracker_updateWeight,
                          )
                              : ButtonIcon(
                            onPressed: _saveWeight,
                            iconData: Icons.check,
                            labelText: t.weightTracker_saveWeight,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ButtonIcon(
                          onPressed: _toggleUnits,
                          iconData: Icons.swap_horiz,
                          labelText: _isPounds ? 'lbs' : 'kg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}