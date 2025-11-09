import 'package:GoGymSimple/main/drawer/tools/calculator/1rm_calculator/weight_reps_input_field.dart';
import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';
import '../../../../../util/input_form_field/input_decorations.dart';
import '../../../../../util/input_form_field/input_form_field.dart';
import 'info_dialog_1rm.dart';

class Calculator1RM extends StatefulWidget {
  const Calculator1RM({super.key});

  @override
  _Calculator1RMState createState() => _Calculator1RMState();
}

class _Calculator1RMState extends State<Calculator1RM> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  double _oneRM = 0;
  bool _showResult = false;
  bool _isPounds = false;

  @override
  void initState() {
    super.initState();
    final units =
        Provider.of<SettingsProvider>(context, listen: false).getUnits;
    _isPounds = units == 'imperial';
  }

  void _calculate1RM() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double reps = double.tryParse(_repsController.text) ?? 0;

    if (_isPounds) {
      weight = weight / 2.20462; // Convert to kg for calculation
    }

    if (weight > 0 && reps > 0) {
      _oneRM = weight * (1 + (0.0333 * reps)); // Brzycki formula
      _showResult = true;
    } else {
      _showResult = false;
    }
    setState(
        () {}); // <-- można wywołać setState tutaj, ale lepiej rzadsze wywołania
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

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final settingsProvider = context.watch<SettingsProvider>();
    final bottomMargin = (settingsProvider.getElementVisibility ? 80 : 8);

    double displayed1RM = _isPounds ? convertKgToLbs(_oneRM) : _oneRM;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.calculator1RM_title,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: colorProvider.accent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const InfoDialog1RM(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showResult)
              Container(
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _isPounds
                          ? t.calculator1RM_ResultLbs(
                              double.parse(displayed1RM.toStringAsFixed(1)),
                            )
                          : t.calculator1RM_ResultKg(
                              double.parse(displayed1RM.toStringAsFixed(1)),
                            ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorProvider.accent),
                    ),
                    const SizedBox(height: 20),
                    Table(
                      border: TableBorder.all(
                        color: colorProvider.accent.withOpacity(0.4),
                      ),
                      children: [
                        TableRow(
                          children: [
                            _buildTableHeader(
                                t.calculator1RM_table_header_percentage,
                                colorProvider),
                            _buildTableHeader(t.calculator1RM_table_header_reps,
                                colorProvider),
                            _buildTableHeader(
                              _isPounds
                                  ? '${t.calculator1RM_table_header_weight} (lbs)'
                                  : '${t.calculator1RM_table_header_weight} (kg)',
                              colorProvider,
                            ),
                          ],
                        ),
                        ...List.generate(10, (index) {
                          int percentage = 95 - index * 5;
                          int reps =
                              [2, 4, 6, 8, 10, 12, 16, 20, 24, 30][index];
                          double weightKg = _oneRM * percentage / 100;
                          double weight =
                              _isPounds ? convertKgToLbs(weightKg) : weightKg;

                          return TableRow(
                            children: [
                              _buildTableCell('$percentage%', colorProvider),
                              _buildTableCell('$reps', colorProvider),
                              _buildTableCell(
                                  weight.toStringAsFixed(1), colorProvider),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            if (!_showResult)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    t.calculator1RM_infoText,
                    style: TextStyle(fontSize: 16, color: colorProvider.accent),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            WeightRepsInputField(
              weightController: _weightController,
              repsController: _repsController,
              isPounds: _isPounds,
              onChanged: _calculate1RM,
              colorProvider: colorProvider,
              weightLabel: _isPounds ? t.calculator1RM_weightLabelLbs : t.calculator1RM_weightLabelKg,
              repsLabel: t.calculator1RM_repsLabel,
            ),
            SizedBox(height: bottomMargin.toDouble())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () {
          final settingsProvider =
              Provider.of<SettingsProvider>(context, listen: false);

          setState(() {
            double weight = double.tryParse(_weightController.text) ?? 0;
            _isPounds = !_isPounds;
            if (weight > 0) {
              weight = _isPounds ? convertKgToLbs(weight) : weight / 2.20462;
              _weightController.text = formatWeight(weight);
            }

            settingsProvider.changeUnits(_isPounds ? 'imperial' : 'metric');
            _calculate1RM();
          });
        },
        backgroundColor: colorProvider.accent,
        icon: Icon(
          Icons.swap_horiz,
          color: colorProvider.secondary,
        ),
        label: Text(
          _isPounds ? ' lbs ' : ' kg ',
          style: TextStyle(
              color: colorProvider.secondary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text, ColorProvider colorProvider) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: colorProvider.accent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, ColorProvider colorProvider) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: colorProvider.accent),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }
}
