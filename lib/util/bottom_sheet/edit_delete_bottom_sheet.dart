import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../dialog/text_input_dialog.dart';

class EditDeleteBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String initialName,
    required int id,
    required Future<void> Function(String newName) onEdit,
    required Future<void> Function() onDelete,
  }) async {
    final colorProvider = context.read<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final selectedAction = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: colorProvider.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: colorProvider.accent),
              title: Text(t.editDeleteBottomSheet_edit, style: TextStyle(color: colorProvider.accent)),
              onTap: () => Navigator.pop(context, 'edit'),
            ),
            ListTile(
              leading: Icon(Icons.delete, color: colorProvider.accent),
              title: Text(t.editDeleteBottomSheet_delete, style: TextStyle(color: colorProvider.accent)),
              onTap: () => Navigator.pop(context, 'delete'),
            ),
          ],
        );
      },
    );

    if (selectedAction == 'edit') {
      final newName = await TextInputDialog.showTextInputDialog(
        context: context,
        title: t.tabBottomDrawer_editTitle, // tu dynamicznie tytuł
        labelText: t.tabBottomDrawer_editLabel, // tu dynamiczny label
        initialText: initialName,
      );
      if (newName != null && newName.isNotEmpty) {
        await onEdit(newName);
      }
    } else if (selectedAction == 'delete') {
      await onDelete();
    }
  }
}
