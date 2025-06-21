import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../provider/workout_provider.dart';
import '../landing_page/tab_sector/tab_bottom_drawer/bottom_drawers/user_gym_bottom_drawer/user_gym_bottom_drawer.dart';

class UsersRow extends StatelessWidget {
  const UsersRow({super.key});

  void _openUserBottomDrawer(
      BuildContext context, ColorProvider colorProvider) {
    UserGymBottomDrawer.show(context, onlyUser: true, isFromWorkout: true);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final t = AppLocalizations.of(context)!;

    final selectedUsers = workoutProvider.selectedUsers;
    final currentUser = workoutProvider.currentUser;
    final showCheckbox = selectedUsers.length > 1;

    return Container(
      width: double.infinity,
      padding: selectedUsers.isEmpty
          ? const EdgeInsets.only(top: 12, left: 12, right: 12)
          : const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorProvider.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Nagłówek z ikoną zarządzania
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.workoutScreen_participants,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: colorProvider.accent,
                ),
              ),
              GestureDetector(
                onTap: () => _openUserBottomDrawer(context, colorProvider),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: colorProvider.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.edit_note_rounded,
                      color: colorProvider.accent, size: 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Lista użytkowników jako Column
          Column(
            children: List.generate(selectedUsers.length, (index) {
              final user = selectedUsers[index];
              final isSelected = user == currentUser;
              final isLast = index == selectedUsers.length - 1;

              return GestureDetector(
                onTap: () => workoutProvider.setCurrentUser(user.userID),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
                  child: _buildUserItem(
                    user.username,
                    isSelected: isSelected,
                    colorProvider: colorProvider,
                    showCheckbox: showCheckbox,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(
      String name, {
        required bool isSelected,
        required ColorProvider colorProvider,
        required bool showCheckbox,
      }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? colorProvider.accent.withOpacity(0.2)
            : colorProvider.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: colorProvider.accent,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: colorProvider.accent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          if (showCheckbox)
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? colorProvider.accent : colorProvider.accent.withValues(alpha: 0.6),
              size: 24,
            ),
        ],
      ),
    );
  }
}
