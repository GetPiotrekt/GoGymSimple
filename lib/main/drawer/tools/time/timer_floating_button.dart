import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/time_provider.dart';
import '../../../../provider/settings_provider.dart';
import 'stopwatch.dart';

class TimerFloatingButton extends StatelessWidget {
  const TimerFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final timeProvider = context.watch<TimeProvider>();
    final colorProvider = context.watch<ColorProvider>();

    if (!settingsProvider.getElementVisibility ||
        MediaQuery.of(context).viewInsets.bottom != 0) {
      return const SizedBox.shrink();
    }

    if (timeProvider.isExpanded) {
      return GestureDetector(
        onLongPress: timeProvider.reset,
        child: FloatingActionButton.extended(
          elevation: 3,
          backgroundColor: colorProvider.secondary,
          foregroundColor: colorProvider.accent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StopwatchScreen()),
            );
          },
          label: Row(
            children: [
              const Icon(Icons.timer_outlined, size: 28), // zmniejszone z 30
              const SizedBox(width: 8),
              Text(
                timeProvider.formattedElapsed,
                style: const TextStyle(fontSize: 16), // zmniejszone z 18
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  timeProvider.isRunning
                      ? timeProvider.stop()
                      : timeProvider.start();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8), // zmniejszone z 10
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: colorProvider.accent, width: 1.2), // lżejszy
                  ),
                  child: Icon(
                    timeProvider.isRunning ? Icons.pause : Icons.play_arrow,
                    size: 16, // zmniejszone z 18
                    color: colorProvider.accent,
                  ),
                ),
              ),
              if (timeProvider.elapsed != Duration.zero)
                GestureDetector(
                  onTap: timeProvider.reset,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colorProvider.accent, width: 1.2),
                    ),
                    child: Icon(
                      Icons.replay,
                      size: 16,
                      color: colorProvider.accent,
                    ),
                  ),
                ),
              if (timeProvider.elapsed != Duration.zero)
                const SizedBox(width: 6),
              GestureDetector(
                onTap: timeProvider.toggleExpanded,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorProvider.accent, width: 1.2),
                  ),
                  child: Icon(
                    Icons.expand_more,
                    size: 16,
                    color: colorProvider.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return FloatingActionButton(
        elevation: 3,
        mini: true,
        backgroundColor: colorProvider.accent,
        foregroundColor: colorProvider.secondary,
        onPressed: timeProvider.toggleExpanded,
        child: const Icon(Icons.timer_outlined),
      );
    }
  }
}
