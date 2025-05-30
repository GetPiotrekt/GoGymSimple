import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';

class FullColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  const FullColorPicker({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  @override
  State<FullColorPicker> createState() => _FullColorPickerState();
}

class _FullColorPickerState extends State<FullColorPicker> {
  late Color pickerColor;
  final TextEditingController hexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pickerColor = widget.initialColor;
    hexController.text =
        '#${widget.initialColor.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: colorProvider.accent),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorProvider.accent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorProvider.accent, width: 2),
            ),
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
                bodyMedium: TextStyle(color: colorProvider.accent),
                bodyLarge: TextStyle(color: colorProvider.accent),
              ),
          dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(colorProvider.secondary),
            ),
            textStyle: TextStyle(
                color: colorProvider.accent,
                backgroundColor: colorProvider.secondary),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.fullColorPicker_chooseColor,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorProvider.accent,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onColorSelected(pickerColor);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    t.fullColorPicker_save,
                    style: TextStyle(color: colorProvider.accent),
                  ),
                )
              ],
            ),
            Divider(color: colorProvider.accent.withOpacity(0.5)),
            ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => setState(() {
                pickerColor = color;
                hexController.text =
                '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
              }),
              labelTypes: [],
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              colorPickerWidth: 300,
              pickerAreaBorderRadius: BorderRadius.circular(16),
              hexInputBar: true,
              hexInputController: hexController,
            ),
          ],
        ),
      ),
    );
  }
}
