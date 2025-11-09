import '../../data/colors_db.dart';
import '../../data/config_db.dart';
import '../../data/data_tab_sector/gym_db.dart';
import '../../data/data_tab_sector/list_exercise_db.dart';
import '../../data/data_tab_sector/exercise_db.dart';
import '../../data/data_tab_sector/user_data/user_db.dart';
import '../../data/data_tab_sector/user_data/user_measurement_db.dart';
import '../../data/data_tab_sector/user_data/user_weight_db.dart';
import '../../data/notification/notification_db.dart';
import '../../data/workout/quick_text_db.dart';
import '../../data/workout/session_data/session_data_db.dart';
import '../../data/workout/session_data/workout_note_db.dart';
import '../../data/workout/workout_db.dart';
import '../../data/workout/training_session_db.dart'; // ✅ dodany import
import '../../main/theme/app_colors.dart';

class AppInitializer {
  static Future<void> initialize(Function(int) updateProgress) async {
    int step = 0;

    Future<void> safeInit(Future<void> Function() fn) async {
      try {
        await fn();
        updateProgress(++step);
      } catch (e) {
        updateProgress(++step); // nadal idź do przodu, ale loguj
        print('❌ Init step $step failed: $e');
      }
    }

    await safeInit(() => ColorCombinationBox.initBox());
    await safeInit(() => ConfigBox.initBox());
    await safeInit(() => AppColors.init());
    await safeInit(() => GymBox.initBox());
    await safeInit(() => ExerciseBox.initBox());
    await safeInit(() => ListExerciseBox.initBox());
    await safeInit(() async {
      await UserBox.initBox();
      await WorkoutBox.initBox();
    });
    await safeInit(() async {
      await UserWeightBox.initBox();
      await UserMeasurementBox.initBox();
    });
    await safeInit(() => AppNotificationBox.initBox()); // 10
    await safeInit(() => SessionDataBox.initBox()); // 11
    await safeInit(() => WorkoutNoteBox.initBox()); // 12
    await safeInit(() => QuickTextBox.initBox()); // 13
    await safeInit(() => TrainingSessionBox.initBox()); // ✅ Inicjalizacja TrainingSessionBox (14)

    // Migracja treningów do sesji treningowych
/*    await safeInit(() async {
      final migrated = ConfigBox.getConfig('migration_v2_completed'); // zmień na migration_v2
      if (migrated != 'true') {
        await TrainingSessionBox.migrateWorkoutsToSession();
        await ConfigBox.updateConfig('migration_v2_completed', 'true');
        print('✅ Migracja sesji treningowych zakończona.');
      } else {
        print('➡️ Migracja sesji treningowych już wcześniej wykonana, pomijam.');
      }
    });*/
  }
}
