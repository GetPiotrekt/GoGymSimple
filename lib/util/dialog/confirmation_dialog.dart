import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';

// Custom Confirmation Dialog class
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirmed;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: colorProvider.secondary,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
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
            ),
          ),
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(color: colorProvider.accent.withOpacity(0.7)),
      ),
      actions: [
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
            onConfirmed();
            Navigator.of(context).pop(true);
          },
          child: Text(
            t.dialog_confirm,
            style: TextStyle(color: colorProvider.accent),
          ),
        ),
      ],
    );

  }
}

// Function to show the confirmation dialog
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title, // Tytuł okna dialogowego
  required String content, // Treść wiadomości
  required VoidCallback onConfirmed, // Akcja, jeśli użytkownik potwierdzi
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationDialog(
        title: title,
        content: content,
        onConfirmed: onConfirmed,
      );
    },
  );
}
