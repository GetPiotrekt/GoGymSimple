import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/config_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../drawer/support/watch_ad/watch_ad.dart';

class SaveWorkoutDialog extends StatelessWidget {
  final VoidCallback onSave;

  const SaveWorkoutDialog({
    super.key,
    required this.onSave,
  });

  static Future<void> show(
      BuildContext context, {
        required VoidCallback onSave,
      }) async {
    await showDialog(
      context: context,
      builder: (_) => SaveWorkoutDialog(
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    // Pobierz wartość ads_today z configu
    String? adsTodayStr = ConfigBox.getConfig('ads_today') ?? '0';
    int adsToday = int.tryParse(adsTodayStr) ?? 0;
    final now = DateTime.now();
    final showAd = adsToday == 0 && now.isAfter(DateTime(2025, 8, 12));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: colorProvider.secondary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_task_sharp, size: 48, color: colorProvider.accent),
            const SizedBox(height: 16),
            Text(
              t.saveWorkoutDialog_save_workout_title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorProvider.accent,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              t.saveWorkoutDialog_save_workout_subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorProvider.accent.withOpacity(0.7)),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onSave();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorProvider.accent,
                  foregroundColor: colorProvider.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  t.saveWorkoutDialog_save_workout_button,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colorProvider.accent.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  t.saveWorkoutDialog_dont_save_workout_button,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorProvider.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Pokaż sekcję z reklamą tylko jeśli adsToday == 0
            if (showAd)
              GestureDetector(
                onTap: () {
                  const WatchAd().showWatchAdsBottomSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.ondemand_video, size: 28, color: colorProvider.accent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.saveWorkoutDialog_support_us_title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: colorProvider.accent,
                              ),
                            ),
                            Text(
                              t.saveWorkoutDialog_support_us_subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: colorProvider.accent.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
