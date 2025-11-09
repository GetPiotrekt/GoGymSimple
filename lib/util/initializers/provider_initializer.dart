import 'package:GoGymSimple/provider/ad_provider.dart';
import 'package:GoGymSimple/provider/quick_text_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../provider/color_provider.dart';
import '../../provider/exercise_provider.dart';
import '../../provider/landing_page_provider.dart';
import '../../provider/notification_provider.dart';
import '../../provider/selected_options_provider.dart';
import '../../provider/settings_provider.dart';
import '../../provider/time_provider.dart';
import '../../provider/workout_provider.dart';

List<SingleChildWidget> getAppProviders() {
  return [
    ChangeNotifierProvider(create: (_) => ColorProvider()),
    ChangeNotifierProvider(create: (_) => SelectedOptionsProvider()),
    ChangeNotifierProvider(create: (_) => LandingPageProvider()),
    ChangeNotifierProvider(create: (_) => ExerciseProvider()),
    ChangeNotifierProvider(create: (_) => TimeProvider()),
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => WorkoutProvider()),
    ChangeNotifierProvider(create: (_) => AdProvider()),
    ChangeNotifierProvider(create: (_) => QuickTextProvider()),
  ];
}
