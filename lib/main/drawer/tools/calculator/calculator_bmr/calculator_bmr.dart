import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/input_form_field/input_form_field.dart';
import 'bmr_input_form.dart';
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

    final units = Provider.of<SettingsProvider>(context, listen: false).getUnits;
    _isPounds = units == 'imperial';

    // Przy inicjalizacji spróbuj rozdzielić wysokość metrów na ft/in jeśli w imperial
    if (_isPounds) {
      // Jeśli jest metryczne w heightController, to rozdziel je na ft i in
      final heightCm = double.tryParse(_heightController.text);
      if (heightCm != null) {
        final feet = heightCm / 30.48;
        final feetInt = feet.floor();
        final inches = (feet - feetInt) * 12;
        _heightFeetController.text = feetInt.toString();
        _heightInchesController.text = inches.toStringAsFixed(1);
        _heightController.clear();
      }
    }
  }

  void _toggleUnits() {
    setState(() {
      _isPounds = !_isPounds;
      Provider.of<SettingsProvider>(context, listen: false)
          .changeUnits(_isPounds ? 'imperial' : 'metric');

      // Przelicz wagę
      double? weight = double.tryParse(_weightController.text);
      if (weight != null) {
        if (_isPounds) {
          // kg -> lbs
          _weightController.text = (weight * 2.20462).toStringAsFixed(1);
        } else {
          // lbs -> kg
          _weightController.text = (weight / 2.20462).toStringAsFixed(1);
        }
      }

      // Przelicz wzrost
      if (_isPounds) {
        // z cm na ft/in
        double? heightCm = double.tryParse(_heightController.text);
        if (heightCm != null) {
          final feet = heightCm / 30.48;
          final feetInt = feet.floor();
          final inches = (feet - feetInt) * 12;
          _heightFeetController.text = feetInt.toString();
          _heightInchesController.text = inches.toStringAsFixed(1);
          _heightController.clear();
        }
      } else {
        // z ft/in na cm
        double? feet = double.tryParse(_heightFeetController.text);
        double? inches = double.tryParse(_heightInchesController.text);
        if (feet != null && inches != null) {
          final heightCm = (feet * 30.48) + (inches * 2.54);
          _heightController.text = heightCm.toStringAsFixed(1);
          _heightFeetController.clear();
          _heightInchesController.clear();
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
      double heightInInches = double.tryParse(_heightInchesController.text) ?? 0;
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
      final baseBMR = _calculateBmrFormula(weight, heightInCm, age, activityFactor);
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
                isMetric: !_isPounds,
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
            BmrInputForm(
              isPounds: _isPounds,
              weightController: _weightController,
              heightController: _heightController,
              heightFeetController: _heightFeetController,
              heightInchesController: _heightInchesController,
              ageController: _ageController,
              gender: _gender,
              onGenderToggle: () {
                setState(() {
                  _gender = (_gender == 'male') ? 'female' : 'male';
                });
              },
              onChanged: () {
                setState(() {}); // powoduje przeliczenie i odświeżenie
              },
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
