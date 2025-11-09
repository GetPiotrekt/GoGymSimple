import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../provider/workout_provider.dart';
import '../../../util/input_form_field/input_decorations.dart';
import '../../../util/snackbar_helper.dart';
import 'add_exercise.dart';

class AddWorkoutPlan extends StatefulWidget {
  final String? initialPlanName;
  final List<int>? initialExercises;

  const AddWorkoutPlan({super.key, this.initialPlanName, this.initialExercises});

  @override
  _AddWorkoutPlanState createState() => _AddWorkoutPlanState();
}

class _AddWorkoutPlanState extends State<AddWorkoutPlan> {
  late TextEditingController _nameController;
  final FocusNode _nameFocusNode = FocusNode();
  bool _isEditingName = false;
  List<int> _selectedExercises = [];
  late List<Exercise> _allExercises;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialPlanName ?? '');
    _selectedExercises = widget.initialExercises ?? [];
    _loadExercises();

    // Obsługa zmiany focusu pola nazwy
    _nameFocusNode.addListener(() {
      setState(() {
        _isEditingName = _nameFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _loadExercises() {
    setState(() {
      _allExercises = ExerciseBox.getAllExercises();
    });
  }

  void _saveWorkoutPlan() {
    String planName = _nameController.text.trim();

    if (planName.isEmpty) {
      SnackbarHelper.showSnackbar(
          context, AppLocalizations.of(context)!.addWorkoutPlan_missingName);
      return;
    }

    if (_selectedExercises.isEmpty) {
      SnackbarHelper.showSnackbar(
          context, AppLocalizations.of(context)!.addWorkoutPlan_missingExercises);
      return;
    }

    final existingPlans = ListExerciseBox.getAllExerciseLists();
    final matchingPlans = existingPlans
        .where((plan) => plan.exerciseListName == widget.initialPlanName)
        .toList();
    final existingPlan = matchingPlans.isNotEmpty ? matchingPlans.first : null;

    int updatedPlanId;

    if (existingPlan != null) {
      // aktualizacja
      ListExerciseBox.updateExerciseList(
        existingPlan.listExerciseID,
        planName,
        _selectedExercises,
      );
      updatedPlanId = existingPlan.listExerciseID;
    } else {
      // dodanie nowego planu
      updatedPlanId = ListExerciseBox.addExerciseList(planName, _selectedExercises) as int;
    }

    // 🔑 aktualizacja aktywnego treningu jeśli dotyczy
    final workoutProvider = context.read<WorkoutProvider>();
    if (workoutProvider.isStarted &&
        workoutProvider.getSelectedOptions('Workout plan').contains(updatedPlanId)) {
      workoutProvider.updateExercisesFromPlan(updatedPlanId, _selectedExercises);
    }

    Navigator.pop(context);
  }


  void _showAddExerciseDialog() async {
    await AddExerciseDialog.showExerciseInputDialog(context);
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    final availableExercises = _allExercises
        .where((exercise) => !_selectedExercises.contains(exercise.exerciseID))
        .toList();

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.addWorkoutPlan_title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            decoration: CustomInputDecorations.buildInputDecoration(
                              context,
                              t.addWorkoutPlan_planName,
                              isLabelVisible: true,
                            ),
                            style: TextStyle(color: colorProvider.accent),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: colorProvider.accent.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(
                              _isEditingName ? Icons.check : Icons.edit,
                              color: colorProvider.accent,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_isEditingName) {
                                  _nameFocusNode.unfocus();
                                } else {
                                  _nameFocusNode.requestFocus();
                                }
                                // _isEditingName będzie zmieniany automatycznie przez listener
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: colorProvider.accent.withOpacity(0.5),
                      thickness: 1.0,
                      height: 32.0,
                    ),
                    Center(
                      child: Text(
                        t.addWorkoutPlan_selectedExercises,
                        style: TextStyle(
                            color: colorProvider.accent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _selectedExercises.isNotEmpty
                        ? ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _selectedExercises.length,
                      buildDefaultDragHandles: false,
                      proxyDecorator: (child, index, animation) {
                        return Material(
                          color: colorProvider.accent.withOpacity(0.2),
                          child: child,
                        );
                      },
                      itemBuilder: (context, index) {
                        final exerciseId = _selectedExercises[index];
                        final exercise = _allExercises.cast<Exercise?>().firstWhere(
                              (e) => e?.exerciseID == exerciseId,
                          orElse: () => null,
                        );

                        if (exercise == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _selectedExercises.remove(exerciseId);
                            });
                          });
                          return SizedBox.shrink(key: ValueKey('empty_$exerciseId'));
                        }

                        return GestureDetector(
                          key: ValueKey(exercise.exerciseID),
                          onTap: () {
                            setState(() {
                              _selectedExercises.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                              colorProvider.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              leading: _buildExerciseIcon(exercise.iconPath, colorProvider.accent),
                              title: Text(
                                exercise.exerciseName,
                                style: TextStyle(
                                    color: colorProvider.accent),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle,
                                        color: colorProvider.accent),
                                    onPressed: () {
                                      setState(() {
                                        _selectedExercises
                                            .removeAt(index);
                                      });
                                    },
                                  ),
                                  ReorderableDragStartListener(
                                    index: index,
                                    child: Icon(Icons.menu,
                                        color: colorProvider.accent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) newIndex -= 1;
                          final item =
                          _selectedExercises.removeAt(oldIndex);
                          _selectedExercises.insert(newIndex, item);
                        });
                      },
                    )
                        : Center(
                      child: Text(
                        t.addWorkoutPlan_noExercises,
                        style: TextStyle(
                            color: colorProvider.accent.withOpacity(0.7)),
                      ),
                    ),
                    Divider(
                      color: colorProvider.accent.withOpacity(0.5),
                      thickness: 1.0,
                      height: 32.0,
                    ),
                    Center(
                      child: Text(
                        t.addWorkoutPlan_availableExercises,
                        style: TextStyle(
                            color: colorProvider.accent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: [
                        if (availableExercises.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: availableExercises.length,
                            itemBuilder: (context, index) {
                              final exercise = availableExercises[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedExercises
                                        .contains(exercise.exerciseID)) {
                                      _selectedExercises
                                          .remove(exercise.exerciseID);
                                    } else {
                                      _selectedExercises
                                          .add(exercise.exerciseID);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                    colorProvider.accent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: ListTile(
                                    leading: _buildExerciseIcon(exercise.iconPath, colorProvider.accent),
                                    title: Text(
                                      exercise.exerciseName,
                                      style: TextStyle(color: colorProvider.accent),
                                    ),
                                    trailing: Icon(
                                      _selectedExercises.contains(exercise.exerciseID)
                                          ? Icons.check_circle
                                          : Icons.add_circle,
                                      color: colorProvider.accent,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _showAddExerciseDialog,
                            icon: const Icon(Icons.add),
                            label: Text(t.addWorkoutPlan_addNewExercise),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              colorProvider.accent.withOpacity(0.1),
                              foregroundColor: colorProvider.accent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 86),
          ],
        ),
      ),
      floatingActionButton: _selectedExercises.isNotEmpty
          ? SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: FloatingActionButton.extended(
          onPressed: _saveWorkoutPlan,
          label: Text(t.addWorkoutPlan_save),
          backgroundColor: colorProvider.accent,
          foregroundColor: colorProvider.secondary,
          elevation: 0,
        ),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

// Funkcja pomocnicza do budowania ikony ćwiczenia
// (Helper function for building exercise icon)
  Widget _buildExerciseIcon(String? path, Color color) {
    if (path == null || path.trim().isEmpty) {
      // jeśli brak ścieżki → domyślna ikona
      return Image.asset(
        'assets/icons/logo_bl.png',
        width: 26,
        height: 26,
        color: color,
      );
    }

    // jeśli ścieżka istnieje → próbujemy wczytać
    return Image.asset(
      path,
      width: 26,
      height: 26,
      color: color,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/icons/logo_bl.png',
        width: 26,
        height: 26,
        color: color,
      ),
    );
  }
}
