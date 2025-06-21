import 'package:GoGymSimple/data/data_tab_sector/list_exercise_db.dart';
import 'package:flutter/material.dart';
import '../data/data_tab_sector/exercise_db.dart';
import '../data/data_tab_sector/gym_db.dart';
import '../data/data_tab_sector/user_data/user_db.dart';
import '../data/workout/session_data/session_data_db.dart';
import '../data/workout/session_data/workout_note_db.dart';

class WorkoutProvider extends ChangeNotifier {
  bool _isStarted = false;
  Gym? _selectedGym;
  DateTime? _selectedDate;
  int? _currentUserId;
  List<int> _selectedUserIds = [];
  List<int> _selectedPlanIds = [];
  List<int> _selectedExerciseIds = [];
  List<Map<String, String>> gyms = [];
  String selectedGymId = '';

  // Map: [userId][exerciseId][note]
  final Map<int, Map<int, String>> _results = {};

  // === Getters ===
  bool get isStarted => _isStarted;
  Gym? get selectedGym => _selectedGym;
  DateTime? get selectedDate => _selectedDate;

  List<User> get selectedUsers =>
      _selectedUserIds.map((id) => UserBox.getUserByID(id)).whereType<User>().toList();

  User? get currentUser => _currentUserId != null ? UserBox.getUserByID(_currentUserId!) : null;

  List<ListExercise> get selectedPlans =>
      _selectedPlanIds.map((id) => ListExerciseBox.getExerciseListByID(id)).whereType<ListExercise>().toList();

  List<Exercise> get selectedExercises =>
      _selectedExerciseIds.map((id) => ExerciseBox.getExercisebyID(id)).whereType<Exercise>().toList();

  Map<int, Map<int, String>> get results => _results;

  // === Setters / Methods ===
  void startWorkout() {
    _isStarted = true;

    // Ustaw datę tylko, jeśli nie została wcześniej ustawiona
    _selectedDate ??= DateTime.now();

    final user = UserBox.getUserByID(1);
    if (user != null) {
      _selectedUserIds = [user.userID];
      _currentUserId = user.userID;
    }

    // Zapis do Hive
    final session = SessionData(
      selectedDate: _selectedDate!,
      selectedGymID: selectedGym!.gymID,
    );
    SessionDataBox.createOrUpdateSession(session);

    notifyListeners();
  }


  void restoreSessionFromData(SessionData session, List<WorkoutNote> notes) {
    selectedGymId = session.selectedGymID.toString();
    _selectedDate = DateTime.tryParse(session.selectedDate.toIso8601String()) ?? DateTime.now();
    _selectedExerciseIds = session.selectedExerciseIDs ?? [];
    _selectedPlanIds = session.selectedWorkoutPlanIDs ?? [];

    // Dodaj ćwiczenia z załadowanych planów
    for (final planId in _selectedPlanIds) {
      final plan = ListExerciseBox.getExerciseListByID(planId);
      if (plan != null) {
        _selectedExerciseIds.addAll(plan.exerciseIDs);
      }
    }

    // Usuń duplikaty
    _selectedExerciseIds = _selectedExerciseIds.toSet().toList();

    if (notes.isEmpty) {
// Jeśli nie znaleziono żadnych użytkowników — ustaw domyślnie pierwszego z bazy
      final firstUser = UserBox.getAllUsers().firstOrNull;
      if (firstUser != null) {
        _selectedUserIds = [firstUser.userID];
        _currentUserId = firstUser.userID;
      }
    } else {
      // Załaduj użytkowników z notatek
      _selectedUserIds = notes.map((note) => note.userID).toSet().toList();
      _currentUserId = _selectedUserIds.first;

      for (final note in notes) {
        _results[note.userID] ??= {};
        _results[note.userID]![note.exerciseID] = note.note;
      }
    }

    _isStarted = true;
    notifyListeners();
  }


  void loadGyms() {
    gyms = GymBox.getAllGyms()
        .map((gym) => {
      'id': gym.gymID.toString(),
      'name': gym.name,
    })
        .toList();

    if (gyms.isNotEmpty && selectedGymId.isEmpty) {
      selectedGymId = '';
    }

    notifyListeners();
  }

  void setSelectedGym(String gymId) {
    selectedGymId = gymId;

    // Znajdź obiekt Gym na podstawie gymId i ustaw go w _selectedGym
    final gym = GymBox.getAllGyms().firstWhere(
          (g) => g.gymID.toString() == gymId);

    _selectedGym = gym;
    SessionDataBox.updateGymID(_selectedGym!.gymID);

    notifyListeners();
  }

