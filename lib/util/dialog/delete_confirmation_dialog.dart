import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';

class DeleteConfirmationDialog {
  static Future<bool?> show(BuildContext context) async {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorProvider.secondary,
          title: FittedBox(
            child: Text(
              t.deleteConfirmationDialog_title,
              style: TextStyle(color: colorProvider.accent),
              textAlign: TextAlign.center,
            ),
          ),
          content: FittedBox(
            child: Text(
              t.dialog_content,
              style: TextStyle(color: colorProvider.accent),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                t.dialog_cancel,
                style: TextStyle(color: colorProvider.accent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(colorProvider.secondary),
                side: WidgetStateProperty.all<BorderSide>(BorderSide(color: colorProvider.accent)),
              ),
              child: Text(
                t.dialog_confirm,
                style: TextStyle(color: colorProvider.accent),
              ),
            ),
          ],
        );
      },
    );
  }
}
