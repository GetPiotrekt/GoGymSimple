import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';

class NotesEditor extends StatelessWidget {
  final TextEditingController controller;
  final DateTime selectedDate;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onPickDate;
  final bool isEditing;

  const NotesEditor({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onSave,
    required this.onCancel,
    required this.onPickDate,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorProvider.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller,
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: t.notes_hint,
                  hintStyle: TextStyle(color: colorProvider.accent),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: colorProvider.accent),
              ),
              Divider(height: 0, color: colorProvider.accent.withOpacity(0.5),),
              Center(
                child: TextButton.icon(
                  onPressed: onPickDate,
                  icon: Icon(Icons.calendar_today, size: 18, color: colorProvider.accent),
                  label: Text(
                    DateFormat("d MMM yyyy", Localizations.localeOf(context).toString())
                        .format(selectedDate),
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    foregroundColor: colorProvider.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorProvider.accent,
                foregroundColor: colorProvider.secondary,
              ),
              child: Text(isEditing ? t.notes_updateNote : t.notes_saveNote),
            ),
          ),
        ),
      ],
    );
  }
}
