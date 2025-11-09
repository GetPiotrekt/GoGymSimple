import 'package:GoGymSimple/util/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../util/dialog/text_input_dialog.dart';
import '../../../util/dialog/confirmation_dialog.dart';
import '../exercise_view/exercise_expansion/exercise_expansion_helper/icon_selection.dart';

class AddExerciseDialog {
  static Future<void> showExerciseInputDialog(
    BuildContext context, {
    bool isEditing = false,
    String? initialName,
    String? initialIconPath,
    int? exerciseId, // potrzebne do zapisu przy edycji
  }) async {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;

    String? selectedIconPath = initialIconPath;

    // Budujemy widget do wyboru ikony
    Widget iconSelector = Builder(
      builder: (parentContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () async {
                if (selectedIconPath != null && selectedIconPath!.isNotEmpty) {
                  setState(() {
                    selectedIconPath = null;
                  });
                } else {
                  // Wybór nowej ikony
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    backgroundColor: colorProvider.secondary,
                    builder: (context) {
                      return IconSelection(
                        onIconSelected: (iconPath) {
                          Future.microtask(() {
                            if (Navigator.of(parentContext).canPop()) {
                              try {
                                setState(() {
                                  selectedIconPath = iconPath;
                                });
                              } catch (_) {}
                            }
                          });
                        },
                      );
                    },
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorProvider.accent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          t.iconSelection_chooseIcon,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: colorProvider.accent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorProvider.accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: (selectedIconPath != null &&
                                  selectedIconPath!.isNotEmpty)
                              ? Image.asset(
                                  selectedIconPath!,
                                  width: 34,
                                  height: 34,
                                  color: colorProvider.accent,
                                )
                              : Icon(Icons.edit,
                                  size: 26, color: colorProvider.accent),
                        ),
                        if (selectedIconPath != null &&
                            selectedIconPath!.isNotEmpty)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIconPath = '';
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorProvider.secondary,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Icon(Icons.close,
                                    size: 14, color: colorProvider.accent),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Po wyświetleniu dialogu
    String? exerciseName = await TextInputDialog.showTextInputDialog(
      context: context,
      title: isEditing
          ? t.tabBottomDrawer_editExercise
          : t.addExerciseDialog_title,
      labelText: t.addExerciseDialog_label,
      initialText: initialName,
      extraWidget: iconSelector,
    );

    if (exerciseName == null || exerciseName.isEmpty) {
      return; // anulowano lub puste dane - przerywamy
    }

    if (isEditing && exerciseId != null) {
      final exercise = ExerciseBox.getExercisebyID(exerciseId);
      if (exercise != null) {
        exercise.exerciseName = exerciseName;
        exercise.iconPath = selectedIconPath ?? '';
        await ExerciseBox.box.put(exercise.exerciseID, exercise);
      }
    } else {
      await ExerciseBox.addExercise(exerciseName, selectedIconPath ?? '');
      SnackbarHelper.showSnackbar(
        context,
        t.addExerciseDialog_success(exerciseName),
      );

      bool? result = await ConfirmationDialog.show(
        context: context,
        title: t.addExerciseDialog_anotherTitle,
        content: t.addExerciseDialog_anotherContent,
        onConfirmed: () {},
      );

      if (result == true) {
        await showExerciseInputDialog(context);
      }
    }
  }
}
