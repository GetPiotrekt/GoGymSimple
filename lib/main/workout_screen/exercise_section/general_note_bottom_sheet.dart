import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../../util/bottom_sheet/bottom_sheet.dart';
import '../../../util/dialog/confirmation_dialog.dart';

class GeneralNoteBottomSheet extends StatefulWidget {
  final TextEditingController controller;

  const GeneralNoteBottomSheet({super.key, required this.controller});

  @override
  State<GeneralNoteBottomSheet> createState() => _GeneralNoteBottomSheetState();
}

class _GeneralNoteBottomSheetState extends State<GeneralNoteBottomSheet> {
  bool _isEditing = false;
  bool _suppressNextEdit = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (_suppressNextEdit) {
      _suppressNextEdit = false;
      return;
    }
    setState(() {
      _isEditing = widget.controller.text.trim().isNotEmpty;
    });
  }

  void _submitNote() {
    context.read<WorkoutProvider>().generalNote = widget.controller.text;
    _suppressNextEdit = true;
    setState(() {
      _isEditing = false;
    });
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();

    return BottomSheetTemplate(
      onPressed: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Notatka treningowa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorProvider.accent,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      ConfirmationDialog.show(
                        context: context,
                        title: 'O notatce treningowej',
                        content:
                        'To idealne miejsce na zapisanie przygotowania do treningu, suplementów przedtreningowych czy aktualnej wagi. Dzięki temu łatwiej Ci później odtworzyć warunki tego treningu.',
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      size: 20,
                      color: colorProvider.accent.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              if (_isEditing)
                TextButton.icon(
                  onPressed: _submitNote,
                  icon: Icon(Icons.check, color: colorProvider.accent),
                  label: Text(
                    'Zapisz',
                    style: TextStyle(color: colorProvider.accent),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: colorProvider.accent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          /// Stylizowane pole tekstowe z licznikiem
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.5,
                color: colorProvider.accent.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: widget.controller,
                  maxLength: 200,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Dodaj notatkę do treningu...',
                    hintStyle: TextStyle(color: colorProvider.accent),
                    border: InputBorder.none,
                    counter: Builder(
                      builder: (context) {
                        final text = widget.controller.text;
                        final currentLength = text.characters.length;
                        final isOverLimit = currentLength > 200;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Sugerowana długość: ',
                              style: TextStyle(
                                color: colorProvider.accent.withOpacity(0.6),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              '$currentLength/200',
                              style: TextStyle(
                                color: isOverLimit
                                    ? colorProvider.accent
                                    : colorProvider.accent.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  style: TextStyle(color: colorProvider.accent),
                ),
              ],
            ),
          ),

          /*const SizedBox(height: 12),

          /// Aktualna waga - edytowalna w miejscu
          Row(
            children: [
              Icon(Icons.monitor_weight, color: colorProvider.accent, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: workoutProvider.currentWeight == 0
                        ? ''
                        : workoutProvider.currentWeight.toStringAsFixed(1),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Podaj swoją wagę (kg)',
                    hintStyle: TextStyle(
                      color: colorProvider.accent.withOpacity(0.7),
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: colorProvider.accent,
                    fontSize: 13,
                  ),
                  onSubmitted: (value) {
                    double? weight = double.tryParse(value.replaceAll(',', '.'));
                    if (weight != null) {
                      workoutProvider.currentWeight = weight;
                    }
                  },
                ),
              ),
            ],
          ),*/

        ],
      ),
    );
  }

}
