import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/data_tab_sector/list_exercise_db.dart';
import '../../../data/data_tab_sector/exercise_db.dart';
import '../../../l10n/app_localizations.dart';
import '../../../provider/color_provider.dart';
import '../../../util/button_icon.dart';
import '../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../util/input_form_field/input_decorations.dart';
import '../../../util/snackbar_helper.dart';
import 'add_exercise.dart';

class AddWorkoutPlan extends StatefulWidget {
  final String? initialPlanName;
  final List<int>? initialExercises;

  AddWorkoutPlan({this.initialPlanName, this.initialExercises});

  @override
  _AddWorkoutPlanState createState() => _AddWorkoutPlanState();
}

class _AddWorkoutPlanState extends State<AddWorkoutPlan> {
  late TextEditingController _nameController;
  List<int> _selectedExercises = [];
  late List<Exercise> _allExercises;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialPlanName ?? '');
    _selectedExercises = widget.initialExercises ?? [];
    _loadExercises();
  }

  void _loadExercises() {
    setState(() {
      _allExercises = ExerciseBox.getAllExercises();
    });
  }

  void _saveWorkoutPlan() {
    String planName = _nameController.text.trim();

    if (planName.isEmpty) {
      SnackbarHelper.showSnackbar(context, AppLocalizations.of(context)!.addWorkoutPlan_missingName);
      return;
    }

    if (_selectedExercises.isEmpty) {
      SnackbarHelper.showSnackbar(context, AppLocalizations.of(context)!.addWorkoutPlan_missingExercises);
      return;
    }

    final existingPlans = ListExerciseBox.getAllExerciseLists();

    final matchingPlans = existingPlans
        .where((plan) => plan.exerciseListName == widget.initialPlanName)
        .toList();

    final existingPlan = matchingPlans.isNotEmpty ? matchingPlans.first : null;

    if (existingPlan != null) {
      ListExerciseBox.updateExerciseList(
        existingPlan.listExerciseID,
        planName,
        _selectedExercises,
      );
    } else {
      ListExerciseBox.addExerciseList(planName, _selectedExercises);
    }
    Navigator.pop(context);
  }


  void _confirmDeleteDialog() async {
    final bool? shouldDelete = await DeleteConfirmationDialog.show(context);
    if (shouldDelete == true) {
      if (widget.initialPlanName != null) {
        final existingPlans = ListExerciseBox.getAllExerciseLists();
        final existingPlan = existingPlans.firstWhere(
            (plan) => plan.exerciseListName == widget.initialPlanName);

        ListExerciseBox.deleteExerciseListByID(existingPlan.listExerciseID);
            }
      Navigator.pop(context);
    }
  }

  void _showAddExerciseDialog() async {
    await AddExerciseDialog.showExerciseInputDialog(context);
    _loadExercises();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    // Determine if there are more exercises available for selection
    final availableExercises = _allExercises
        .where((exercise) => !_selectedExercises.contains(exercise.exerciseID))
        .toList();

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.addWorkoutPlan_title,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDeleteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddExerciseDialog,
          ),
        ],
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
                    const SizedBox(height: 4,),
                    TextField(
                      controller: _nameController,
                      decoration: CustomInputDecorations.buildInputDecoration(
                          context, t.addWorkoutPlan_planName,
                          isLabelVisible: true),
                      style: TextStyle(color: colorProvider.accent),
                    ),
                    const SizedBox(height: 16.0),
                    // Selected Exercises Section
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
                        ? Column(
                            children: _selectedExercises.map((exerciseId) {
                              final exercise = _allExercises.firstWhere(
                                  (e) => e.exerciseID == exerciseId);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedExercises
                                        .remove(exercise.exerciseID);
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
                                    leading: Image.asset(
                                    exercise.iconPath,
                                    width: 38,
                                    height: 38,
                                    color: colorProvider.accent,
                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                      'assets/icons/logo_bl.png',
                                      width: 38,
                                      height: 38,
                                      color: colorProvider.accent,
                                    ),
                                  ),
                                    title: Text(
                                      exercise.exerciseName,
                                      style: TextStyle(
                                          color: colorProvider.accent),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.remove_circle,
                                          color: colorProvider.accent),
                                      onPressed: () {
                                        setState(() {
                                          _selectedExercises
                                              .remove(exercise.exerciseID);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Center(
                          child: Text(
                              t.addWorkoutPlan_noExercises,
                              style: TextStyle(color: colorProvider.accent.withOpacity(0.7)),
                            ),
                        ),
                    Divider(
                      color: colorProvider.accent.withOpacity(0.5),
                      thickness: 1.0,
                      height: 32.0,
                    ),
                    // Available Exercises Section
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
                    // List of Exercises with Icons
                    availableExercises.isNotEmpty
                        ? ListView.builder(
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
                                    leading: Image.asset(
                                      exercise.iconPath,
                                      width: 38,
                                      height: 38,
                                      color: colorProvider.accent,
                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                        'assets/icons/logo_bl.png',
                                        width: 38,
                                        height: 38,
                                        color: colorProvider.accent,
                                      ),
                                    ),
                                    title: Text(
                                      exercise.exerciseName,
                                      style: TextStyle(
                                          color: colorProvider.accent),
                                    ),
                                    trailing: Icon(
                                      _selectedExercises
                                              .contains(exercise.exerciseID)
                                          ? Icons.check_circle
                                          : Icons.add_circle,
                                      color: colorProvider.accent,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: ButtonIcon(
                              onPressed: _showAddExerciseDialog,
                              showBorder: true,
                              iconData: Icons.add_circle,
                              labelText: t.addWorkoutPlan_addNewExercise,
                              backgroundColor: colorProvider.secondary,
                              textColor: colorProvider.accent.withOpacity(0.7),
                            ),
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
}
