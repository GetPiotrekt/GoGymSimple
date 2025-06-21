import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/landing_page_provider.dart';

class NoTrainingSection extends StatelessWidget {
  final Color accentColor;

  const NoTrainingSection({
    super.key,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final landingPageProvider = Provider.of<LandingPageProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.noTrainingSection_noSaved,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 12,
              color: accentColor.withOpacity(0.5),
              indent: 16,
              endIndent: 16,
            ),
            Text(
              t.noTrainingSection_startNew,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => landingPageProvider.setEditingNote(true),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 20,
                  color: accentColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              t.noTrainingSection_addPrevious,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: accentColor.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
