import 'package:flutter/material.dart';

class SelectedOptionsProvider with ChangeNotifier {
  List<int> selectedOptionsGym = [];
  List<int> selectedOptionsUser = [];
  List<int> selectedOptionsWorkoutPlan = [];
  List<int> selectedOptionsExercise = [];

  String? selectedOptionSortExerciseView = 'aToZ';
  String? selectedOptionSortHistoryView = 'newest';

  String selectedViewMode = 'List';
  String searchQuery = '';

  List<int> get gym => selectedOptionsGym;
  List<int> get user => selectedOptionsUser;
  List<int> get workoutPlan => selectedOptionsWorkoutPlan;
  List<int> get exercise => selectedOptionsExercise;

  String? get sortExerciseView => selectedOptionSortExerciseView;
  String? get sortHistoryView => selectedOptionSortHistoryView;

  String get viewMode => selectedViewMode;

  void setSelectedOption(String title, dynamic value, {String? context}) {
    switch (title) {
      case 'Gym':
        if (!selectedOptionsGym.contains(value)) {
          selectedOptionsGym.add(value);
        }
        break;
      case 'User':
        if (!selectedOptionsUser.contains(value)) {
          selectedOptionsUser.add(value);
        }
        break;
      case 'Workout plan':
        if (!selectedOptionsWorkoutPlan.contains(value)) {
          selectedOptionsWorkoutPlan.add(value);
        }
        break;
      case 'Exercise':
        if (!selectedOptionsExercise.contains(value)) {
          selectedOptionsExercise.add(value);
        }
        break;
      case 'Sort':
        if (context == 'ExerciseView') {
          selectedOptionSortExerciseView = value?.toString();
        } else if (context == 'HistoryView') {
          selectedOptionSortHistoryView = value?.toString();
        }
        break;
      case 'ViewMode':
        selectedViewMode = value?.toString() ?? 'List';
        break;
    }
    notifyListeners();
  }

  void clearSelectedOption(String title, {String? context}) {
    switch (title) {
      case 'Gym':
        selectedOptionsGym.clear();
        break;
      case 'User':
        selectedOptionsUser.clear();
        break;
      case 'Workout plan':
        selectedOptionsWorkoutPlan.clear();
        break;
      case 'Exercise':
        selectedOptionsExercise.clear();
        break;
      case 'Sort':
        if (context == 'ExerciseView') {
          selectedOptionSortExerciseView = 'aToZ';
        } else if (context == 'HistoryView') {
          selectedOptionSortHistoryView = 'newest';
        }
        break;
      case 'ViewMode':
        selectedViewMode = 'List';
        break;
      case 'Search':
        searchQuery = '';
        break;
    }
    notifyListeners();
  }

  void removeSelectedOption(String title, dynamic value) {
    switch (title) {
      case 'Gym':
        selectedOptionsGym.remove(value);
        break;
      case 'User':
        selectedOptionsUser.remove(value);
        break;
      case 'Workout plan':
        selectedOptionsWorkoutPlan.remove(value);
        break;
      case 'Exercise':
        selectedOptionsExercise.remove(value);
        break;
    }
    notifyListeners();
  }

  void toggleOption(String title, dynamic value) {
    switch (title) {
      case 'Gym':
        if (selectedOptionsGym.contains(value)) {
          selectedOptionsGym.remove(value);
        } else {
          selectedOptionsGym.add(value);
        }
        break;
      case 'User':
        if (selectedOptionsUser.contains(value)) {
          selectedOptionsUser.remove(value);
        } else {
          selectedOptionsUser.add(value);
        }
        break;
      case 'Workout plan':
        if (selectedOptionsWorkoutPlan.contains(value)) {
          selectedOptionsWorkoutPlan.remove(value);
        } else {
          selectedOptionsWorkoutPlan.add(value);
        }
        break;
      case 'Exercise':
        if (selectedOptionsExercise.contains(value)) {
          selectedOptionsExercise.remove(value);
        } else {
          selectedOptionsExercise.add(value);
        }
        break;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  List<int> getSelectedOptions(String title) {
    switch (title) {
      case 'Gym':
        return selectedOptionsGym;
      case 'User':
        return selectedOptionsUser;
      case 'Workout plan':
        return selectedOptionsWorkoutPlan;
      case 'Exercise':
        return selectedOptionsExercise;
      default:
        return [];
    }
  }

  List<int> _getSelectedListByCategory(String category) {
    switch (category) {
      case 'Gym':
        return selectedOptionsGym;
      case 'User':
        return selectedOptionsUser;
      case 'Workout plan':
        return selectedOptionsWorkoutPlan;
      case 'Exercise':
        return selectedOptionsExercise;
      default:
        return [];
    }
  }

  void setOptionChecked(String category, int id, bool isSelected) {
    final list = _getSelectedListByCategory(category);
    if (isSelected) {
      if (!list.contains(id)) {
        list.add(id);
      }
    } else {
      list.remove(id);
    }
    notifyListeners();
  }
}
