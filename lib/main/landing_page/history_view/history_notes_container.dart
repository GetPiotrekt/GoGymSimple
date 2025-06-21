import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/data_tab_sector/gym_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../util/dialog/delete_confirmation_dialog.dart';
import 'history_card.dart';

class GroupedNotesContainer extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  final bool isLastGroup;

  const GroupedNotesContainer({
    super.key,
    required this.notes,
    required this.isLastGroup,
  });

  @override
  State<GroupedNotesContainer> createState() => _GroupedNotesContainerState();
}

class _GroupedNotesContainerState extends State<GroupedNotesContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final workout = widget.notes.first['workout'];
    final user = UserBox.getUserByID(workout.userID);
    final gym = GymBox.getGym(workout.gymID);
    final bottomMargin = widget.isLastGroup ? 80.0 : 8.0;

    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, bottomMargin),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${user?.username ?? t.historyView_exerciseNotFound} • ${gym?.name ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorProvider.accent,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: isExpanded
                      ? colorProvider.accent
                      : colorProvider.accent.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
          if (isExpanded) const SizedBox(height: 20),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: widget.notes.asMap().entries.map((entry) {
                final idx = entry.key;
                final noteData = entry.value;
                final isLast = idx == widget.notes.length - 1;
                return HistoryCard(
                  noteData: noteData,
                  index: idx,
                  listLength: widget.notes.length,
                  isLast: isLast,
                  isGrouped: true,
                );
              }).toList(),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
