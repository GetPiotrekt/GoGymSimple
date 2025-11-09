// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../data/data_tab_sector/gym_db.dart';
// import '../../../../data/data_tab_sector/user_data/user_db.dart';
// import '../../../../data/data_tab_sector/exercise_db.dart';
// import '../../../../data/workout_db.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../../../provider/color_provider.dart';
// import '../../../../util/bottom_sheet/bottom_sheet.dart';
// import '../../../../util/button_icon.dart';
// import '../../../../util/custom_dropdown.dart';
// import '../../../../util/snackbar_helper.dart';
// import '../../../../provider/selected_options_provider.dart'; // Import the provider
//
// class AddUserAndGym {
//   final int exerciseID;
//
//   AddUserAndGym(this.exerciseID);
//
//   void open(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Consumer<ColorProvider>(
//         builder: (context, colorProvider, _) => BottomSheetTemplate(
//           child: _buildAddContent(context, colorProvider),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAddContent(BuildContext context, ColorProvider colorProvider) {
//     List<int> userIds = UserBox.getAllUserIDs();
//     List<int> gymIds = GymBox.getAllGymIDs();
//     Exercise? exercise = ExerciseBox.getExercisebyID(exerciseID);
//
//     var selectedOptionsProvider = Provider.of<SelectedOptionsProvider>(context);
//     int? selectedUserId = selectedOptionsProvider.selectedOptionsUser.isNotEmpty
//         ? selectedOptionsProvider.selectedOptionsUser.first
//         : null;
//     int? selectedGymId = selectedOptionsProvider.selectedOptionsGym.isNotEmpty
//         ? selectedOptionsProvider.selectedOptionsGym.first
//         : null;
//
//     final t = AppLocalizations.of(context)!;
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         bool isButtonEnabled = selectedUserId != null && selectedGymId != null;
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//               child: FittedBox(
//                 child: Text(
//                   t.addUserAndGym_title(exercise?.exerciseName ?? t.unknownExercise),
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: colorProvider.accent,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<int>(
//               decoration: CustomDropdown.dropdownInputDecoration(colorProvider),
//               dropdownColor: colorProvider.secondary,
//               value: selectedUserId,
//               hint: Text(t.addUserAndGym_selectUser, style: CustomDropdown.hintTextStyle(colorProvider)),
//               items: userIds.map((id) {
//                 return DropdownMenuItem<int>(
//                   value: id,
//                   child: Row(
//                     children: [
//                       Icon(Icons.arrow_right_outlined, color: colorProvider.accent),
//                       const SizedBox(width: 10),
//                       Text(_getUserNameById(id) ?? "user", style: CustomDropdown.dropdownItemStyle(colorProvider)),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedUserId = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<int>(
//               decoration: CustomDropdown.dropdownInputDecoration(colorProvider),
//               dropdownColor: colorProvider.secondary,
//               value: selectedGymId,
//               hint: Text(t.addUserAndGym_selectGym, style: CustomDropdown.hintTextStyle(colorProvider)),
//               items: gymIds.map((id) {
//                 return DropdownMenuItem<int>(
//                   value: id,
//                   child: Row(
//                     children: [
//                       Icon(Icons.arrow_right_outlined, color: colorProvider.accent),
//                       const SizedBox(width: 10),
//                       Text(_getGymNameById(id) ?? "gym", style: CustomDropdown.dropdownItemStyle(colorProvider)),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedGymId = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ButtonIcon(
//                 onPressed: isButtonEnabled
//                     ? () async {
//                   bool workoutExists = await _checkExistingWorkout(selectedUserId!, selectedGymId!);
//                   if (workoutExists) {
//                     SnackbarHelper.showSnackbar(context, t.addUserAndGym_workoutExists);
//                     Navigator.pop(context);
//                   } else {
//                     await WorkoutBox.addWorkout(
//                       selectedGymId!,
//                       selectedUserId!,
//                       exerciseID,
//                       '',
//                       '',
//                     );
//                     Navigator.pop(context);
//                   }
//                 }
//                     : () {},
//                 iconData: Icons.check,
//                 labelText: t.addUserAndGym_confirmSelection,
//                 backgroundColor: colorProvider.accent.withOpacity(0.1),
//                 isEnabled: isButtonEnabled,
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//       },
//     );
//   }
//
//
//   String? _getGymNameById(int id) {
//     return GymBox.getGym(id)?.name;
//   }
//
//   String? _getUserNameById(int id) {
//     return UserBox.getUserByID(id)?.username;
//   }
//
//   // Function to check if a workout already exists for the same user and gym
//   Future<bool> _checkExistingWorkout(int userId, int gymId) async {
//     List<Workout> workouts = WorkoutBox.getAllWorkouts();
//     for (var workout in workouts) {
//       if (workout.userID == userId && workout.gymID == gymId && workout.exerciseID == exerciseID) {
//         return true; // Workout already exists for the same user, gym, and exercise
//       }
//     }
//     return false; // No existing workout found for this combination
//   }
// }
