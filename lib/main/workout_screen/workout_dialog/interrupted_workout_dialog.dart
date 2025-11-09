import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';

class InterruptedWorkoutDialog extends StatelessWidget {
  final String gymLocation;
  final List<String> participants;
  final List<String> exercises;
  final DateTime date;
  final VoidCallback onRestore;
  final VoidCallback onStartFresh;

  const InterruptedWorkoutDialog({
    super.key,
    required this.gymLocation,
    required this.participants,
    required this.exercises,
    required this.date,
    required this.onRestore,
    required this.onStartFresh,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: colorProvider.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DefaultTextStyle(
          style: TextStyle(color: colorProvider.accent),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, color: colorProvider.accent),
                  const SizedBox(width: 8),
                  Text(
                    t.restoreSession_title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorProvider.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                t.restoreSession_info,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorProvider.accent.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 2),
              Text(
                t.restoreSession_content,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorProvider.accent.withValues(alpha: 0.7)),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: colorProvider.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRowWithIcon(
                      icon: Icons.calendar_today,
                      label: DateFormat('dd MMM').format(date),
                      colorProvider: colorProvider,
                    ),
                    _buildDetailRowWithIcon(
                      icon: Icons.location_on,
                      label: gymLocation,
                      colorProvider: colorProvider,
                    ),
                    _buildDetailRowWithIcon(
                      icon: Icons.group,
                      label: participants.join(', '),
                      colorProvider: colorProvider,
                    ),
                    if (exercises.isNotEmpty)
                      _buildDetailRowWithIcon(
                        icon: Icons.fitness_center,
                        label: exercises.join(', '),
                        colorProvider: colorProvider,
                        maxLines: 3,
                        softWrap: true,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onStartFresh,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          t.restoreSession_deny,
                          style: TextStyle(color: colorProvider.accent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRestore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorProvider.accent.withValues(alpha: 0.1),
                        elevation: 0
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          t.restoreSession_confirm,
                          style: TextStyle(color: colorProvider.accent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRowWithIcon({
    required IconData icon,
    required String label,
    required ColorProvider colorProvider,
    int maxLines = 1,
    bool softWrap = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: colorProvider.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: colorProvider.accent, fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              softWrap: softWrap,
            ),
          ),
        ],
      ),
    );
  }

}
