import 'package:GoGymSimple/main/drawer/settings/language_screen.dart';
import 'package:GoGymSimple/main/drawer/support/share_app.dart';
import 'package:GoGymSimple/main/drawer/support/watch_ad/watch_ad.dart';
import 'package:GoGymSimple/main/drawer/tools/time/stopwatch.dart';
import 'package:GoGymSimple/main/drawer/tools/tracker/measurement_tracker/measurement_tracker.dart';
import 'package:GoGymSimple/main/drawer/tools/tracker/weight_tracker.dart';
import 'package:GoGymSimple/main/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/data_tab_sector/user_data/user_db.dart';
import '../../data/workout_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../util/dialog/text_input_dialog.dart';
import '../../util/dropdown.dart';
import 'settings/customize_app/customize_app.dart';
import 'settings/notification_screen/notification_screen.dart';
import 'support/donate/donate.dart';
import 'tools/calculator/1rm_calculator/calculator_1rm.dart';
import 'tools/calculator/bmr_calculator/calculator_bmr.dart';
import 'tools/calculator/plate_calculator/plate_calculator.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final accentColor = colorProvider.accent;
    final t = AppLocalizations.of(context)!; // Localized text

    return FutureBuilder<User?>(
      future: _getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data ?? User(1, t.drawer_guest);

        return Drawer(
          backgroundColor: colorProvider.secondary,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(user, colorProvider, accentColor),
              _buildSection(
                t.drawer_tools_section, // Using localized string
                [
                  _buildDropdownSection(
                    context,
                    t.drawer_calculators_section, // Using localized string
                    [
                      _buildListItem(
                        context,
                        Icons.looks_one_rounded,
                        t.drawer_oneRepMax, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Calculator1RM(),
                          ),
                        ),
                      ),
                      _buildListItem(
                        context,
                        Icons.local_fire_department,
                        t.drawer_bmr, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalculatorBMR(),
                          ),
                        ),
                      ),
                      _buildListItem(
                        context,
                        Icons.monitor_weight,
                        t.drawer_platesOnBarbell, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlateCalculator(),
                          ),
                        ),
                      ),
                    ],
                    colorProvider,
                    Icons.calculate,
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildDropdownSection(
                    context,
                    t.drawer_time_section, // Using localized string
                    [
                      _buildListItem(
                        context,
                        Icons.timer_outlined,
                        t.drawer_stopwatch, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StopwatchScreen(),
                          ),
                        ),
                      ),
                    ],
                    colorProvider,
                    Icons.timelapse,
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildDropdownSection(
                    context,
                    t.drawer_trackers_section, // Using localized string
                    [
                      _buildListItem(
                        context,
                        Icons.timeline,
                        t.drawer_weightTracker, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeightTracker(),
                          ),
                        ),
                      ),
                      _buildListItem(
                        context,
                        Icons.accessibility,
                        t.drawer_measurementTracker, // Using localized string
                        accentColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeasurementTracker(),
                          ),
                        ),
                      ),
                    ],
                    colorProvider,
                    Icons.track_changes,
                  ),
                ],
                colorProvider,
              ),
              _buildSection(
                t.drawer_settings_section, // Using localized string
                [
                  _buildListItem(
                    context,
                    Icons.edit_note_rounded,
                    t.drawer_customizeApp, // Using localized string
                    accentColor,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomizeApp(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildListItem(
                    context,
                    Icons.language_outlined,
                    t.drawer_appLanguage, // Using localized string
                    accentColor,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageScreen(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildListItem(
                    context,
                    Icons.notifications,
                    t.drawer_notificationSettings, // New notification item
                    accentColor,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    ),
                  ),
                ],
                colorProvider,
              ),
              _buildSection(
                t.drawer_appreciation_section,
                [
                  _buildListItem(
                    context,
                    Icons.volunteer_activism,
                    t.drawer_supportButton,
                    accentColor,
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Donate()),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildListItem(
                    context,
                    Icons.video_library,
                    t.drawer_watchAd,
                    accentColor,
                    () {
                      const WatchAd().showWatchAdsBottomSheet(context);
                    },
                  ),
                  Divider(
                    height: 0,
                    color: colorProvider.accent.withOpacity(0.3),
                    endIndent: 8,
                    indent: 8,
                  ),
                  _buildListItem(
                    context,
                    Icons.share,
                    t.drawer_shareApp,
                    accentColor,
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ShareApp()),
                      );
                    },
                  ),
                ],
                colorProvider,
              ),
              const SizedBox(height: 8),
              _buildFooter(context, colorProvider),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<User?> _getUser() async {
    await UserBox.openBox();
    return UserBox.getUserByID(1);
  }

  Widget _buildHeader(
      User user, ColorProvider colorProvider, Color accentColor) {
    return FutureBuilder<int>(
      future: countAllNotesInWorkoutBox(),
      builder: (context, snapshot) {
        final noteCount = snapshot.data ?? 0;

        return Column(
          children: [
            Container(
              color: colorProvider.secondary,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: accentColor.withOpacity(0.1),
                    child: ClipOval(
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(accentColor, BlendMode.srcATop),
                        child: Image.asset(
                          'assets/icons/logo_bl.png',
                          width: 70,
                          height: 70,
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
                        initialText: user.username,
                      );

                      if (newName != null && newName.isNotEmpty) {
                        user.username = newName;
                        await UserBox.box.put(user.userID, user);
                        Navigator.pop(context, true);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star,
                          size: 16, color: accentColor.withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Text(
                        '${AppLocalizations.of(context)!.drawer_noteCount} $noteCount',
                        style: TextStyle(
                          fontSize: 14,
                          color: accentColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: accentColor.withOpacity(0.3),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdownSection(BuildContext context, String title,
      List<Widget> items, ColorProvider colorProvider, IconData icon) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: colorProvider.accent),
        title:
            Text(title, style: CustomDropdown.dropdownItemStyle(colorProvider)),
        iconColor: colorProvider.accent,
        collapsedIconColor: colorProvider.accent.withOpacity(0.7),
        childrenPadding: const EdgeInsets.only(left: 12),
        children: items,
      ),
    );
  }

  Widget _buildSection(
      String title, List<Widget> items, ColorProvider colorProvider) {
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
                  color: colorProvider.accent),
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

  Widget _buildFooter(BuildContext context, ColorProvider colorProvider) {
    final accentColor = colorProvider.accent;
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        Divider(color: accentColor.withOpacity(0.3),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _launchUrl(
                    'https://docs.google.com/document/d/1Hf_h5x7XIvdsGgXhtcm78FU6KXeshvvLi9CDsujPHks/edit?usp=sharing'),
                child: Text(
                  t.drawer_privacyPolicy,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "•",
                  style: TextStyle(
                    color: accentColor,
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
                    color: accentColor,
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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Obsłuż błąd - np. pokaż snackbar, alert itp.
      debugPrint('Could not launch $url');
    }
  }

  Widget _buildListItem(BuildContext context, IconData icon, String text,
      Color color, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onPressed,
    );
  }

  Future<int> countAllNotesInWorkoutBox() async {
    final box =
        await Hive.openBox<Workout>('workout'); // Open the box for workouts
    int totalNotes = 0;

    // Loop through all workouts and count the notes
    for (var workout in box.values) {
      totalNotes +=
          workout.notes.length; // Add the number of notes for each workout
    }

    return totalNotes; // Return the total note count
  }
}