  void endWorkout() {
    _isStarted = false;
    _results.clear();
    _selectedUserIds.clear();
    _selectedExerciseIds.clear();
    _selectedPlanIds.clear();
    _currentUserId = null;
    _selectedGym = null;
    selectedGymId = '';
    _selectedDate = null;

    // Wyczyść sesję Hive
    SessionDataBox.deleteSession();
    WorkoutNoteBox.deleteAllNotes();

    notifyListeners();
  }

  void setGym(Gym gym) {
    _selectedGym = gym;
    selectedGymId = gym.gymID.toString();
    SessionDataBox.updateGymID(selectedGym!.gymID);
    notifyListeners();
  }


  void setDate(DateTime date) {
    _selectedDate = date;
    SessionDataBox.updateDate(date);
    notifyListeners();
  }

  void setUsers(List<int> userIds) {
    _selectedUserIds = userIds;
    if (!_selectedUserIds.contains(_currentUserId)) {
      _currentUserId = _selectedUserIds.isNotEmpty ? _selectedUserIds.first : null;
    }
    notifyListeners();
  }

  void setCurrentUser(int userId) {
    if (_selectedUserIds.contains(userId)) {
      _currentUserId = userId;
      notifyListeners();
    }
  }

  Exercise? getExerciseNameById(int id) {
    return ExerciseBox.getExercisebyID(id);
  }

  void addExerciseResult({
    required int userId,
    required int exerciseId,
    required String result,
  }) {
    _results[userId] ??= {};
    _results[userId]![exerciseId] = result;

    // Zapis do Hive (WorkoutNoteBox)
    final existingNote = WorkoutNoteBox.getNote(userId, exerciseId);
    if (existingNote != null) {
      // Jeśli notatka już istnieje, aktualizujemy ją
      WorkoutNoteBox.updateNote(userId, exerciseId, result);
    } else {
      // Jeśli nie istnieje, dodajemy nową
      WorkoutNoteBox.addNote(userId, exerciseId, result);
    }
    notifyListeners();
  }


  String? getExerciseResult(int userId, int exerciseId) {
    return _results[userId]?[exerciseId];
  }

  List<int> getSelectedOptions(String title) {
    switch (title) {
      case 'User':
        return _selectedUserIds;
      case 'Workout plan':
        return _selectedPlanIds;
      case 'Exercise':
        return _selectedExerciseIds;
      default:
        return [];
    }
  }

  void toggleOption(String title, int id) async {
    switch (title) {
      case 'User':
        if (_selectedUserIds.contains(id)) {
          _selectedUserIds.remove(id);
          if (_currentUserId == id) {
            _currentUserId = _selectedUserIds.isNotEmpty ? _selectedUserIds.first : null;
          }
        } else {
          _selectedUserIds.add(id);
          _currentUserId ??= id;
        }
        break;

      case 'Workout plan':
        if (_selectedPlanIds.contains(id)) {
          _selectedPlanIds.remove(id);
          await SessionDataBox.removeWorkoutPlanID(id);
        } else {
          _selectedPlanIds.add(id);
          await SessionDataBox.addWorkoutPlanID(id);
        }
        break;

      case 'Exercise':
        if (_selectedExerciseIds.contains(id)) {
          _selectedExerciseIds.remove(id);
          await SessionDataBox.removeExerciseID(id);
        } else {
          _selectedExerciseIds.add(id);
          await SessionDataBox.addExerciseID(id);
        }
        break;

      default:
        break;
    }

    notifyListeners();
  }


  List<int> _getOptionListByCategory(String category) {
    switch (category) {
      case 'User':
        return _selectedUserIds;
      case 'Workout plan':
        return _selectedPlanIds;
      case 'Exercise':
        return _selectedExerciseIds;
      default:
        return [];
    }
  }

  void setOptionChecked(String category, int id, bool isSelected) {
    final list = _getOptionListByCategory(category);
    if (isSelected) {
      if (!list.contains(id)) {
        list.add(id);
      }
    } else {
      list.remove(id);
    }
    notifyListeners();
  }

  Future<void> loadFromSessionData() async {
    final session = SessionDataBox.getSession();
    if (session != null) {
      _isStarted = true;
      _selectedDate = session.selectedDate;
      selectedGymId = session.selectedGymID.toString();
      _selectedGym = session.selectedGymID as Gym?;
      _currentUserId = _selectedUserIds.isNotEmpty ? _selectedUserIds.first : 1;
      _selectedExerciseIds = session.selectedExerciseIDs!;
      _selectedPlanIds = session.selectedWorkoutPlanIDs ?? [];
      notifyListeners();
    }
  }
}
