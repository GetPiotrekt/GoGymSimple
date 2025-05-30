import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/landing_page_provider.dart';
import '../../../../../util/input_form_field/input_decorations.dart';

class GlobalNote extends StatefulWidget {
  final String globalNote;
  final int workoutID;

  const GlobalNote({
    required this.globalNote,
    required this.workoutID,
    super.key,
  });

  @override
  _GlobalNoteState createState() => _GlobalNoteState();
}

class _GlobalNoteState extends State<GlobalNote> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.globalNote);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    setState(() {
      _isEditing = false;
    });

    final trainingSessionProvider = context.read<LandingPageProvider?>();
    if (trainingSessionProvider != null) {
      trainingSessionProvider.updateGlobalNote(widget.workoutID, _controller.text);
    } else {
      debugPrint('TrainingSessionProvider not found in context');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.globalNote_title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorProvider.accent,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.5,
                color: colorProvider.accent.withOpacity(0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Pole notatki**
                  _isEditing
                      ? Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          minLines: 1,
                          maxLines: null,
                          controller: _controller,
                          style: TextStyle(
                            color: colorProvider.accent,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: CustomInputDecorations.buildInputDecoration(
                            context,
                            isLabelVisible: false,
                            t.globalNote_hint,
                          ),
                          onFieldSubmitted: (_) => _saveNote(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.check, color: colorProvider.accent),
                        onPressed: _saveNote,
                      ),
                    ],
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              _controller.text.isNotEmpty
                                  ? _controller.text
                                  : t.globalNote_empty,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: _controller.text.isNotEmpty
                                    ? colorProvider.accent.withOpacity(0.9)
                                    : colorProvider.accent.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.edit, color: colorProvider.accent.withOpacity(0.9)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
