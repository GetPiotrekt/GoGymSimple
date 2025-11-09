import 'package:GoGymSimple/main/welcome_screen/welcome_exercise_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/config_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../provider/settings_provider.dart';
import 'welcome_end.dart';
import 'welcome_gym_location_step.dart';
import 'welcome_intro_steps.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  String _selectedLanguage = 'en';
  late final TextEditingController _usernameController;
  List<TextEditingController> _gymControllers = [];
  List<TextEditingController> get gymControllers => _gymControllers;
  late TextEditingController _newExerciseController;
  bool _isHomeSelected = false;
  bool isGymSelected = false;
  int _currentPage = 0;
  String _enteredUsername = '';
  bool get isHomeSelected => _isHomeSelected;
  final Set<String> _selectedExercises = {};

  void _onLanguageChanged(String lang) {
    setState(() {
      _selectedLanguage = lang;
    });
  }

  void onAddGymField() {
    setState(() {
      _gymControllers.add(TextEditingController());
    });
  }

  void onHomeToggle(bool isSelected) {
    setState(() {
      _isHomeSelected = isSelected;
    });
  }
  
  void onGymToggle(bool selected) {
    setState(() {
      isGymSelected = selected;
      if (!selected) {
        gymControllers.clear();
      } else if (gymControllers.isEmpty) {
        gymControllers.add(TextEditingController());
      }
    });
  }

  void _onResetSelectedExercises() {
    setState(() {
      _selectedExercises.clear();
    });
  }
  
  void onNext() {
    _nextPage();
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _gymControllers = [];
    _newExerciseController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _usernameController.dispose();
    for (var c in _gymControllers) {
      c.dispose();
    }
    _newExerciseController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      await ConfigBox.updateConfig('welcome_screen', '1');

      if (!mounted) return; // Sprawdź, czy widget jest wciąż aktywny

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeEnd()),
      );
    }
  }

  // Lista ćwiczeń przechowująca klucze tłumaczeń zamiast surowych tekstów
  final List<String> _exerciseKeys = [
    'welcomeScreen_exercise_benchPress',
    'welcomeScreen_exercise_squats',
    'welcomeScreen_exercise_deadlift',
    'welcomeScreen_exercise_pullUps',
    'welcomeScreen_exercise_pushUps',
    'welcomeScreen_exercise_lunges',
  ];

  // Lista ćwiczeń do wyświetlenia już z tłumaczeniem
  List<String> getTranslatedExerciseList(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return _exerciseKeys.map((key) {
      switch (key) {
        case 'welcomeScreen_exercise_benchPress':
          return t.welcomeScreen_exercise_benchPress;
        case 'welcomeScreen_exercise_squats':
          return t.welcomeScreen_exercise_squats;
        case 'welcomeScreen_exercise_deadlift':
          return t.welcomeScreen_exercise_deadlift;
        case 'welcomeScreen_exercise_pullUps':
          return t.welcomeScreen_exercise_pullUps;
        case 'welcomeScreen_exercise_pushUps':
          return t.welcomeScreen_exercise_pushUps;
        case 'welcomeScreen_exercise_lunges':
          return t.welcomeScreen_exercise_lunges;
        default:
          return key; // fallback
      }
    }).toList();
  }

  void _addNewExercise() {
    final newExercise = _newExerciseController.text.trim();
    final translatedExercises = getTranslatedExerciseList(context);

    if (newExercise.isNotEmpty &&
        !translatedExercises.contains(newExercise)) {
      setState(() {
        // Dodajemy bez tłumaczenia, bo to nowy własny exercise (można rozbudować o tłumaczenia)
        _exerciseKeys.add(newExercise);
        _selectedExercises.add(newExercise);
        _newExerciseController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    // Tłumaczona lista ćwiczeń do przekazania dalej
    final translatedExerciseList = getTranslatedExerciseList(context);

    return Scaffold(
      backgroundColor: cp.primary,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              WelcomeIntroSteps.stepLogoIntro(
                cp: cp,
                context: context,
                onLanguageChanged: (value) {
                  // tutaj możesz dodać zmianę języka jeśli chcesz
                },
                selectedLanguage: _selectedLanguage,
                onNext: _nextPage,
              ),
              WelcomeIntroSteps.stepUsername(
                cp: cp,
                context: context,
                usernameController: _usernameController,
                enteredUsername: _enteredUsername,
                onChanged: (val) {
                  setState(() {
                    _enteredUsername = val;
                  });
                },
                onNext: _nextPage,
              ),
              WelcomeGymLocationStep.build(
                cp: cp, // Twój ColorProvider
                context: context,
                isHomeSelected: isHomeSelected,
                isGymSelected: isGymSelected,
                gymControllers: gymControllers,
                onAddGymField: onAddGymField,
                onHomeToggle: onHomeToggle,
                onGymToggle: onGymToggle,
                onNext: onNext,
              ),
              WelcomeExerciseStep.build(
                cp: cp,
                context: context,
                locale: Locale(_selectedLanguage),
                allExercises: translatedExerciseList,
                selectedExercises: _selectedExercises,
                onExerciseToggle: (exercise, selected) {
                  setState(() {
                    if (selected) {
                      _selectedExercises.add(exercise);
                    } else {
                      _selectedExercises.remove(exercise);
                    }
                  });
                },
                onNext: _nextPage,
                onAddExercise: _addNewExercise,
                newExerciseController: _newExerciseController,
                onResetSelectedExercises: _onResetSelectedExercises,
              ),
            ],
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: cp.secondary,
              tooltip: t.welcomeScreen_languageTooltip,
              child: Icon(Icons.g_translate, color: cp.accent),
              onPressed: () {
                _showLanguageSelector(context, cp, _selectedLanguage, _onLanguageChanged);
              },
            ),
          ),
        ],
      ),
    );
  }

  static void _showLanguageSelector(
      BuildContext context,
      ColorProvider cp,
      String selectedLanguage,
      void Function(String) onLanguageChanged,
      ) {
    final t = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: cp.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.welcomeScreen_chooseLanguage,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cp.accent),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.language, color: cp.accent),
                title: Text("English", style: TextStyle(color: cp.accent)),
                trailing: selectedLanguage == 'en' ? Icon(Icons.check, color: cp.accent) : null,
                onTap: () {
                  settingsProvider.changeLanguage('en');
                  onLanguageChanged('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.language, color: cp.accent),
                title: Text("Polski", style: TextStyle(color: cp.accent)),
                trailing: selectedLanguage == 'pl' ? Icon(Icons.check, color: cp.accent) : null,
                onTap: () {
                  settingsProvider.changeLanguage('pl');
                  onLanguageChanged('pl');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.language, color: cp.accent),
                title: Text("Nederlands", style: TextStyle(color: cp.accent)),
                trailing: selectedLanguage == 'nl' ? Icon(Icons.check, color: cp.accent) : null,
                onTap: () {
                  settingsProvider.changeLanguage('nl');
                  onLanguageChanged('nl');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
