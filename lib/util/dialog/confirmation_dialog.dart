import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';

class ConfirmationDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    VoidCallback? onConfirmed,
  }) async {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    final t = AppLocalizations.of(context)!;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorProvider.secondary,
          title: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(color: colorProvider.accent),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: colorProvider.accent.withOpacity(0.7)),
          ),
          actions: <Widget>[
            if (onConfirmed != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  t.dialog_cancel,
                  style: TextStyle(color: colorProvider.accent),
                ),
              ),
            TextButton(
              onPressed: () {
                if (onConfirmed != null) onConfirmed();
                Navigator.of(context).pop(true);
              },
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
