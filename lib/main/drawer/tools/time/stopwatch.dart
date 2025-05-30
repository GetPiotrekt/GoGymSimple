import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../provider/time_provider.dart';
import '../../../../provider/color_provider.dart';

import '../../../../util/custom_appbar.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.stopwatch_title,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: colorProvider.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: FittedBox(
                  child: Text(
                    t.settings_elementVisibility,
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                value: settingsProvider.getElementVisibility,
                onChanged: (_) => settingsProvider.toggleElementVisibility(),
                activeColor: colorProvider.accent,
                checkColor: colorProvider.secondary,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (!timeProvider.isRunning) {
                  timeProvider.start();
                } else {
                  timeProvider.stop();
                }
              },
              child: Container(
                width: screenWidth * 0.9,
                height: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    /// Ikona w prawym górnym rogu
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Icon(
                        timeProvider.isRunning ? Icons.stop : Icons.play_arrow,
                        size: 42,
                        color: colorProvider.accent,
                      ),
                    ),

                    /// Czas na środku
                    Center(
                      child: Text(
                        timeProvider.formattedElapsed,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: colorProvider.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Przycisk Reset
            if (timeProvider.elapsed.inMilliseconds > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorProvider.secondary,
                          foregroundColor: colorProvider.accent,
                        ),
                        onPressed: timeProvider.reset,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      /// Przycisk Menu
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: colorProvider.accent,
        foregroundColor: colorProvider.secondary,
        icon: const Icon(Icons.home),
        label: const Text('Menu'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
