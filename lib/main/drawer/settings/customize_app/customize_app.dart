import 'package:GoGymSimple/main/drawer/settings/customize_app/selected_theme.dart';
import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/colors_db.dart';
import '../../../../data/config_db.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../util/dialog/delete_confirmation_dialog.dart';
import 'customize_floating_buttons.dart';

class CustomizeApp extends StatefulWidget {
  const CustomizeApp({super.key});

  @override
  _CustomizeAppState createState() => _CustomizeAppState();
}

class _CustomizeAppState extends State<CustomizeApp> {
  String? _currentPalette;
  Map<String, List<ColorCombination>> _groupedCombinations = {};

  @override
  void initState() {
    super.initState();
    _loadCurrentPalette();
  }

  Future<void> _loadCurrentPalette() async {
    final currentPalette = ConfigBox.getConfig('pattern');
    setState(() {
      _currentPalette = currentPalette;
    });
    _reloadPalettes();
  }

  void _reloadPalettes() {
    final allCombinations = ColorCombinationBox.getAllColorCombinations();
    final groupedCombinations = <String, List<ColorCombination>>{};

    for (final combination in allCombinations) {
      final group = combination.group;
      groupedCombinations.putIfAbsent(group, () => []);
      groupedCombinations[group]!.add(combination);
    }

    setState(() {
      _groupedCombinations = groupedCombinations;
    });
  }

  void _applyPalette(String palette) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    setState(() {
      _currentPalette = palette;
      ConfigBox.updateConfig('pattern', palette);
      colorProvider.updateCurrentPalette(palette);
    });
    _reloadPalettes();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectedTheme()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.customizeApp_availableColorPalettes,
      ),
      body: Container(
        color: colorProvider.accent.withOpacity(0.1),
        child: ListView.builder(
          itemCount: _groupedCombinations.length + 1,
          itemBuilder: (context, index) {
            if (index == _groupedCombinations.length) {
              return const SizedBox(height: 66);
            }

            final group = _groupedCombinations.keys.elementAt(index);
            final colorCombinations = _groupedCombinations[group]!;

            final primaryColor = Color(colorCombinations.first.color);
            final secondaryColor = colorCombinations.length >= 3
                ? Color(colorCombinations[1].color)
                : Colors.black45;
            final textColor = colorCombinations.length >= 3
                ? Color(colorCombinations[2].color)
                : Colors.white70;

            bool isCurrent = _currentPalette == group;

            return Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: isCurrent ? secondaryColor : primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: textColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            group,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.5),
                          thickness: 2,
                          height: 20,
                          indent: 20,
                          endIndent: 20,
                        ),
                        if (isCurrent)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                t.customizeApp_currentTheme,
                                style: TextStyle(
                                  color: textColor.withOpacity(0.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: textColor.withOpacity(0.7),
                                size: 20,
                              ),
                            ],
                          ),
                        if (!isCurrent)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _applyPalette(group);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20.0),
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                                  decoration: BoxDecoration(
                                    color: textColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    t.customizeApp_setTheme,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: textColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: textColor),
                                  onPressed: () async {
                                    final confirmed = await DeleteConfirmationDialog.show(context);
                                    if (confirmed == true) {
                                      final List<ColorCombination> combinationsToDelete =
                                      _groupedCombinations[group]!;
                                      for (final combination in combinationsToDelete) {
                                        await ColorCombinationBox.deleteColorCombination(combination.colorID);
                                      }
                                      await _loadCurrentPalette();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: CustomizeFloatingButtons(
        refreshScreen: () async {
          await _loadCurrentPalette();
        },
      ),
    );
  }
}
