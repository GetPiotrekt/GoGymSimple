import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/data_tab_sector/user_data/user_measurement_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/snackbar_helper.dart';
import 'measurement_service.dart';
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

  Future<void> _addMeasurementValue(
      String bodyPart, ColorProvider colorProvider) async {
    if (bodyPart.isEmpty || !_measurementsHistory.containsKey(bodyPart)) {
      SnackbarHelper.showSnackbar(
        context,
        AppLocalizations.of(context)!.measurementTracker_invalid_category,
      );
      return;
    }

    await MeasurementService.addMeasurementValue(
      context: context,
      bodyPart: bodyPart,
      userID: userID,
      isInch: _isInch,
      colorProvider: colorProvider,
      measurementsHistory: _measurementsHistory,
      updateState: (updatedMeasurements) {
        setState(() {
          _measurementsHistory = Map.from(updatedMeasurements);
          _expandedState[bodyPart] = true; // <-- teraz zadziała
        });
      },
    );
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
                        .measurementTracker_add_category_hint,
                    // Dodaj nowy klucz do lokalizacji np. "Możesz dodać nową kategorię za pomocą przycisku poniżej"
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
            itemCount: _measurementsHistory.length + 1,
            itemBuilder: (context, index) {
              if (index == _measurementsHistory.length) {
                return const SizedBox(height: 22);
              }

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
                    MeasurementService.onUpdateBodyPart(
                  context: context,
                  userID: userID,
                  oldCategory: oldCategory,
                  measurementsHistory: _measurementsHistory,
                  expandedState: _expandedState,
                  updateState: (updatedMeasurements, updatedExpanded) {
                    setState(() {
                      _measurementsHistory = Map.from(updatedMeasurements);
                      _expandedState = Map.from(updatedExpanded);
                    });
                  },
                ),
                onDeleteCategoryCallback: (category) =>
                    MeasurementService.onDeleteCategory(
                  context: context,
                  measurementsHistory: _measurementsHistory,
                  expandedState: _expandedState,
                  userID: userID,
                  category: category,
                  updateState: (updatedMeasurements, updatedExpanded) {
                    setState(() {
                      _measurementsHistory = Map.from(updatedMeasurements);
                      _expandedState = Map.from(updatedExpanded);
                    });
                  },
                ),
                onDeleteMeasurementCallback: (measurement) =>
                    MeasurementService.onDeleteMeasurement(
                  context: context,
                  measurement: measurement,
                  measurementsHistory: _measurementsHistory,
                  updateState: (updatedMeasurements) {
                    setState(() {
                      _measurementsHistory = Map.from(updatedMeasurements);
                    });
                  },
                ),
              );
            });
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
                    onTap: () => MeasurementService.addMeasurementCategory(
                      context: context,
                      userID: userID,
                      measurementsHistory: _measurementsHistory,
                      expandedState: _expandedState,
                      updateState: (updatedMeasurements, updatedExpanded) {
                        setState(() {
                          _measurementsHistory = Map.from(updatedMeasurements);
                          _expandedState = Map.from(updatedExpanded);
                        });
                      },
                    ),
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
                                .measurementTracker_add_new_category,
                            // Replace with localized text
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
          floatingActionButton: FloatingActionButton.extended(
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
                  color: colorProvider.secondary, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
