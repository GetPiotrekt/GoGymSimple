import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/input_form_field/input_form_field.dart';
import 'bmr_results.dart';
import 'info_dialog_bmr.dart';

class CalculatorBMR extends StatefulWidget {
  const CalculatorBMR({super.key});

  @override
  _CalculatorBMRState createState() => _CalculatorBMRState();
}

class _CalculatorBMRState extends State<CalculatorBMR> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  late String _gender = 'male';
  double _bmr = 0;
  final Map<String, double> bmrByActivity = {};
  bool _isPounds = false;

  @override
  void initState() {
    super.initState();

    final units =
        Provider.of<SettingsProvider>(context, listen: false).getUnits;
    _isPounds = units == 'imperial';
  }

  void _toggleUnits() {
    setState(() {
      _isPounds = !_isPounds;
      Provider.of<SettingsProvider>(context, listen: false)
          .changeUnits(_isPounds ? 'imperial' : 'metric');

      double? weight = double.tryParse(_weightController.text);
      if (weight != null) {
        _weightController.text = _isPounds
            ? (weight * 2.20462).toStringAsFixed(1)
            : (weight / 2.20462).toStringAsFixed(1);
      }

      double? heightFeet = double.tryParse(_heightFeetController.text);
      double? heightInches = double.tryParse(_heightInchesController.text);

      if (heightFeet != null && heightInches != null) {
        if (_isPounds) {
          _heightFeetController.text = (heightFeet * 0.3048).toStringAsFixed(1);
          _heightInchesController.text =
              (heightInches * 2.54).toStringAsFixed(1);
        } else {
          _heightFeetController.text = (heightFeet / 0.3048).toStringAsFixed(1);
          _heightInchesController.text =
              (heightInches / 2.54).toStringAsFixed(1);
        }
      }
    });
  }

  void _calculateBMR() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    int age = int.tryParse(_ageController.text) ?? 0;

    double heightInCm;
    if (_isPounds) {
      double heightInFeet = double.tryParse(_heightFeetController.text) ?? 0;
      double heightInInches =
          double.tryParse(_heightInchesController.text) ?? 0;
      heightInCm = (heightInFeet * 30.48) + (heightInInches * 2.54);
    } else {
      heightInCm = double.tryParse(_heightController.text) ?? 0;
    }

    bmrByActivity.clear();
    for (final activityLevel in [
      'Podstawowe zapotrzebowanie',
      'Niska aktywność',
      'Średnia aktywność',
      'Wysoka aktywność',
      'Bardzo wysoka aktywność',
    ]) {
      final activityFactor = _getActivityFactor(activityLevel);
      final baseBMR =
          _calculateBmrFormula(weight, heightInCm, age, activityFactor);
      final bmr = baseBMR * activityFactor;
      bmrByActivity[activityLevel] = bmr;
    }
    setState(() {
      _bmr = bmrByActivity.values.first;
    });
  }

  double _getActivityFactor(String activityLevel) {
    switch (activityLevel) {
      case 'Podstawowe zapotrzebowanie':
        return 1;
      case 'Niska aktywność':
        return 1.2;
      case 'Średnia aktywność':
        return 1.375;
      case 'Wysoka aktywność':
        return 1.55;
      case 'Bardzo wysoka aktywność':
        return 1.725;
      default:
        return 1;
    }
  }

  double _calculateBmrFormula(
      double weight, double height, int age, double activityFactor) {
    if (_gender == 'male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  Color _radioTextColor(String value) {
    final color = Provider.of<ColorProvider>(context);
    return _gender == value ? color.accent : color.accent.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    bool isFormComplete = _weightController.text.isNotEmpty &&
        (_isPounds
            ? (_heightFeetController.text.isNotEmpty &&
                _heightInchesController.text.isNotEmpty)
            : _heightController.text.isNotEmpty) &&
        _ageController.text.isNotEmpty &&
        _gender != null;

    if (isFormComplete) {
      _calculateBMR();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: t.calculatorBmr_title,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: colorProvider.accent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const InfoDialogBMR(),
              );
            },
          ),
        ],
      ),
      backgroundColor: colorProvider.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_bmr > 0)
              BMRResults(
                bmrByActivity: bmrByActivity,
                weight: double.tryParse(_weightController.text) ?? 0,
              ),
            if (_bmr <= 0)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  t.calculatorBmr_info,
                  style: TextStyle(fontSize: 16, color: colorProvider.accent),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorProvider.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputFormField(
                          labelText: _isPounds
                              ? t.calculatorBmr_weight_label_imperial
                              : t.calculatorBmr_weight_label_metric,
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InputFormField(
                          labelText: t.calculatorBmr_age_label,
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _isPounds
                            ? Row(
                                children: [
                                  Expanded(
                                    child: InputFormField(
                                      labelText: t
                                          .calculatorBmr_height_label_imperial_feet,
                                      controller: _heightFeetController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: InputFormField(
                                      labelText: t
                                          .calculatorBmr_height_label_imperial_inches,
                                      controller: _heightInchesController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                ],
                              )
                            : InputFormField(
                                labelText: t.calculatorBmr_height_label_metric,
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                onChanged: (_) => setState(() {}),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // To keep the row compact
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle the gender
                                _gender =
                                    (_gender == 'male') ? 'female' : 'male';
                              });
                            },
                            // You can wrap this in a Card or Container for better visual feedback/styling
                            child: Container(
                              width: 100,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              // Padding for the button
                              decoration: BoxDecoration(
                                color: colorProvider.accent.withOpacity(0.05),
                                // Background color for the button
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    // Display icon based on current gender
                                    _gender == 'male'
                                        ? Icons.male
                                        : Icons.female,
                                    color: colorProvider.accent, // Icon color
                                    size: 22,
                                  ),
                                  const SizedBox(width: 6),
                                  // Increased space for better visual separation
                                  Text(
                                    // Display text based on current gender
                                    _gender == 'male'
                                        ? t.calculatorBmr_male
                                        : t.calculatorBmr_female,
                                    style: TextStyle(
                                      color: colorProvider.accent,
                                      // Text color
                                      fontWeight: FontWeight.bold,
                                      // Make text bold for better visibility
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            // wysokość nad floating btn
            const SizedBox(height: 66)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: _toggleUnits,
        backgroundColor: colorProvider.accent,
        icon: Icon(Icons.swap_horiz, color: colorProvider.secondary),
        label: Text(
          _isPounds ? ' lbs/in ' : ' kg/cm ',
          style: TextStyle(
            color: colorProvider.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
