import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/custom_appbar.dart';
import '../../../../../util/input_form_field/input_form_field.dart';
import 'plate_dialog.dart';

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({super.key});

  @override
  _PlateCalculatorState createState() => _PlateCalculatorState();
}

class _PlateCalculatorState extends State<PlateCalculator> {
  final TextEditingController _totalWeightController = TextEditingController();
  final TextEditingController _barbellWeightController =
      TextEditingController();

  double _weightOnSide = 0;
  bool _showResult = false;
  bool _isPounds = false;

  final List<double> allPlateSizesKg = [25, 20, 15, 10, 5, 2.5, 1.25, 1, 0.5];
  final List<double> allPlateSizesLbs = [55, 45, 35, 25, 10, 5, 2.5, 1.25, 1];
  late List<double> selectedPlates;
  late List<double> allPlateSizes;

  @override
  void initState() {
    super.initState();
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    _isPounds = settingsProvider.getUnits == 'imperial';
    _setPlateList();
    _barbellWeightController.text = _isPounds ? '45' : '20';
  }

  void _setPlateList() {
    allPlateSizes = _isPounds ? allPlateSizesLbs : allPlateSizesKg;
    selectedPlates = List.from(allPlateSizes)
      ..removeWhere((plate) =>
          plate == (_isPounds ? 55 : 25) ||
          plate == 1 ||
          (!_isPounds && plate == 0.5));
  }

  void _calculateWeight() {
    double barbellWeight = double.tryParse(_barbellWeightController.text) ?? 0;
    double totalWeight = double.tryParse(_totalWeightController.text) ?? 0;

    if (barbellWeight > 0 && totalWeight > barbellWeight) {
      setState(() {
        _weightOnSide = (totalWeight - barbellWeight) / 2;
        _showResult = true;
      });
    } else {
      setState(() {
        _showResult = false;
      });
    }
  }

  void _openPlateDialog() {
    double barbellWeight = double.tryParse(_barbellWeightController.text) ?? 0;
    double totalWeight = double.tryParse(_totalWeightController.text) ?? 0;

    if (totalWeight > 0 && barbellWeight > 0) {
      PlateDialog.calculateRequiredPlates(
          context, totalWeight, barbellWeight, selectedPlates);
    }
  }

  void _togglePlateSelection(double plate) {
    setState(() {
      if (selectedPlates.contains(plate)) {
        selectedPlates.remove(plate);
      } else {
        selectedPlates.add(plate);
      }
    });
  }

  String formatWeight(double weight) {
    if (weight % 1 == 0) {
      return weight.toInt().toString();
    } else if ((weight * 10) % 1 == 0) {
      return weight.toStringAsFixed(1);
    } else {
      return weight.toStringAsFixed(2);
    }
  }

  double convertKgToLbs(double kg) => kg * 2.20462;
  double convertLbsToKg(double lbs) => lbs / 2.20462;

  void _toggleUnits() {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    setState(() {
      _isPounds = !_isPounds;
      double total = double.tryParse(_totalWeightController.text) ?? 0;

      _barbellWeightController.text = _isPounds ? '45' : '20';

      if (total > 0) {
        total = _isPounds ? convertKgToLbs(total) : convertLbsToKg(total);
        _totalWeightController.text = formatWeight(total);
      }

      settingsProvider.changeUnits(_isPounds ? 'imperial' : 'metric');
      _setPlateList();
      _calculateWeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.plateCalculator_plateCalculator,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showResult)
              GestureDetector(
                onTap: _openPlateDialog,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                  decoration: BoxDecoration(
                    color: colorProvider.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isPounds
                            ? t.plateCalculator_weightOnSideLbs(
                                formatWeight(_weightOnSide))
                            : t.plateCalculator_weightOnSideKg(
                                formatWeight(_weightOnSide)),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: colorProvider.accent),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t.plateCalculator_clickToSeePlates,
                        style: TextStyle(
                            fontSize: 14, color: colorProvider.accent),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            if (!_showResult)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  t.plateCalculator_fillOutData,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: colorProvider.accent),
                ),
              ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: colorProvider.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputFormField(
                          labelText: _isPounds
                              ? t.plateCalculator_barbellWeightLabelLbs
                              : t.plateCalculator_barbellWeightLabelKg,
                          controller: _barbellWeightController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (_) => _calculateWeight(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InputFormField(
                          labelText: _isPounds
                          ? t.plateCalculator_totalWeightLabelLbs
                          : t.plateCalculator_totalWeightLabelKg,
                          controller: _totalWeightController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (_) => _calculateWeight(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: colorProvider.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.plateCalculator_selectPlates,
                    style: TextStyle(fontSize: 16, color: colorProvider.accent),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemCount: allPlateSizes.length,
                    itemBuilder: (context, index) {
                      final plate = allPlateSizes[index];
                      bool isSelected = selectedPlates.contains(plate);
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorProvider.accent
                              : colorProvider.secondary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? colorProvider.secondary
                                : colorProvider.accent,
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _togglePlateSelection(plate),
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Text(
                              "${formatWeight(plate)} ${_isPounds ? 'lbs' : 'kg'}",
                              style: TextStyle(
                                color: isSelected
                                    ? colorProvider.secondary
                                    : colorProvider.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: _toggleUnits,
        backgroundColor: colorProvider.accent,
        icon: Icon(Icons.swap_horiz, color: colorProvider.secondary),
        label: Text(
          _isPounds ? ' lbs ' : ' kg ',
          style: TextStyle(
              color: colorProvider.secondary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
