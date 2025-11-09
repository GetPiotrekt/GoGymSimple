import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer

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

  static final RegExp _urlRegex = RegExp(
    r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
    caseSensitive: false,
    multiLine: true,
  );

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
      trainingSessionProvider.updateGlobalNote(
          widget.workoutID, _controller.text);
    } else {
      debugPrint('TrainingSessionProvider not found in context');
    }
  }

  // Function to build the RichText with clickable links
  TextSpan _buildTextSpan(String text, Color accentColor) {
    final List<TextSpan> spans = [];
    text.splitMapJoin(
      _urlRegex,
      onMatch: (Match match) {
        String url = match.group(0)!;
        // Prepend http if missing, for launchUrl to work reliably
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          url = 'http://$url';
        }
        spans.add(
          TextSpan(
            text: match.group(0),
            style: const TextStyle(
              color: Colors.blue, // Link color
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                } else {
                  debugPrint('Could not launch $url');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Could not open link: ${match.group(0)}')),
                  );
                }
              },
          ),
        );
        return ''; // Return empty string as we added to spans
      },
      onNonMatch: (String nonMatch) {
        spans.add(
          TextSpan(
            text: nonMatch,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: _controller.text.isNotEmpty
                  ? accentColor.withOpacity(0.9)
                  : accentColor.withOpacity(0.5),
            ),
          ),
        );
        return ''; // Return empty string as we added to spans
      },
    );
    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final t = AppLocalizations.of(context)!;
    final bool isNoteEmpty = _controller.text.trim().isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.globalNote_title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorProvider.accent,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.edit, size: 20, color: colorProvider.accent),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorProvider.accent.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.5,
                color: colorProvider.accent.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEditing)
                  TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: t.addUserAndGym_workoutGlobalNote(widget.workoutID),
                      hintStyle: TextStyle(
                        color: colorProvider.accent.withOpacity(0.4),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: colorProvider.accent,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    onChanged: (_) {
                      if (!_isEditing) {
                        setState(() => _isEditing = true);
                      }
                    },
                    onSubmitted: (_) => _saveNote(),
                  )
                else if (isNoteEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        t.globalNote_hint,
                        style: TextStyle(
                          color: colorProvider.accent.withOpacity(0.5),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                else
                  RichText(
                    text: _buildTextSpan(_controller.text, colorProvider.accent),
                  ),

                if (_isEditing) const SizedBox(height: 8),
                if (_isEditing)
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton.icon(
                      onPressed: _saveNote,
                      icon: Icon(Icons.check, color: colorProvider.accent),
                      label: Text(
                        t.notes_saveNote,
                        style: TextStyle(color: colorProvider.accent),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        backgroundColor: colorProvider.accent.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
