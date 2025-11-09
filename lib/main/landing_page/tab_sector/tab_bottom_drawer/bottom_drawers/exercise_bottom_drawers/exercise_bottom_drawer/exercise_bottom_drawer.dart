import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../provider/color_provider.dart';
import '../../../../../../../util/bottom_sheet/bottom_sheet.dart';
import '../../../../add_exercise.dart';
import '../multi_exercise_select_dialog.dart';
import 'exercise_bottom_drawer_list.dart';

class ExerciseBottomDrawer {
  static void show(BuildContext context, {required bool isFromWorkout}) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = context.read<ColorProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BottomSheetTemplate(
        onPressed: () => Navigator.pop(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                t.tabBottomDrawer_showOnly,
                style: TextStyle(
                  fontSize: 22,
                  color: colorProvider.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ExerciseListSection(isFromWorkout: isFromWorkout),
            const SizedBox(height: 8),
            _buildBottomActions(context, colorProvider, t),
          ],
        ),
      ),
    );
  }

  static Widget _buildBottomActions(
      BuildContext context, ColorProvider colorProvider, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorProvider.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.add, color: colorProvider.accent),
                title: Text(
                  t.tabBottomDrawer_addNewExercise,
                  style: TextStyle(color: colorProvider.accent),
                ),
                onTap: () => AddExerciseDialog.showExerciseInputDialog(context),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.playlist_add_check, color: colorProvider.accent),
              onPressed: () => MultiExerciseSelectDialog.show(context),
            ),
          ),
        ],
      ),
    );
  }
}