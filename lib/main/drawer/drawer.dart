import 'package:GoGymSimple/main/drawer/settings/language_screen.dart';
import 'package:GoGymSimple/main/drawer/support/share_app.dart';
import 'package:GoGymSimple/main/drawer/support/watch_ad/watch_ad.dart';
import 'package:GoGymSimple/main/drawer/tools/calculator/calculator_bmr/calculator_bmr.dart';
import 'package:GoGymSimple/main/drawer/tools/time/stopwatch.dart';
import 'package:GoGymSimple/main/drawer/tools/tracker/measurement_tracker/measurement_tracker.dart';
import 'package:GoGymSimple/main/drawer/tools/tracker/weight_tracker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data_tab_sector/user_data/user_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import 'custom_drawer_helper.dart';
import 'settings/customize_app/customize_app.dart';
import 'settings/notification_screen/notification_screen.dart';
import 'support/donate/donate.dart';
import 'tools/calculator/1rm_calculator/calculator_1rm.dart';
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
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomDrawerHelper.buildHeader(user, colorProvider, accentColor),
                        CustomDrawerHelper.buildSection(
                          t.drawer_tools_section,
                          [
                            CustomDrawerHelper.buildDropdownSection(
                              context,
                              t.drawer_calculators_section,
                              [
                                _buildListItem(
                                  context,
                                  Icons.looks_one_rounded,
                                  t.drawer_oneRepMax,
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
                                  t.drawer_bmr,
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
                                  t.drawer_platesOnBarbell,
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
                            CustomDrawerHelper.buildDropdownSection(
                              context,
                              t.drawer_time_section,
                              [
                                _buildListItem(
                                  context,
                                  Icons.timer_outlined,
                                  t.drawer_stopwatch,
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
                            CustomDrawerHelper.buildDropdownSection(
                              context,
                              t.drawer_trackers_section,
                              [
                                _buildListItem(
                                  context,
                                  Icons.timeline,
                                  t.drawer_weightTracker,
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
                                  t.drawer_measurementTracker,
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
                        CustomDrawerHelper.buildSection(
                          t.drawer_settings_section,
                          [
                            _buildListItem(
                              context,
                              Icons.edit_note_rounded,
                              t.drawer_customizeApp,
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
                              t.drawer_appLanguage,
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
                              t.drawer_notificationSettings,
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
                        CustomDrawerHelper.buildSection(
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
                            if (DateTime.now().isAfter(DateTime(2025, 8, 12)))
                              ...[
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
                            ],
                            _buildListItem(
                              context,
                              Icons.thumb_up_alt,
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
                      ],
                    ),
                  ),
                ),
                CustomDrawerHelper.buildFooter(context, colorProvider),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<User?> _getUser() async {
    await UserBox.openBox();
    return UserBox.getUserByID(1);
  }

  Widget _buildListItem(BuildContext context, IconData icon, String text,
      Color color, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onPressed,
    );
  }
}
