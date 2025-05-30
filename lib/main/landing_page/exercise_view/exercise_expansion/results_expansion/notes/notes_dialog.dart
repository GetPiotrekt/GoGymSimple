import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> showNoteDialog({
  required BuildContext context,
  required TextEditingController noteController,
  required DateTime selectedDate,
  required VoidCallback onPickDate,
  required VoidCallback onSave,
  required VoidCallback onCancel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Add Note",

                ),
              ),
              const SizedBox(height: 16),
              Text("Note Details", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter your note",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              Text("Date", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onPickDate,
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Select a date",
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: TextEditingController(
                      text: DateFormat('yyyy-MM-dd').format(selectedDate),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: onCancel,
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5B4DFF), // Purple button
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Save Note"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
