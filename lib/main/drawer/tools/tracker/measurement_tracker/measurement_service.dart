import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/data_tab_sector/user_data/user_measurement_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../util/dates_and_time/date_picker.dart';
import '../../../../../util/dates_and_time/days_ago.dart';
import '../../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../../util/dialog/text_input_dialog.dart';
import '../../../../../util/snackbar_helper.dart';

class MeasurementService {
  static Future<void> onDeleteCategory({
    required BuildContext context,
    required Map<String, List<UserMeasurement>> measurementsHistory,
    required Map<String, bool> expandedState,
    required Function(Map<String, List<UserMeasurement>>, Map<String, bool>)
        updateState,
    required int userID,
    required String category,
  }) async {
    bool? confirmDelete = await DeleteConfirmationDialog.show(context);

    if (confirmDelete == true) {
      await UserMeasurementBox.deleteMeasurementsByUserAndBodyPart(
          userID, category);
      measurementsHistory.remove(category);
      expandedState.remove(category);
      updateState(measurementsHistory, expandedState);

      SnackbarHelper.showSnackbar(
        context,
        AppLocalizations.of(context)!
            .measurementTracker_category_deleted(category),
      );
    }
  }

  static Future<void> onDeleteMeasurement({
    required BuildContext context,
    required UserMeasurement measurement,
    required Map<String, List<UserMeasurement>> measurementsHistory,
    required Function(Map<String, List<UserMeasurement>>) updateState,
  }) async {
    bool? confirmDelete = await DeleteConfirmationDialog.show(context);

    if (confirmDelete == true) {
      measurementsHistory[measurement.bodyPart]?.remove(measurement);
      if (measurementsHistory[measurement.bodyPart]?.isEmpty ?? false) {
        measurementsHistory.remove(measurement.bodyPart);
      }
      updateState(measurementsHistory);

      bool success = await UserMeasurementBox.deleteMeasurementsByID(
          measurement.userMeasurementID);
      final t = AppLocalizations.of(context)!;
      SnackbarHelper.showSnackbar(
        context,
        success
            ? t.measurementTracker_measurement_deleted(measurement.bodyPart)
            : t.measurementTracker_measurement_deleted("Failed"),
      );
    }
  }

  static Future<void> onUpdateBodyPart({
    required BuildContext context,
    required int userID,
    required String oldCategory,
    required Map<String, List<UserMeasurement>> measurementsHistory,
    required Map<String, bool> expandedState,
    required Function(Map<String, List<UserMeasurement>>, Map<String, bool>)
        updateState,
  }) async {
    final t = AppLocalizations.of(context)!;
    final updatedCategory = await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.measurementTracker_update_category,
      labelText: t.measurementTracker_add_new_category,
      inputType: TextInputType.text,
    );

    if (updatedCategory != null &&
        updatedCategory.isNotEmpty &&
        updatedCategory != oldCategory) {
      if (measurementsHistory.containsKey(updatedCategory)) {
        SnackbarHelper.showSnackbar(
            context, t.measurementTracker_category_exists);
      } else {
        final measurements = measurementsHistory[oldCategory];
        measurementsHistory.remove(oldCategory);
        measurementsHistory[updatedCategory] = measurements!;

        bool isExpanded = expandedState[oldCategory] ?? false;
        expandedState.remove(oldCategory);
        expandedState[updatedCategory] = isExpanded;

        updateState(measurementsHistory, expandedState);
        await UserMeasurementBox.updateCategoryName(
            userID, oldCategory, updatedCategory);
      }
    }
  }

  static Future<void> addMeasurementCategory({
    required BuildContext context,
    required int userID,
    required Map<String, List<UserMeasurement>> measurementsHistory,
    required Map<String, bool> expandedState,
    required Function(Map<String, List<UserMeasurement>>, Map<String, bool>)
        updateState,
  }) async {
    final t = AppLocalizations.of(context)!;
    final newCategory = await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.measurementTracker_add_new_category,
      labelText: t.measurementTracker_name_new_category,
      inputType: TextInputType.text,
    );

    if (newCategory != null && newCategory.isNotEmpty) {
      if (measurementsHistory.containsKey(newCategory)) {
        SnackbarHelper.showSnackbar(
            context, t.measurementTracker_category_exists);
      } else {
        int newMeasurementID =
            await UserMeasurementBox.getMaxMeasurementIndex() + 1;
        final now = DateTime.now();

        final newMeasurement = UserMeasurement(
          userMeasurementID: newMeasurementID,
          userID: userID,
          bodyPart: newCategory,
          value: -1,
          date: now.toIso8601String(),
        );

        measurementsHistory[newCategory] = [newMeasurement];
        expandedState[newCategory] = false;

        updateState(measurementsHistory, expandedState);
        await UserMeasurementBox.addMeasurement(userID, newCategory, -1, now);
      }
    }
  }

  static Future<void> addMeasurementValue({
    required BuildContext context,
    required String bodyPart,
    required int userID,
    required bool isInch,
    required ColorProvider colorProvider,
    required Map<String, List<UserMeasurement>> measurementsHistory,
    required Function(Map<String, List<UserMeasurement>>) updateState,
  }) async {
    final t = AppLocalizations.of(context)!;
    DateTime selectedDate = DateTime.now();

    final newValue = await TextInputDialog.showTextInputDialog(
      context: context,
      title: t.measurementTracker_add_new_measurement,
      labelText: t.measurementTracker_name_new_measurement,
      inputType: TextInputType.number,
      extraWidget: StatefulBuilder(
        builder: (BuildContext dialogContext, StateSetter setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.measurementTracker_measurementDate,
                style: TextStyle(
                  color: colorProvider.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showCustomDatePicker(
                    dialogContext,
                    selectedDate,
                  );

                  if (picked != null) {
                    setDialogState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DaysAgo.formatNoteDate(dialogContext, selectedDate),
                        style: TextStyle(
                          color: colorProvider.accent,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: colorProvider.accent),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    if (newValue != null && newValue.isNotEmpty) {
      double? parsedValue = double.tryParse(newValue);
      if (parsedValue != null && parsedValue > 0) {
        if (isInch) parsedValue *= 2.54;

        int newID = await UserMeasurementBox.getMaxMeasurementIndex() + 1;
        final newMeasurement = UserMeasurement(
          userMeasurementID: newID,
          userID: userID,
          bodyPart: bodyPart,
          value: parsedValue,
          date: selectedDate.toIso8601String(),
        );

        measurementsHistory.putIfAbsent(bodyPart, () => []);
        measurementsHistory[bodyPart]?.add(newMeasurement);

        updateState(measurementsHistory);
        await UserMeasurementBox.addMeasurement(
            userID, bodyPart, parsedValue, selectedDate);
      } else {
        SnackbarHelper.showSnackbar(
            context, t.measurementTracker_invalid_value);
      }
    }
  }
}
