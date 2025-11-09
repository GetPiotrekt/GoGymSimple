import '../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../l10n/app_localizations.dart';

class TabBottomDrawerService {
  static List<Map<String, dynamic>> getOptions(String title) {
    if (title == 'Gym') {
      return GymBox.getAllGyms()
          .map((gym) => {'id': gym.gymID, 'name': gym.name})
          .toList();
    } else if (title == 'User') {
      return UserBox.getAllUsers()
          .map((user) => {'id': user.userID, 'name': user.username})
          .toList();
    } else if (title == 'Exercise') {
      return ExerciseBox.getAllExercises()
          .map((exercise) => {'id': exercise.exerciseID, 'name': exercise.exerciseName})
          .toList();
    } else if (title == 'Workout plan') {
      return ListExerciseBox.getAllExerciseLists()
          .map((plan) => {'id': plan.listExerciseID, 'name': plan.exerciseListName})
          .toList();
    } else {
      return [];
    }
  }

  static void deleteItem(String title, int id) {
    if (title == 'Gym') {
      GymBox.deleteGym(id);
    } else if (title == 'User') {
      UserBox.deleteUser(id);
    } else if (title == 'Workout plan') {
      ListExerciseBox.deleteExerciseListByID(id);
    } else if (title == 'Exercise') {
      ExerciseBox.deleteExercise(id);
    }
  }

  static String getAddNewTitle(AppLocalizations t, String title) {
    switch (title) {
      case 'Gym':
        return t.tabBottomDrawer_addNewGym;
      case 'User':
        return t.tabBottomDrawer_addNewUser;
      case 'Exercise':
        return t.tabBottomDrawer_addNewExercise;
      case 'Workout plan':
        return t.tabBottomDrawer_addNewWorkoutPlan;
      default:
        return '';
    }
  }

  static String getEnterNameLabel(AppLocalizations t, String title) {
    switch (title) {
      case 'Gym':
        return t.tabBottomDrawer_enterGymName;
      case 'User':
        return t.tabBottomDrawer_enterUserName;
      case 'Exercise':
        return t.tabBottomDrawer_editLabel;
      case 'Workout plan':
        return t.tabBottomDrawer_enterWorkoutPlanName;
      default:
        return '';
    }
  }
}
