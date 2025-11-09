import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:GoGymSimple/data/data_tab_sector/user_data/user_db.dart';
import 'package:GoGymSimple/data/workout/workout_db.dart';
import 'package:GoGymSimple/l10n/app_localizations.dart';
import 'package:GoGymSimple/provider/color_provider.dart';
import 'package:GoGymSimple/util/dialog/text_input_dialog.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/custom_confetti.dart';
import '../../util/custom_dropdown.dart';

class CustomDrawerHelper {
  static Future<User?> getUser() async {
    await UserBox.openBox();
    return UserBox.getUserByID(1);
  }

  static Future<int> countAllNotesInWorkoutBox() async {
    final box = await Hive.openBox<Workout>('workout');
    int totalNotes = 0;
    for (var workout in box.values) {
      totalNotes += workout.notes.length;
    }
    return totalNotes;
  }

  // Tutaj wywołujesz widget stateful, który ma konfetti
  static Widget buildHeader(User user, ColorProvider colorProvider, Color accentColor) {
    return UserHeaderWithConfetti(
      user: user,
      colorProvider: colorProvider,
      accentColor: accentColor,
    );
  }

  // Reszta Twojego CustomDrawerHelper bez zmian...

  static Widget buildDropdownSection(
      BuildContext context,
      String title,
      List<Widget> items,
      ColorProvider colorProvider,
      IconData icon,
      ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: colorProvider.accent),
        title: Text(
          title,
          style: CustomDropdown.dropdownItemStyle(colorProvider),
        ),
        iconColor: colorProvider.accent,
        collapsedIconColor: colorProvider.accent.withOpacity(0.7),
        childrenPadding: const EdgeInsets.only(left: 12),
        children: items,
      ),
    );
  }

  static Widget buildSection(
      String title,
      List<Widget> items,
      ColorProvider colorProvider,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorProvider.accent,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: CustomDropdown.dropdownDecoration(colorProvider),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(BuildContext context, ColorProvider colorProvider) {
    final accentColor = colorProvider.accent;
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        Divider(color: accentColor.withOpacity(0.3),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _launchUrl(
                    'https://docs.google.com/document/d/1Hf_h5x7XIvdsGgXhtcm78FU6KXeshvvLi9CDsujPHks/edit?usp=sharing'),
                child: Text(
                  t.drawer_privacyPolicy,
                  style: TextStyle(
                    color: accentColor.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "•",
                  style: TextStyle(
                    color: accentColor.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap: () => _launchUrl(
                    'https://docs.google.com/document/d/1d7pBuJfJA-EAkaTI9MBK4tN6pCFE7lhPJWZ44JttGYY/edit?usp=sharing'),
                child: Text(
                  t.drawer_termsOfUse,
                  style: TextStyle(
                    color: accentColor.withAlpha(230),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}

// Nowy stanowy widget z konfetti i licznikiem kliknięć
class UserHeaderWithConfetti extends StatefulWidget {
  final User user;
  final ColorProvider colorProvider;
  final Color accentColor;

  const UserHeaderWithConfetti({
    super.key,
    required this.user,
    required this.colorProvider,
    required this.accentColor,
  });

  @override
  _UserHeaderWithConfettiState createState() => _UserHeaderWithConfettiState();
}

class _UserHeaderWithConfettiState extends State<UserHeaderWithConfetti> {
  late ConfettiController _confettiController;
  int _clickCount = 0;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onLogoTap() {
    setState(() {
      _clickCount++;
      if (_clickCount == 10) {
        _confettiController.play();
        _clickCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: CustomDrawerHelper.countAllNotesInWorkoutBox(),
      builder: (context, snapshot) {
        final noteCount = snapshot.data ?? 0;
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  color: widget.colorProvider.secondary,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _onLogoTap,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: widget.accentColor.withOpacity(0.1),
                          child: ClipOval(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(widget.accentColor, BlendMode.srcATop),
                              child: Image.asset(
                                'assets/icons/logo_bl.png',
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final newName = await TextInputDialog.showTextInputDialog(
                            context: context,
                            title: 'Edit Username',
                            labelText: 'Enter new username',
                            initialText: widget.user.username,
                          );
                          if (newName != null && newName.isNotEmpty) {
                            widget.user.username = newName;
                            await UserBox.box.put(widget.user.userID, widget.user);
                            if (mounted) Navigator.pop(context, true);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.username,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 16, color: widget.accentColor.withOpacity(0.7)),
                          const SizedBox(width: 4),
                          Text(
                            '${AppLocalizations.of(context)!.drawer_noteCount} $noteCount',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.accentColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: widget.accentColor.withOpacity(0.3)),
              ],
            ),
            // Konfetti na wierzchu
            Align(
              alignment: Alignment.topCenter,
              child: CustomConfetti(confettiController: _confettiController)
            ),
          ],
        );
      },
    );
  }
}
