import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import '../../../../util/button_icon.dart';
import 'full_color_picker.dart';
import 'save_palette.dart';

class AddPattern extends StatefulWidget {
  final Color primaryBasic;
  final Color secondaryBasic;
  final Color accentBasic;

  const AddPattern({
    super.key,
    required this.primaryBasic,
    required this.secondaryBasic,
    required this.accentBasic,
  });

  @override
  _AddPatternState createState() => _AddPatternState();
}

class _AddPatternState extends State<AddPattern> {
  late Color primaryColor;
  late Color secondaryColor;
  late Color accentColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final colorProvider = Provider.of<ColorProvider>(context);
    primaryColor = colorProvider.primary;
    secondaryColor = colorProvider.secondary;
    accentColor = colorProvider.accent;
  }

  void changePrimaryColor(Color color) {
    setState(() {
      primaryColor = color;
    });
  }

  void changeSecondaryColor(Color color) {
    setState(() {
      secondaryColor = color;
    });
  }

  void changeAccentColor(Color color) {
    setState(() {
      accentColor = color;
    });
  }

  void _showColorPickerModal(BuildContext context, Color selectedColor,
      Function(Color) onColorChange) {
    final t = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.secondaryBasic,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(27),
              topLeft: Radius.circular(27),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: MaterialColorPicker(
                  elevation: 3,
                  alignment: WrapAlignment.center,
                  selectedColor: selectedColor,
                  onColorChange: onColorChange,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.maxFinite,
                child: ButtonIcon(
                  iconData: Icons.add,
                  labelText: t.addPattern_moreColors,
                  onPressed: () {
                    Navigator.of(context).pop(); // zamknij ten modal
                    _showFullColorPickerDialog(context, selectedColor, onColorChange);
                  },
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: Colors.transparent,
    );
  }

  void _showFullColorPickerDialog(
    BuildContext context,
    Color initialColor,
    ValueChanged<Color> onColorSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Provider.of<ColorProvider>(context).secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          content: FullColorPicker(
            initialColor: initialColor,
            onColorSelected: (selectedColor) {
              onColorSelected(selectedColor);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: widget.primaryBasic,
      appBar: CustomAppBar(
        title: t.addPattern_title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.addPattern_iconsText,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: accentColor),
                          ),
                          Divider(color: accentColor, endIndent: 10, indent: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.favorite, color: accentColor),
                              Icon(Icons.thumb_up, color: accentColor),
                              Icon(Icons.thumb_down, color: accentColor),
                            ],
                          ),
                          Divider(color: accentColor, endIndent: 10, indent: 10),
                          const SizedBox(height: 15),
                          Text(
                            t.addPattern_textExample,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: accentColor.withOpacity(0.6)),
                          ),
                          Divider(color: accentColor.withOpacity(0.5), endIndent: 10, indent: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.favorite, color: accentColor.withOpacity(0.6)),
                              Icon(Icons.thumb_up, color: accentColor.withOpacity(0.6)),
                              Icon(Icons.thumb_down, color: accentColor.withOpacity(0.6)),
                            ],
                          ),
                          Divider(color: accentColor.withOpacity(0.6), endIndent: 10, indent: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // przyciski pod kontenerem
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ButtonIcon(
                        onPressed: () => _showColorPickerModal(
                            context, primaryColor, changePrimaryColor),
                        iconData: Icons.color_lens,
                        labelText: t.addPattern_backgroundColor,
                        backgroundColor: colorProvider.secondary,
                      ),
                      ButtonIcon(
                        onPressed: () => _showColorPickerModal(
                            context, secondaryColor, changeSecondaryColor),
                        iconData: Icons.color_lens,
                        labelText: t.addPattern_sectionColor,
                        backgroundColor: colorProvider.secondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ButtonIcon(
                        onPressed: () => _showColorPickerModal(
                            context, accentColor, changeAccentColor),
                        iconData: Icons.color_lens,
                        labelText: t.addPattern_textIconsColor,
                        backgroundColor: colorProvider.secondary,
                      ),
                      ButtonIcon(
                        onPressed: () async {
                          final name = await SavePalette.showColorNameDialog(context);
                          if (name != null) {
                            SavePalette.saveColors(context, name, primaryColor, secondaryColor, accentColor);
                          }
                        },
                        iconData: Icons.save_alt,
                        labelText: t.addPattern_save,
                        backgroundColor: colorProvider.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
