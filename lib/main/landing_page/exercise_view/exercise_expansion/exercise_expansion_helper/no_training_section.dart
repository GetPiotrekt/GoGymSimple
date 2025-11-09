import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';

class NoTrainingSection extends StatelessWidget {
  final Color accentColor;
  final bool isGlobal;

  const NoTrainingSection({super.key, required this.accentColor, this.isGlobal = false});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(8, isGlobal ? 8 : 0, 8, isGlobal ? 0 : 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    isGlobal
                        ? t.noTrainingSection_noSavedGlobal
                        : t.noTrainingSection_noSaved,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 24,
              color: accentColor.withOpacity(0.3),
              indent: 12,
              endIndent: 12,
            ),

            _buildIconTextRow(
              icon: Icons.play_arrow_rounded,
              textSpans: [
                TextSpan(text: t.noTrainingSection_startNewFirst.split("'Start'")[0]),
                const TextSpan(text: 'Start', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextSpan(text: t.noTrainingSection_startNewFirst.split("'Start'")[1]),
              ],
              color: accentColor,
            ),
            const SizedBox(height: 10),
            _buildIconTextRow(
              icon: Icons.play_circle_fill,
              textSpans: [
                TextSpan(text: t.noTrainingSection_startNewSecond),
              ],
              color: accentColor,
            ),
            const SizedBox(height: 10),
            _buildIconTextRow(
              icon: Icons.history,
              textSpans: [
                TextSpan(text: t.noTrainingSection_addPrevious),
              ],
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconTextRow({
    required IconData icon,
    required List<InlineSpan> textSpans,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color.withOpacity(0.9)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: color.withOpacity(0.9), fontSize: 15.5),
              children: textSpans,
            ),
          ),
        ),
      ],
    );
  }
}
