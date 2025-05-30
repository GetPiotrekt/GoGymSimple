import 'package:GoGymSimple/data/data_tab_sector/exercise_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/data_tab_sector/gym_db.dart';
import '../../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../provider/color_provider.dart';
import '../../../../provider/selected_options_provider.dart';
import '../../../../util/bottom_sheet.dart';
import '../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../util/dialog/text_input_dialog.dart';
import '../../../l10n/app_localizations.dart';
import 'add_exercise.dart';
import 'add_workout_plan.dart';

class TabBottomDrawer {
  final ColorProvider colorProvider;

  TabBottomDrawer({required this.colorProvider});

  void showTabBottomDrawer(BuildContext context, String title) {
    final t = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final selectedOptionsProvider = Provider.of<SelectedOptionsProvider>(context);
            List<int> selectedOptions = selectedOptionsProvider.getSelectedOptions(title);

            List<Map<String, dynamic>> options = _getOptions(title);

            return BottomSheetTemplate(
              onPressed: () => Navigator.pop(context),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        t.tabBottomDrawer_showOnly,
                        style: TextStyle(
                          fontSize: 22,
                          color: colorProvider.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: options.map((option) {
                        final bool isSelected = selectedOptions.contains(option['id']);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorProvider.accent.withOpacity(0.3)
                                  : colorProvider.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GestureDetector(
                              onLongPress: () {
                                if (title == 'Workout plan') {
                                  _openEditWorkoutPlan(context, option['id']);
                                } else {
                                  showDeleteConfirmationDialog(context, title, option['id']);
                                }
                              },
                              child: ListTile(
                                title: Text(option['name'], style: TextStyle(color: colorProvider.accent)),
                                trailing: Icon(
                                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                                  color: colorProvider.accent,
                                ),
                                onTap: () {
                                  selectedOptionsProvider.toggleOption(title, option['id']);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorProvider.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.add, color: colorProvider.accent),
                          title: Text(
                            _getAddNewTitle(t, title),
                            style: TextStyle(color: colorProvider.accent),
                          ),
                          onTap: () {
                            if (title == 'Exercise') {
                              AddExerciseDialog.showExerciseInputDialog(context);
                            } else {
                              _showAddNewItemDialog(context, title);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> _getOptions(String title) {
    if (title == 'Gym') {
      return GymBox.getAllGyms().map((gym) => {'id': gym.gymID, 'name': gym.name}).toList();
    } else if (title == 'User') {
      return UserBox.getAllUsers().map((user) => {'id': user.userID, 'name': user.username}).toList();
    } else if (title == 'Exercise') {
      return ExerciseBox.getAllExercises().map((exercise) => {'id': exercise.exerciseID, 'name': exercise.exerciseName}).toList();
    } else if (title == 'Workout plan') {
      return ListExerciseBox.getAllExerciseLists()
          .map((plan) => {'id': plan.listExerciseID, 'name': plan.exerciseListName})
          .toList();
    } else {
      return [];
    }
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context, String title, int selectedOptionId) async {
    final confirmed = await DeleteConfirmationDialog.show(context);
    if (confirmed == true) {
      _deleteItem(title, selectedOptionId, context);
    }
  }

  void _deleteItem(String title, int id, BuildContext context) {
    if (title == 'Gym') {
      GymBox.deleteGym(id);
    } else if (title == 'User') {
      UserBox.deleteUser(id);
    } else if (title == 'Workout plan') {
      ListExerciseBox.deleteExerciseListByID(id);
    }

    Navigator.pop(context);
  }

  void _showAddNewItemDialog(BuildContext context, String title) async {
    final t = AppLocalizations.of(context)!;

    if (title == 'Workout plan') {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddWorkoutPlan()),
      );
      return;
    }

    String? newItemName = await TextInputDialog.showTextInputDialog(
      context: context,
      title: _getAddNewTitle(t, title),
      labelText: _getEnterNameLabel(t, title),
    );

    if (newItemName != null && newItemName.isNotEmpty) {
      if (title == 'Gym') {
        await GymBox.addGym(newItemName);
      } else if (title == 'User') {
        await UserBox.addUser(newItemName);
      }

      Navigator.pop(context);
    }
  }

  void _openEditWorkoutPlan(BuildContext context, int planId) {
    final plan = ListExerciseBox.getExerciseListByID(planId);
    if (plan == null) return;

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkoutPlan(
          initialPlanName: plan.exerciseListName,
          initialExercises: plan.exerciseIDs,
        ),
      ),
    );
  }

  String _getAddNewTitle(AppLocalizations t, String title) {
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

  String _getEnterNameLabel(AppLocalizations t, String title) {
    switch (title) {
      case 'Gym':
        return t.tabBottomDrawer_enterGymName;
      case 'User':
        return t.tabBottomDrawer_enterUserName;
      case 'Workout plan':
        return t.tabBottomDrawer_enterWorkoutPlanName;
      default:
        return '';
    }
  }
}
