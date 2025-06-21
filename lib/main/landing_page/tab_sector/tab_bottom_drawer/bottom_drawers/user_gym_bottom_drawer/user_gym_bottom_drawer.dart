import 'package:GoGymSimple/main/landing_page/tab_sector/tab_bottom_drawer/bottom_drawers/user_gym_bottom_drawer/user_gym_bottom_drawer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../provider/color_provider.dart';
import '../../../../../../provider/selected_options_provider.dart';
import '../../../../../../provider/workout_provider.dart';
import '../../../../../../util/bottom_sheet/bottom_sheet.dart';
import '../../../../../../util/bottom_sheet/edit_delete_bottom_sheet.dart';
import '../../../../../../util/button_icon.dart';
import '../../../../../../data/data_tab_sector/user_data/user_db.dart';
import '../../../../../../data/data_tab_sector/gym_db.dart';
import '../../../../../../util/dialog/delete_confirmation_dialog.dart';
import '../../../../../../util/dialog/text_input_dialog.dart';

class UserGymBottomDrawer extends StatelessWidget {
  final bool onlyUser;
  final bool onlyGym;
  final bool isFromWorkout;

  const UserGymBottomDrawer({
    super.key,
    this.onlyUser = false,
    this.onlyGym = false,
    this.isFromWorkout = false,
  });

  static void show(
      BuildContext context, {
        bool onlyUser = false,
        bool onlyGym = false,
        bool isFromWorkout = false,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UserGymBottomDrawer(
        onlyUser: onlyUser,
        onlyGym: onlyGym,
        isFromWorkout: isFromWorkout,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();
    final selectedOptionsProvider = context.watch<SelectedOptionsProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();

    return BottomSheetTemplate(
      onPressed: () => Navigator.pop(context),
      child: StatefulBuilder(builder: (context, setState) {
        List<Map<String, dynamic>> users = UserBox.getAllUsers()
            .map((user) => {'id': user.userID, 'name': user.username})
            .toList();

        List<Map<String, dynamic>> gyms = GymBox.getAllGyms()
            .map((gym) => {'id': gym.gymID, 'name': gym.name})
            .toList();

        void refresh() {
          users = UserBox.getAllUsers()
              .map((user) => {'id': user.userID, 'name': user.username})
              .toList();
          gyms = GymBox.getAllGyms()
              .map((gym) => {'id': gym.gymID, 'name': gym.name})
              .toList();
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!onlyGym)
                _buildSection(
                  context: context,
                  title: 'User',
                  colorProvider: colorProvider,
                  options: users,
                  selectedOptions: isFromWorkout
                      ? workoutProvider.getSelectedOptions('User')
                      : selectedOptionsProvider.getSelectedOptions('User'),
                  onToggle: (id) {
                    if (isFromWorkout) {
                      workoutProvider.toggleOption('User', id);
                    } else {
                      selectedOptionsProvider.toggleOption('User', id);
                    }
                  },
                  setState: () {
                    setState(() {
                      refresh();
                    });
                  },
                ),
              if (!onlyGym) const SizedBox(height: 6),
              if (!onlyUser)
                _buildSection(
                  context: context,
                  title: 'Gym',
                  colorProvider: colorProvider,
                  options: gyms,
                  selectedOptions: isFromWorkout
                      ? workoutProvider.getSelectedOptions('Gym')
                      : selectedOptionsProvider.getSelectedOptions('Gym'),
                  onToggle: (id) {
                    if (isFromWorkout) {
                      workoutProvider.toggleOption('Gym', id);
                    } else {
                      selectedOptionsProvider.toggleOption('Gym', id);
                    }
                  },
                  setState: () {
                    setState(() {
                      refresh();
                    });
                  },
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required ColorProvider colorProvider,
    required List<Map<String, dynamic>> options,
    required List<int> selectedOptions,
    required Function(int id) onToggle,
    required VoidCallback setState,
  }) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.tabBottomDrawer_showOnly,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorProvider.accent),
            ),
            ButtonIcon(
              onPressed: () async {
                final newItemName = await TextInputDialog.showTextInputDialog(
                  context: context,
                  title: title == 'User'
                      ? t.tabBottomDrawer_addNewUser
                      : t.tabBottomDrawer_addNewGym,
                  labelText: title == 'User'
                      ? t.tabBottomDrawer_enterUserName
                      : t.tabBottomDrawer_enterGymName,
                );
                if (newItemName != null && newItemName.isNotEmpty) {
                  if (title == 'User') {
                    await UserBox.addUser(newItemName);
                  } else {
                    await GymBox.addGym(newItemName);
                  }
                  setState();
                }
              },
              iconData: title == 'User'
                  ? Icons.person_add_alt
                  : Icons.fitness_center,
              labelText: title == 'User'
                  ? t.tabBottomDrawer_addNewUser
                  : t.tabBottomDrawer_addNewGym,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorProvider.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = selectedOptions.contains(option['id']);
              final isLockedUser = title == 'User' &&
                  isFromWorkout &&
                  isSelected &&
                  selectedOptions.length == 1 &&
                  selectedOptions.first == option['id'];

              final widget = title == 'User'
                  ? Stack(
                alignment: Alignment.topRight,
                children: [
                  UserAvatar(name: option['name'], isSelected: isSelected),
                  if (isLockedUser)
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.lock, size: 16, color: colorProvider.accent),
                    ),
                ],
              )
                  : GymCard(name: option['name'], isSelected: isSelected);

              return GestureDetector(
                onTap: () {
                  final id = option['id'];

                  if (title == 'User' && isFromWorkout) {
                    final isSelected = selectedOptions.contains(id);
                    if (isSelected && selectedOptions.length == 1) {
                      // Nie pozwól odznaczyć ostatniego użytkownika
                      return;
                    }
                  }

                  onToggle(id);
                  setState();
                },
                onLongPress: () async {
                  await EditDeleteBottomSheet.show(
                    context: context,
                    title: title,
                    initialName: option['name'],
                    id: option['id'],
                    onEdit: (newName) async {
                      if (title == 'User') {
                        final user = UserBox.getUserByID(option['id']);
                        if (user != null) {
                          user.username = newName;
                          await UserBox.box.put(user.userID, user);
                        }
                      } else {
                        final gym = GymBox.getGym(option['id']);
                        if (gym != null) {
                          gym.name = newName;
                          await GymBox.box.put(gym.gymID, gym);
                        }
                      }
                      setState();
                    },
                    onDelete: () async {
                      if (title == 'User') {
                        await UserBox.deleteUser(option['id']);
                      } else {
                        await GymBox.deleteGym(option['id']);
                      }
                      setState();
                    },
                  );
                },
                child: widget,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

}
