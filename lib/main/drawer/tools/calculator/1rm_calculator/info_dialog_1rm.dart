import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';

class InfoDialog1RM extends StatelessWidget {
  const InfoDialog1RM({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!; // Localized text

    return Dialog(
      backgroundColor: colorProvider.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.infoDialog1RM_title,  // Użycie tłumaczenia
              style: TextStyle(
                color: colorProvider.accent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              t.infoDialog1RM_description,  // Użycie tłumaczenia
              style: TextStyle(color: colorProvider.accent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorProvider.secondary,
                side: BorderSide(color: colorProvider.accent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                t.infoDialog1RM_closeButton,  // Użycie tłumaczenia
                style: TextStyle(color: colorProvider.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
