import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/data_tab_sector/user_data/user_measurement_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../../util/dialog/text_input_dialog.dart';
import '../../../../../util/snackbar_helper.dart';
import 'measurement_tile.dart';

class MeasurementTracker extends StatefulWidget {
  const MeasurementTracker({super.key});

  @override
  _MeasurementTrackerState createState() => _MeasurementTrackerState();
}

class _MeasurementTrackerState extends State<MeasurementTracker> {
  Map<String, List<UserMeasurement>> _measurementsHistory = {};
  final int userID = 1;
  Map<String, bool> _expandedState = {};
  bool _isInch = false;

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
    final units =
        Provider.of<SettingsProvider>(context, listen: false).getUnits;
    _isInch = units == 'imperial';
  }

  Future<void> _onDeleteCategory(String category) async {
    bool? confirmDelete = await DeleteConfirmationDialog.show(context);

    if (confirmDelete!) {
      // Call the method that deletes the category
      await UserMeasurementBox.deleteMeasurementsByUserAndBodyPart(
          userID, category);

      setState(() {
        _measurementsHistory.remove(category);
        _expandedState.remove(category);
      });

      SnackbarHelper.showSnackbar(
          context,
          AppLocalizations.of(context)!
              .measurementTracker_category_deleted(category));
    }
  }

  Future<void> _onDeleteMeasurement(UserMeasurement measurement) async {
    bool? confirmDelete = await DeleteConfirmationDialog.show(context);

    if (confirmDelete == true) {
      // Remove from the local map
      setState(() {
        _measurementsHistory[measurement.bodyPart]?.remove(measurement);
        if (_measurementsHistory[measurement.bodyPart]?.isEmpty ?? false) {
          _measurementsHistory.remove(measurement.bodyPart);
        }
      });

      // Remove from the database
      bool success = await UserMeasurementBox.deleteMeasurementsByID(
          measurement.userMeasurementID);

      if (success) {
        // Show success Snackbar
        SnackbarHelper.showSnackbar(
          context,
          AppLocalizations.of(context)!
              .measurementTracker_measurement_deleted(measurement.bodyPart),
        );
      } else {
        // If database deletion fails
        SnackbarHelper.showSnackbar(
          context,
          AppLocalizations.of(context)!
              .measurementTracker_measurement_deleted("Failed"),
        );
      }
    }
  }

  Future<void> _onUpdateBodyPart(String oldCategory) async {
    final updatedCategory = await TextInputDialog.showTextInputDialog(
      context: context,
      title: AppLocalizations.of(context)!.measurementTracker_update_category,
      labelText:
          AppLocalizations.of(context)!.measurementTracker_add_new_category,
      inputType: TextInputType.text,
    );

    if (updatedCategory != null &&
        updatedCategory.isNotEmpty &&
        updatedCategory != oldCategory) {
      if (_measurementsHistory.containsKey(updatedCategory)) {
        SnackbarHelper.showSnackbar(context,
            AppLocalizations.of(context)!.measurementTracker_category_exists);
      } else {
        setState(() {
          // Update the category name in the map
          final measurements = _measurementsHistory[oldCategory];
          if (measurements != null) {
            _measurementsHistory.remove(oldCategory);
            _measurementsHistory[updatedCategory] = measurements;
          }

          // Update the expanded state map
          bool isExpanded = _expandedState[oldCategory] ?? false;
          _expandedState.remove(oldCategory);
          _expandedState[updatedCategory] = isExpanded;
        });

        // Update the category name in the database
        await UserMeasurementBox.updateCategoryName(
            userID, oldCategory, updatedCategory);
      }
    }
  }

  Future<void> _loadMeasurements() async {
    List<UserMeasurement> history =
        UserMeasurementBox.getMeasurementHistory(userID);

    setState(() {
      _measurementsHistory = {};
      _expandedState = {};
      for (var measurement in history) {
        _measurementsHistory
            .putIfAbsent(measurement.bodyPart, () => [])
            .add(measurement);
      }
    });
  }

  Future<void> _addMeasurementCategory(ColorProvider colorProvider) async {
    final newCategory = await TextInputDialog.showTextInputDialog(
      context: context,
      title: AppLocalizations.of(context)!.measurementTracker_add_new_category,
      labelText:
          AppLocalizations.of(context)!.measurementTracker_name_new_category,
      inputType: TextInputType.text,
    );

    if (newCategory != null && newCategory.isNotEmpty) {
      if (_measurementsHistory.containsKey(newCategory)) {
        SnackbarHelper.showSnackbar(context,
            AppLocalizations.of(context)!.measurementTracker_category_exists);
      } else {
        // Pobieranie nowego ID
        int newMeasurementID =
            await UserMeasurementBox.getMaxMeasurementIndex() + 1;

        final newMeasurement = UserMeasurement(
          userMeasurementID: newMeasurementID, // Dodanie unikalnego ID
          userID: userID,
          bodyPart: newCategory,
          value: -1,
          date: DateTime.now().toIso8601String(),
        );

        setState(() {
          _measurementsHistory[newCategory] = [newMeasurement];
          _expandedState[newCategory] = false;
        });

        await UserMeasurementBox.addMeasurement(
          userID,
          newCategory,
          -1,
          DateTime.now(),
        );
      }
    }
  }

  Future<void> _addMeasurementValue(
      String bodyPart, ColorProvider colorProvider) async {
    // Ensure the bodyPart is valid before adding the measurement
    if (bodyPart.isEmpty || !_measurementsHistory.containsKey(bodyPart)) {
      SnackbarHelper.showSnackbar(context,
          AppLocalizations.of(context)!.measurementTracker_invalid_category);
      return;
    }

    final newValue = await TextInputDialog.showTextInputDialog(
      context: context,
      title:
          AppLocalizations.of(context)!.measurementTracker_add_new_measurement,
      labelText:
          AppLocalizations.of(context)!.measurementTracker_name_new_measurement,
      inputType: TextInputType.number,
    );

    int newMeasurementID =
        await UserMeasurementBox.getMaxMeasurementIndex() + 1;

    if (newValue != null && newValue.isNotEmpty) {
      double? parsedValue = double.tryParse(newValue);
      if (parsedValue != null && parsedValue > 0) {
        // Jeśli jednostką są cale, przelicz na cm
        if (_isInch) {
          parsedValue *= 2.54;
        }

        final newMeasurement = UserMeasurement(
          userMeasurementID: newMeasurementID,
          userID: userID,
          bodyPart: bodyPart,
          value: parsedValue,
          date: DateTime.now().toIso8601String(),
        );

        setState(() {
          _measurementsHistory.putIfAbsent(bodyPart, () => []);
          _measurementsHistory[bodyPart]?.add(newMeasurement);
        });

        await UserMeasurementBox.addMeasurement(
            userID, bodyPart, parsedValue, DateTime.now());
      } else {
        SnackbarHelper.showSnackbar(context,
            AppLocalizations.of(context)!.measurementTracker_invalid_value);
      }
    }
  }

  Widget _buildMeasurementList(ColorProvider colorProvider) {
    return _measurementsHistory.isEmpty
        ? Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: colorProvider.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 48,
                    color: colorProvider.accent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!
                        .measurementTracker_no_data_to_show,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!
                        .measurementTracker_add_category_hint, // Dodaj nowy klucz do lokalizacji np. "Możesz dodać nową kategorię za pomocą przycisku poniżej"
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorProvider.accent.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: _measurementsHistory.length,
            itemBuilder: (context, index) {
              String bodyPart = _measurementsHistory.keys.elementAt(index);
              List<UserMeasurement> history = _measurementsHistory[bodyPart]!;

              return MeasurementTile(
                isInch: _isInch,
                bodyPart: bodyPart,
                history: history,
                expandedState: _expandedState,
                onAddMeasurement: (bodyPart) =>
                    _addMeasurementValue(bodyPart, colorProvider),
                colorProvider: colorProvider,
                userID: 1,
                onUpdateBodyPart: (oldCategory) =>
                    _onUpdateBodyPart(oldCategory),
                onDeleteCategoryCallback: (category) =>
                    _onDeleteCategory(category),
                onDeleteMeasurementCallback: (measurement) =>
                    _onDeleteMeasurement(measurement),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(
      builder: (context, colorProvider, child) {
        return Scaffold(
          backgroundColor: colorProvider.primary,
          appBar: CustomAppBar(
            title: AppLocalizations.of(context)!
                .measurementTracker_body_measurements, // Localized text for appBar
          ),
          body: Column(
            children: [
              Expanded(child: _buildMeasurementList(colorProvider)),
              Column(
                children: [
                  Container(
                    height: 1,
                    color: colorProvider.primary,
                  ),
                  GestureDetector(
                    onTap: () => _addMeasurementCategory(colorProvider),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorProvider.secondary,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: colorProvider.accent),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!
                                .measurementTracker_add_new_category, // Replace with localized text
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorProvider.accent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
                bottom: 50.0), // Zwiększ, jeśli chcesz go jeszcze wyżej
            child: FloatingActionButton.extended(
              elevation: 0,
              onPressed: () {
                _isInch = !_isInch;
                final settingsProvider =
                    Provider.of<SettingsProvider>(context, listen: false);
                settingsProvider.changeUnits(_isInch ? 'imperial' : 'metric');
                setState(() {});
              },
              backgroundColor: colorProvider.accent,
              icon: Icon(
                Icons.swap_horiz,
                color: colorProvider.secondary,
              ),
              label: Text(
                _isInch ? ' in ' : ' cm ',
                style: TextStyle(
                    color: colorProvider.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
