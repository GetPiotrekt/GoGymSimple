import 'package:GoGymSimple/util/snackbar_helper.dart';
import 'package:flutter/material.dart';

import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../util/dialog/text_input_dialog.dart';
import '../../../util/dialog/confirmation_dialog.dart';

class AddExerciseDialog {
  static Future<void> showExerciseInputDialog(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    bool continueAdding = true;

    while (continueAdding) {
      // Get exercise name
      String? exerciseName = await TextInputDialog.showTextInputDialog(
        context: context,
        title: t.addExerciseDialog_title,
        labelText: t.addExerciseDialog_label,
      );

      // Jeśli użytkownik anulował lub zamknął dialog, przerwij pętlę
      if (exerciseName == null) {
        break;
      }

      if (exerciseName.isNotEmpty) {
        // Add exercise to the database
        await ExerciseBox.addExercise(
          exerciseName,
          '', // Default icon path
        );

        // Show success message
        SnackbarHelper.showSnackbar(
          context,
          t.addExerciseDialog_success(exerciseName),
        );
      }

      // Show confirmation dialog to ask if the user wants to add another exercise
      bool? result = await showConfirmationDialog(
        context: context,
        title: t.addExerciseDialog_anotherTitle,
        content: t.addExerciseDialog_anotherContent,
        onConfirmed: () {},
      );

      // Jeśli użytkownik kliknął "Cancel" lub zamknął dialog, zakończ pętlę
      if (result == null || !result) {
        break;
      }
    }
  }
}
