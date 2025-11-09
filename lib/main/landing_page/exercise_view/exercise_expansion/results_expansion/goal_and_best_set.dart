import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../data/workout/workout_db.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../provider/settings_provider.dart';

class GoalAndBestSet extends StatefulWidget {
  final Workout workout;

  const GoalAndBestSet({
    required this.workout,
    super.key,
  });

  @override
  _GoalAndBestSetState createState() => _GoalAndBestSetState();
}

class _GoalAndBestSetState extends State<GoalAndBestSet> {
  late TextEditingController _goalController;
  late TextEditingController _bestSetController;

  bool _isEditingGoal = false;
  bool _isEditingBestSet = false;

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController(
      text: widget.workout.getQuickValue('goal') ?? '',
    );
    _bestSetController = TextEditingController(
      text: widget.workout.getQuickValue('bestSet') ?? '',
    );
  }

  @override
  void dispose() {
    _goalController.dispose();
    _bestSetController.dispose();
    super.dispose();
  }

  Future<void> _saveQuickValue() async {
    final goal = _goalController.text.trim();
    final bestSet = _bestSetController.text.trim();

    widget.workout.setQuickValue('goal', goal);
    widget.workout.setQuickValue('bestSet', bestSet);

    await WorkoutBox.updateQuickValue(
      widget.workout.workoutID,
      jsonEncode(widget.workout.quickValueMap),
    );
    FocusScope.of(context).unfocus();

    setState(() {
      _isEditingGoal = false;
      _isEditingBestSet = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final t = AppLocalizations.of(context)!;

    final units = settingsProvider.getUnits;
    final unitsLabel = units == 'metric' ? 'kg' : 'lbs';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goal
          Expanded(
            child: _buildEditableField(
              icon: Icons.flag,
              title: t.goalAndBest_goal_title,
              hint: t.editDeleteBottomSheet_edit,
              controller: _goalController,
              isEditing: _isEditingGoal,
              onTap: () => setState(() => _isEditingGoal = true),
              onSave: _saveQuickValue,
              showSaveButton: _isEditingGoal,
              colorProvider: colorProvider,
              context: context,
            ),
          ),
          const SizedBox(width: 16),

          // Best Set
          Expanded(
            child: _buildEditableField(
              icon: Icons.star,
              title: t.goalAndBest_bestSet_title,
              hint: t.editDeleteBottomSheet_edit,
              controller: _bestSetController,
              isEditing: _isEditingBestSet,
              onTap: () => setState(() => _isEditingBestSet = true),
              onSave: _saveQuickValue,
              showSaveButton: _isEditingBestSet,
              colorProvider: colorProvider,
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String title,
    required String hint,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onTap,
    required VoidCallback onSave,
    required bool showSaveButton,
    required ColorProvider colorProvider,
    required BuildContext context,
    required IconData icon, // 🆕 Nowy parametr
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: colorProvider.accent), // 🆕 Ikona
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorProvider.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: colorProvider.accent.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.5,
              color: colorProvider.accent.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                minLines: 1,
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: colorProvider.accent.withOpacity(0.4),
                  ),
                  border: InputBorder.none,
                  counterText: '',
                ),
                style: TextStyle(
                  color: colorProvider.accent,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                onTap: onTap,
                onSubmitted: (_) => onSave(),
              ),
              if (showSaveButton)
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton.icon(
                    onPressed: onSave,
                    icon: Icon(Icons.check, color: colorProvider.accent),
                    label: Text(
                      AppLocalizations.of(context)!.addPattern_save,
                      style: TextStyle(color: colorProvider.accent),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      backgroundColor: colorProvider.accent.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
