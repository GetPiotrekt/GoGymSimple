import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';

typedef OnTimeSelected = void Function(TimeOfDay selectedTime);

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final OnTimeSelected onTimeSelected;
  final bool use24HourFormat;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
    this.use24HourFormat = false,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late bool _use24HourFormat;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _use24HourFormat = widget.use24HourFormat;
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: _use24HourFormat,
              ),
              child: Theme(
                data: ThemeData(
                  primaryColor: colorProvider.primary,
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(color: colorProvider.accent),
                  ),
                  dialogTheme: DialogThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  colorScheme: ColorScheme.dark(
                    primaryContainer: colorProvider.accent.withOpacity(0.1),
                    primary: colorProvider.accent.withOpacity(0.4),
                    onPrimary: colorProvider.accent,
                    onSurface: colorProvider.accent,
                    surface: colorProvider.secondary,
                  ),
                ),
                child: child!,
              ),
            );
          },
        );
        if (time != null) {
          setState(() {
            _selectedTime = time;
          });
          widget.onTimeSelected(time);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.access_time, color: colorProvider.accent),
              ),
              const SizedBox(width: 12),
              Text(
                "${AppLocalizations.of(context)!.timePicker_label}: ",
                style: TextStyle(
                  color: colorProvider.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _selectedTime.format(context),
                  style: TextStyle(
                    color: colorProvider.accent,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
