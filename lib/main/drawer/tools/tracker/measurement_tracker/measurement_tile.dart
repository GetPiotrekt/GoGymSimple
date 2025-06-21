import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../data/data_tab_sector/user_data/user_measurement_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';

class MeasurementTile extends StatelessWidget {
  final bool isInch;
  final String bodyPart;
  final List<UserMeasurement> history;
  final Map<String, bool> expandedState;
  final ValueChanged<String> onAddMeasurement;
  final ValueChanged<String> onUpdateBodyPart;
  final ValueChanged<String> onDeleteCategoryCallback;
  final Function(UserMeasurement) onDeleteMeasurementCallback;
  final ColorProvider colorProvider;
  final int userID;

  const MeasurementTile({
    super.key,
    required this.isInch,
    required this.bodyPart,
    required this.history,
    required this.expandedState,
    required this.onAddMeasurement,
    required this.onUpdateBodyPart,
    required this.onDeleteCategoryCallback,
    required this.colorProvider,
    required this.userID,
    required this.onDeleteMeasurementCallback,
  });

  @override
  Widget build(BuildContext context) {
    UserMeasurement? baselineMeasurement;

    if (history.isNotEmpty) {
      baselineMeasurement = history.firstWhere((m) => m.value != -1, orElse: () => history.first);
      history.lastWhere((m) => m.value != -1, orElse: () => baselineMeasurement!);
    }

    final t = AppLocalizations.of(context)!; // Localized text

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GestureDetector(
          onLongPress: () => onDeleteCategoryCallback(bodyPart),
          child: ExpansionTile(
            key: Key('$bodyPart-${expandedState[bodyPart]}'),
            initiallyExpanded: expandedState[bodyPart] ?? false,
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: colorProvider.accent,
            iconColor: colorProvider.accent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onUpdateBodyPart(bodyPart),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                            color: colorProvider.accent.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            bodyPart,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorProvider.accent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => onAddMeasurement(bodyPart),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorProvider.accent.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          t.measurementTile_addData,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorProvider.accent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              if (history.where((m) => m.value != -1).isNotEmpty)
                ...history.where((m) => m.value != -1).toList().reversed.toList().asMap().entries.map((entry) {
                  final index = entry.key;
                  final measurement = entry.value;
                  final reversedList = history.where((m) => m.value != -1).toList().reversed.toList();
                  final isFirst = index == reversedList.length - 1;
                  final isLast = index == 0;
                  final isBaseline = measurement == baselineMeasurement;

                  double displayValue = isInch ? measurement.value * 0.393701 : measurement.value;
                  double difference = (measurement.value - baselineMeasurement!.value).abs();
                  double displayDifference = isInch ? difference * 0.393701 : difference;

                  return GestureDetector(
                    onLongPress: () {
                      onDeleteMeasurementCallback(measurement);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 6, 0, isFirst ? 12 : 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isLast ? colorProvider.accent.withOpacity(0.2) : colorProvider.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        title: Text(
                          "${displayValue % 1 == 0 ? displayValue.toInt() : displayValue.toStringAsFixed(1)} ${isInch ? "in" : "cm"}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorProvider.accent,
                          ),
                        ),
                        subtitle: Text(
                          _getFormattedDate(measurement.date, t),
                          style: TextStyle(
                            fontSize: 14,
                            color: colorProvider.accent.withOpacity(0.65),
                          ),
                        ),
                        trailing: isBaseline
                            ? Text(
                          t.measurementTile_baseline,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorProvider.accent,
                          ),
                        )
                            : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              measurement.value > baselineMeasurement.value
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: measurement.value > baselineMeasurement.value
                                  ? colorProvider.accent
                                  : colorProvider.accent.withOpacity(0.4),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${displayDifference % 1 == 0 ? displayDifference.toInt() : displayDifference.toStringAsFixed(1)} ${isInch ? "in" : "cm"}",
                              style: TextStyle(
                                fontSize: 14,
                                color: measurement.value > baselineMeasurement.value
                                    ? colorProvider.accent
                                    : colorProvider.accent.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      t.measurementTile_noData,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: colorProvider.accent),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedDate(String dateStr, AppLocalizations t) {
    final measurementDate = DateTime.parse(dateStr);
    final now = DateTime.now();
    final differenceInDays = now.difference(measurementDate).inDays;

    if (differenceInDays == 0) {
      return t.measurementTile_today;
    } else if (differenceInDays == 1) {
      return t.measurementTile_yesterday;
    } else {
      final DateFormat dateFormat = DateFormat('d MMM yyyy');
      return dateFormat.format(measurementDate);
    }
  }
}
