// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get unknownExercise => 'Unknown Exercise';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_elementVisibility => 'Show stopwatch on home screen';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_english => 'English';

  @override
  String get settings_polish => 'Polish';

  @override
  String get settings_spanish_spain => 'Spanish – Spain';

  @override
  String get settings_spanish_colombia => 'Spanish – Colombia';

  @override
  String get settings_german => 'German';

  @override
  String get settings_dutch => 'Dutch';

  @override
  String get settings_portuguese => 'Portuguese';

  @override
  String get settings_italian => 'Italian';

  @override
  String get settings_otherLanguages => 'Other languages (coming soon)';

  @override
  String get settings_availableLanguages => 'Available languages';

  @override
  String get settings_units => 'Units';

  @override
  String get settings_metric => 'Meter/Kilogram';

  @override
  String get settings_imperial => 'Inch/Pound';

  @override
  String get daysAgo_noData => 'No data';

  @override
  String get daysAgo_lessThanOneHour => '<1 hour ago';

  @override
  String get daysAgo_oneHourAgo => '1 hour ago';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => '1 day ago';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => '1 week ago';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks ago',
      one: '1 week ago',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'So long time ago';

  @override
  String get confirmationDialog_title => 'Confirmation';

  @override
  String get deleteConfirmationDialog_title => 'Delete confirmation';

  @override
  String get dialog_content => 'Are you sure you want to proceed?';

  @override
  String get dialog_cancel => 'Cancel';

  @override
  String get dialog_confirm => 'Confirm';

  @override
  String get dialog_save => 'Save';

  @override
  String get inputFormField_labelText => 'Enter value';

  @override
  String get inputFormField_invalidValue =>
      'Invalid value. Please enter a number.';

  @override
  String get addPattern_title => 'Add New Color Palette';

  @override
  String get addPattern_iconsText =>
      'This is how icons and text will look in this color';

  @override
  String get addPattern_textExample =>
      'And this is how the text will look in a different shade';

  @override
  String get addPattern_backgroundColor => 'Background Color';

  @override
  String get addPattern_sectionColor => 'Section Color';

  @override
  String get addPattern_textIconsColor => 'Text and Icon Color';

  @override
  String get addPattern_save => 'Save';

  @override
  String get addPattern_moreColors => 'More colors';

  @override
  String get customizeApp_availableColorPalettes => 'Available themes';

  @override
  String get customizeApp_currentTheme => 'Currently Set Theme';

  @override
  String get customizeApp_setTheme => 'Set Theme';

  @override
  String get customizeApp_deleteTheme => 'Delete Theme';

  @override
  String get customizeApp_confirmDelete =>
      'Are you sure you want to delete this theme?';

  @override
  String get customizeApp_applyTheme => 'Apply Theme';

  @override
  String get savePalette_saveTheme => 'Save Theme';

  @override
  String savePalette_themeSaved(Object name) {
    return 'The theme \"$name\" has been saved. Go back to the previous screen to apply it.';
  }

  @override
  String get savePalette_themeName => 'Theme Name';

  @override
  String get fullColorPicker_chooseColor => 'Choose color';

  @override
  String get fullColorPicker_save => 'Save';

  @override
  String get applyNewTheme => 'New theme applied';

  @override
  String get calculator1RM_title => '1RM Calculator';

  @override
  String get calculator1RM_infoText =>
      'Fill in the fields below to see the 1RM result';

  @override
  String get calculator1RM_weightLabel => 'LIFTED WEIGHT';

  @override
  String get calculator1RM_repsLabel => 'NUMBER OF REPS';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Your 1RM is: $value kg, which also corresponds to performing:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Your 1RM is: $value lbs, which also corresponds to performing:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Percentage';

  @override
  String get calculator1RM_table_header_reps => 'Reps';

  @override
  String get calculator1RM_table_header_weight => 'Weight';

  @override
  String get infoDialog1RM_title => 'About 1RM Calculator';

  @override
  String get infoDialog1RM_description =>
      'The 1RM calculator estimates the maximum weight you can lift for one repetition based on the weight and number of reps completed in a set. The formula used is the popular Brzycki formula.';

  @override
  String get infoDialog1RM_closeButton => 'Close';

  @override
  String get bmrResults_title => 'Your BMR by Activity Level:';

  @override
  String get bmrResults_noData => 'No data available';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'approx. $min–${max}g of protein per day';
  }

  @override
  String get basicActivity => 'Basal Metabolic Rate';

  @override
  String get lowActivity => 'Low activity';

  @override
  String get moderateActivity => 'Moderate activity';

  @override
  String get highActivity => 'High activity';

  @override
  String get veryHighActivity => 'Very high activity';

  @override
  String get calculatorBmr_title => 'BMR Calculator';

  @override
  String get calculatorBmr_weight_label_metric => 'WEIGHT (kg)';

  @override
  String get calculatorBmr_height_label_metric => 'HEIGHT (cm)';

  @override
  String get calculatorBmr_weight_label_imperial => 'WEIGHT (lbs)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'HEIGHT (ft)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'HEIGHT (in)';

  @override
  String get calculatorBmr_age_label => 'AGE';

  @override
  String get calculatorBmr_male => 'Male';

  @override
  String get calculatorBmr_female => 'Female';

  @override
  String get calculatorBmr_info =>
      'Fill in all the fields below to see the BMR result';

  @override
  String get bmrInfo_title => 'BMR and Protein Information:';

  @override
  String get bmrInfo_text1 =>
      'BMR (Basal Metabolic Rate) is a measure of how many calories your body needs at rest to maintain basic life functions.';

  @override
  String get bmrInfo_text2 =>
      'Activity level affects the BMR value. Higher activity means a higher calorie requirement.';

  @override
  String get bmrInfo_recommended =>
      'The recommended PROTEIN intake depends on the level of physical activity, and here are the ranges based on activity level:';

  @override
  String get bmrInfo_close => 'Close';

  @override
  String get perKilogram => 'per kilogram of body weight';

  @override
  String get perPound => 'per pound of body weight';

  @override
  String get plateCalculator_plateCalculator => 'Barbell plate calculator';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Click to see suggested plates';

  @override
  String get plateCalculator_fillOutData =>
      'Fill in the fields below to see the required weight per side. The TOTAL WEIGHT must be greater than the BARBELL WEIGHT.';

  @override
  String get plateCalculator_selectPlates => 'Select available plates:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'BARBELL WEIGHT (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'BARBELL WEIGHT (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'TOTAL WEIGHT (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'TOTAL WEIGHT (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Weight per side: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Weight per side: $weight lbs';
  }

  @override
  String plateCalculator_plateSizeKg(Object weight) {
    return '$weight kg';
  }

  @override
  String plateCalculator_plateSizeLbs(Object weight) {
    return '$weight lbs';
  }

  @override
  String get plateDialog_proposedPlates => 'Proposed Plates';

  @override
  String get plateDialog_forSide => 'PER SIDE';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Option $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Close';

  @override
  String get plateDialog_invalidWeight =>
      'Target weight must be greater than barbell weight';

  @override
  String get plateDialog_invalidTargetWeight =>
      'Target weight is less than barbell weight';

  @override
  String get measurementTile_noData =>
      'No data yet. Press \'Measure\' to add a new entry.';

  @override
  String get measurementTile_addData => 'Measure';

  @override
  String get measurementTile_baseline => 'Baseline';

  @override
  String get measurementTile_deleteCategory => 'Delete category';

  @override
  String get measurementTile_today => 'Today';

  @override
  String get measurementTile_yesterday => 'Yesterday';

  @override
  String get measurementTracker_body_measurements => 'Body measurements';

  @override
  String get measurementTracker_no_data_to_show => 'No data to show';

  @override
  String get measurementTracker_add_new_category => 'Add new category';

  @override
  String get measurementTracker_name_new_category => 'Category name';

  @override
  String get measurementTracker_name_new_measurement => 'Measurement value';

  @override
  String get measurementTracker_add_new_measurement => 'Add new measurement';

  @override
  String get measurementTracker_update_category => 'Update Category';

  @override
  String get measurementTracker_delete_category_confirmation =>
      'Are you sure you want to delete this category?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      'Are you sure you want to delete this measurement?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'Measurement for \'$bodyPart\' deleted.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'Category \'$category\' deleted.';
  }

  @override
  String get measurementTracker_category_exists =>
      'This category already exists!';

  @override
  String get measurementTracker_invalid_value => 'Invalid value!';

  @override
  String get measurementTracker_invalid_category =>
      'Invalid category selected!';

  @override
  String get measurementTracker_add_category_hint =>
      'You can add a new category using the button below.';

  @override
  String get weightTracker_title => 'Weight Tracker';

  @override
  String get weightTracker_enterWeightKg => 'Enter weight (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Enter weight (lbs)';

  @override
  String get weightTracker_saveWeight => 'Save Weight';

  @override
  String get weightTracker_updateWeight => 'Update Weight';

  @override
  String get weightTracker_yourWeight => 'Your weight';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' ($daysAgo ago)';
  }

  @override
  String get drawer_tools_section => 'Tools';

  @override
  String get drawer_calculators_section => 'Calculators';

  @override
  String get drawer_oneRepMax => 'One Rep Max';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Plates on barbell';

  @override
  String get drawer_time_section => 'Time';

  @override
  String get drawer_stopwatch => 'Stopwatch';

  @override
  String get drawer_trackers_section => 'Trackers';

  @override
  String get drawer_weightTracker => 'Weight tracker';

  @override
  String get drawer_measurementTracker => 'Measurement tracker';

  @override
  String get drawer_settings_section => 'Settings';

  @override
  String get drawer_customizeApp => 'Customize app';

  @override
  String get drawer_appLanguage => 'Language';

  @override
  String get drawer_notificationSettings => 'Notifications';

  @override
  String get drawer_appreciation_section => 'Support';

  @override
  String get drawer_supportButton => 'Make a donation';

  @override
  String get drawer_watchAd => 'Watch ad';

  @override
  String get drawer_shareApp => 'Share app';

  @override
  String get drawer_noteCount => 'Number of saved notes: ';

  @override
  String get drawer_guest => 'Guest';

  @override
  String get drawer_privacyPolicy => 'Privacy Policy';

  @override
  String get drawer_termsOfUse => 'Terms of Use';

  @override
  String get searchDrawer_hint => 'Search...';

  @override
  String get searchDrawer_clear => 'Clear search';

  @override
  String get addExerciseDialog_title => 'Add new exercise';

  @override
  String get addExerciseDialog_label => 'Enter exercise name';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Exercise \"$exerciseName\" added successfully';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Add Another Exercise?';

  @override
  String get addExerciseDialog_anotherContent =>
      'Would you like to add another exercise?';

  @override
  String get addWorkoutPlan_title => 'Add Workout Plan';

  @override
  String get addWorkoutPlan_planName => 'Workout Plan Name';

  @override
  String get addWorkoutPlan_selectedExercises => 'Selected Exercises:';

  @override
  String get addWorkoutPlan_noExercises => 'No exercises selected yet.';

  @override
  String get addWorkoutPlan_availableExercises => 'Available Exercises:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Add New Exercise';

  @override
  String get addWorkoutPlan_save => 'Save Workout Plan';

  @override
  String get addWorkoutPlan_missingName => 'Please enter a workout plan name.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Please select at least one exercise.';

  @override
  String get tabBottomDrawer_showOnly => 'Show only:';

  @override
  String get tabBottomDrawer_addNewGym => 'Add New Gym';

  @override
  String get tabBottomDrawer_addNewUser => 'Add New User';

  @override
  String get tabBottomDrawer_addNewExercise => 'Add New Exercise';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan => 'Add New Workout Plan';

  @override
  String get tabBottomDrawer_enterGymName => 'Enter gym name';

  @override
  String get tabBottomDrawer_enterUserName => 'Enter user name';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName => 'Enter workout plan name';

  @override
  String get tabSector_gym => 'Gym';

  @override
  String get tabSector_user => 'User';

  @override
  String get tabSector_exercise => 'Exercise';

  @override
  String get tabSector_workoutPlan => 'Workout plan';

  @override
  String get sortSector_aToZ => 'A ... Z';

  @override
  String get sortSector_zToA => 'Z ... A';

  @override
  String get sortSector_newest => 'Newest';

  @override
  String get sortSector_oldest => 'Oldest';

  @override
  String get sortSector_exerciseView => 'Exercise';

  @override
  String get sortSector_historyView => 'History';

  @override
  String get historyView_noWorkouts => 'No workouts available';

  @override
  String get historyView_exerciseNotFound => 'Exercise Not Found';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'This section will display notes from your workouts';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'No results match your filters.';

  @override
  String get notes_justNow => 'Just now';

  @override
  String notes_minutesAgo(Object count) {
    return '$count minutes ago';
  }

  @override
  String notes_hoursAgo(Object count) {
    return '$count hours ago';
  }

  @override
  String notes_daysAgo(Object count) {
    return '$count days ago';
  }

  @override
  String get notes_invalidDate => 'Invalid date';

  @override
  String get notes_showMore => 'Show more';

  @override
  String get notes_showLess => 'Show less';

  @override
  String get notes_deleteNoteTitle => 'Delete Note';

  @override
  String get notes_deleteNoteConfirm =>
      'Are you sure you want to delete this note?';

  @override
  String get notes_copy => 'Copy note';

  @override
  String get notes_copied => 'Note copied to clipboard';

  @override
  String get exerciseView_sortDesc => 'Z ... A';

  @override
  String get exerciseView_sortAsc => 'A ... Z';

  @override
  String get exerciseView_filteredOutExercises =>
      'Exercises not matching the filters:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Go to the \'Exercise\' section to add your first exercise.';

  @override
  String get iconSelection_chooseIcon => 'Choose exercise icon';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Add a user and gym to the exercise';

  @override
  String get exerciseExpansion_deleteExercise => 'Delete Exercise';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Are you sure you want to delete this exercise? This will also remove all data associated with this exercise.';

  @override
  String get exerciseExpansion_addIcon => 'Add an icon to the exercise';

  @override
  String get exerciseExpansion_unknownExercise => 'Unknown Exercise';

  @override
  String get exerciseExpansion_unknownUser => 'Unknown User';

  @override
  String get exerciseExpansion_unknownGym => 'Unknown Gym';

  @override
  String get exerciseExpansion_noWorkouts => 'No workouts available';

  @override
  String get exerciseExpansion_changeNameTitle => 'Change exercise name';

  @override
  String get exerciseExpansion_enterNewName => 'Enter new exercise name';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Assign $exercise to User and Gym';
  }

  @override
  String get addUserAndGym_selectUser => 'Select user';

  @override
  String get addUserAndGym_selectGym => 'Select gym';

  @override
  String get addUserAndGym_confirmSelection => 'Confirm Selection';

  @override
  String get addUserAndGym_workoutExists =>
      'This workout already exists for the selected user and gym.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Global note for exercise $exerciseName';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Last note: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Set Quick Value';

  @override
  String get resultsExpansion_quickValueSet => 'Enter text or number';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      'Are you sure you want to delete this section along with all its results?';

  @override
  String get notes_title => 'Workouts';

  @override
  String get notes_addNote => '+ Add Note';

  @override
  String get notes_cancel => 'Cancel';

  @override
  String get notes_hint => 'Enter your note...';

  @override
  String get notes_saveNote => 'Save Note';

  @override
  String get notes_updateNote => 'Update Note';

  @override
  String get notes_empty => 'No notes available';

  @override
  String get notes_emptyNote => 'No note';

  @override
  String get globalNote_title => 'Global Note';

  @override
  String get globalNote_empty => 'No note...';

  @override
  String get globalNote_hint => 'Enter your note';

  @override
  String get notificationScreen_title => 'Notifications';

  @override
  String get notificationScreen_permissionTooltip =>
      'Request notification permissions';

  @override
  String get notificationList_title => 'Saved notifications:';

  @override
  String get notificationList_empty => 'No saved notifications.';

  @override
  String notificationList_hour(Object time) {
    return 'Time: $time';
  }

  @override
  String get notificationList_daily => 'Daily';

  @override
  String notificationList_interval(Object days) {
    return 'Every $days days';
  }

  @override
  String get notificationList_weekly_none => 'No days';

  @override
  String get notificationList_type_training => 'Training';

  @override
  String get notificationList_type_weight => 'Weight';

  @override
  String get notificationList_type_measurement => 'Measurement';

  @override
  String get notificationList_type_custom => 'Custom';

  @override
  String get notificationList_confirm_title => 'Confirmation';

  @override
  String get notificationList_confirm_content =>
      'Are you sure you want to delete this notification?';

  @override
  String get notificationForm_titleLabel => 'Notification title:';

  @override
  String get notificationForm_titleHint =>
      'Enter your custom notification title...';

  @override
  String get notificationForm_messageLabel => 'Notification message:';

  @override
  String get notificationForm_messageHint =>
      'Enter your custom notification message...';

  @override
  String get notificationForm_addNotification => 'Add Notification';

  @override
  String get notificationForm_added => 'Notification added!';

  @override
  String get notificationForm_typeLabel => 'Reminder type:';

  @override
  String get notificationForm_typeTraining => 'Training';

  @override
  String get notificationForm_typeWeight => 'Weigh-in';

  @override
  String get notificationForm_typeMeasurement => 'Body measurement';

  @override
  String get notificationForm_typeCustom => 'Custom';

  @override
  String get notificationForm_modeLabel => 'Notification mode:';

  @override
  String get notificationForm_modeDaily => 'Daily';

  @override
  String get notificationForm_modeInterval => 'Every X days';

  @override
  String get notificationForm_modeWeekly => 'Selected weekdays';

  @override
  String get notificationForm_intervalPrefix => 'Every';

  @override
  String get notificationForm_intervalSuffix => 'days';

  @override
  String get notificationForm_weekdayMon => 'Mon';

  @override
  String get notificationForm_weekdayTue => 'Tue';

  @override
  String get notificationForm_weekdayWed => 'Wed';

  @override
  String get notificationForm_weekdayThu => 'Thu';

  @override
  String get notificationForm_weekdayFri => 'Fri';

  @override
  String get notificationForm_weekdaySat => 'Sat';

  @override
  String get notificationForm_weekdaySun => 'Sun';

  @override
  String get notificationForm_defaultTitleTraining => 'Workout time!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Don\'t forget your physical activity.';

  @override
  String get notificationForm_defaultTitleWeight => 'Check your weight';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Time to weigh yourself. Log it in the app.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Take measurements';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Time to measure your body. Track your progress!';

  @override
  String get timePicker_label => 'Time';

  @override
  String get watchAds_title => 'Watch Ads to Support';

  @override
  String get watchAds_description =>
      'Watch short video ads to support us without spending money';

  @override
  String get watchAds_button => 'Watch Ad';

  @override
  String get watchAds_counter => 'Ads Watched:';

  @override
  String get shareApp_title => 'Share App';

  @override
  String get shareApp_inviteTitle =>
      'Share this app with your friends and family!';

  @override
  String get shareApp_inviteSubtitle =>
      'Help us grow our community by sharing this app with people who might find it useful.';

  @override
  String get shareApp_shareText => 'Check out this app:';

  @override
  String get shareApp_shareButton => 'Share with...';

  @override
  String get shareApp_linkCopied => 'Link copied to clipboard';

  @override
  String get donate_title => 'Support Us';

  @override
  String get donateSections_whyTitle => 'Why Support Us?';

  @override
  String get donateSections_whyDesc =>
      'Your donations help us maintain and improve this project. All contributions are voluntary and don’t unlock any special features or content.';

  @override
  String get donateSections_monthlyTitle => 'Monthly Subscription';

  @override
  String get donateSections_monthlyDesc =>
      'Support us with a recurring monthly donation';

  @override
  String get donateSections_monthlyButton => 'Subscribe Monthly';

  @override
  String get donateSections_oneTimeTitle => 'One-Time Donation';

  @override
  String get donateSections_oneTimeDesc =>
      'Make a single contribution of chosen amount';

  @override
  String get donateSections_oneTimeButton => 'Donate Now';

  @override
  String get donateSections_voluntaryTitle => '100% Voluntary';

  @override
  String get donateSections_voluntaryDesc =>
      'Remember, all donations are completely voluntary. You will not receive any special features or content for your contribution – just our sincere gratitude for supporting this project.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Favorite Exercises';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Select a few exercises to get started with';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Add your own exercise';

  @override
  String get welcomeExerciseStep_exampleExercise =>
      'e.g. Bulgarian Split Squat';

  @override
  String get welcomeExerciseStep_addButton => 'Add';

  @override
  String get welcomeExerciseStep_nextButton => 'Next';

  @override
  String get welcomeGymLocationStep_workoutPreferences => 'Workout Preferences';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Where do you usually train?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Home Workout';

  @override
  String get welcomeGymLocationStep_gym => 'Gym';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Gym Name $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Next';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Welcome to GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Let\'s set up your profile to get started with your app journey';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Get started';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Personal information';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Your name';

  @override
  String get welcomeIntroSteps_nextButton => 'Next';

  @override
  String get welcomeSettingStep_appSettings => 'App Settings';

  @override
  String get welcomeSettingStep_measurementSystem => 'Measurement System';

  @override
  String get welcomeSettingStep_metric => 'Metric';

  @override
  String get welcomeSettingStep_imperial => 'Imperial';

  @override
  String get welcomeSettingStep_appTheme => 'App Theme';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Enter GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Choose Language';

  @override
  String get welcomeScreen_english => 'English';

  @override
  String get welcomeScreen_polish => 'Polski';

  @override
  String get welcomeScreen_languageTooltip => 'Change Language';

  @override
  String get welcomeScreen_exercise_benchPress => 'Bench Press';

  @override
  String get welcomeScreen_exercise_squats => 'Squats';

  @override
  String get welcomeScreen_exercise_deadlift => 'Deadlift';

  @override
  String get welcomeScreen_exercise_pullUps => 'Pull-ups';

  @override
  String get welcomeScreen_exercise_pushUps => 'Push-ups';

  @override
  String get welcomeScreen_exercise_lunges => 'Lunges';

  @override
  String get welcomeEnd_welcome => 'Welcome to GoGymSimple';

  @override
  String get stopwatch_title => 'Stopwatch';
}
