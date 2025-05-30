import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';

typedef OnTimeSelected = void Function(TimeOfDay selectedTime);

class CustomTimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final OnTimeSelected onTimeSelected;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: initialTime,
          builder: (context, child) => Theme(
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
        if (time != null) onTimeSelected(time);
      },
      child: Row(
        children: [
          Icon(Icons.access_time, color: colorProvider.accent),
          const SizedBox(width: 12),
          Text(
            "${AppLocalizations.of(context)!.timePicker_label}: ${initialTime.format(context)}",
            style: TextStyle(color: colorProvider.accent),
          ),
        ],
      ),
    );
  }
}
