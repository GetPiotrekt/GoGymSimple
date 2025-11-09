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
  String get settings_elementVisibility => 'Show stopwatch on the main screen';

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
  String get settings_metric => 'Metric (kg/m)';

  @override
  String get settings_imperial => 'Imperial (lbs/in)';

  @override
  String get daysAgo_noData => 'No data';

  @override
  String get daysAgo_lessThanOneHour => 'Less than an hour ago';

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
  String get daysAgo_longTimeAgo => 'A long time ago';

  @override
  String get confirmationDialog_title => 'Confirmation';

  @override
  String get deleteConfirmationDialog_title => 'Delete Confirmation';

  @override
  String get dialog_content => 'Are you sure you want to continue?';

  @override
  String get dialog_cancel => 'Cancel';

  @override
  String get dialog_confirm => 'Confirm';

  @override
  String get dialog_save => 'Save';

  @override
  String get inputFormField_labelText => 'Enter a value';

  @override
  String get inputFormField_invalidValue =>
      'Invalid value – please enter a number.';

  @override
  String get addPattern_title => 'Add New Color Theme';

  @override
  String get addPattern_iconsText => 'Icon and text preview';

  @override
  String get addPattern_textExample => 'Text example with a different shade';

  @override
  String get addPattern_backgroundColor => 'Background color';

  @override
  String get addPattern_sectionColor => 'Section color';

  @override
  String get addPattern_textIconsColor => 'Text and icon color';

  @override
  String get addPattern_save => 'Save';

  @override
  String get customizeApp_availableColorPalettes => 'Available Themes';

  @override
  String get customizeApp_currentTheme => 'Current Theme';

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
    return 'Theme \"$name\" saved. You can apply it now.';
  }

  @override
  String get savePalette_themeName => 'Theme Name';

  @override
  String get addPattern_moreColors => 'More Colors';

  @override
  String get fullColorPicker_chooseColor => 'Choose Color';

  @override
  String get fullColorPicker_save => 'Save';

  @override
  String get applyNewTheme => 'New theme applied';

  @override
  String get calculator1RM_title => '1RM Calculator';

  @override
  String get calculator1RM_infoText =>
      'Fill in the fields below to calculate your 1RM';

  @override
  String get calculator1RM_weightLabelKg => 'Weight (kg)';

  @override
  String get calculator1RM_weightLabelLbs => 'Weight (lbs)';

  @override
  String get calculator1RM_repsLabel => 'Reps';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Your 1RM is: $value kg, which corresponds to:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Your 1RM is: $value lbs, which corresponds to:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Percentage';

  @override
  String get calculator1RM_table_header_reps => 'Reps';

  @override
  String get calculator1RM_table_header_weight => 'Weight';

  @override
  String get infoDialog1RM_title => 'About the 1RM Calculator';

  @override
  String get infoDialog1RM_description =>
      'The 1RM calculator estimates the maximum weight you can lift for one repetition based on the weight lifted and number of reps performed. It uses the popular Brzycki formula.';

  @override
  String get infoDialog1RM_closeButton => 'Close';

  @override
  String get bmrResults_title => 'Your BMR based on activity level:';

  @override
  String get bmrResults_noData => 'No data';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'Approx. $min–$max g protein per day';
  }

  @override
  String get basicActivity => 'Basic Metabolic Rate';

  @override
  String get lowActivity => 'Low Activity';

  @override
  String get moderateActivity => 'Moderate Activity';

  @override
  String get highActivity => 'High Activity';

  @override
  String get veryHighActivity => 'Very High Activity';

  @override
  String get calculatorBmr_title => 'BMR Calculator';

  @override
  String get calculatorBmr_weight => 'Weight';

  @override
  String get calculatorBmr_height_label_metric => 'Height (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ft';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'in';

  @override
  String get calculatorBmr_age_label => 'Age';

  @override
  String get calculatorBmr_male => 'Male';

  @override
  String get calculatorBmr_female => 'Female';

  @override
  String get calculatorBmr_info => 'Fill in your details to see your BMR';

  @override
  String get bmrInfo_title => 'About BMR and Protein:';

  @override
  String get bmrInfo_text1 =>
      'BMR (Basal Metabolic Rate) is the number of calories your body needs at rest to keep basic functions running.';

  @override
  String get bmrInfo_text2 =>
      'Your activity level affects your calorie needs — the more active you are, the more calories you’ll need.';

  @override
  String get bmrInfo_recommended =>
      'Recommended PROTEIN intake depends on your activity level. Here are the suggested ranges based on how active you are:';

  @override
  String get bmrInfo_close => 'Close';

  @override
  String get perKilogram => 'per kg of body weight';

  @override
  String get perPound => 'per lb of body weight';

  @override
  String get plateCalculator_plateCalculator => 'Plate Calculator (per side)';

  @override
  String get plateCalculator_clickToSeePlates => 'Tap to see suggested plates';

  @override
  String get plateCalculator_fillOutData =>
      'Fill in the details below to see the weight needed on each side. Total weight must be more than the barbell weight.';

  @override
  String get plateCalculator_selectPlates => 'Select available plates:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'Barbell (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'Barbell (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'Total (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'Total (lbs)';

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
  String get plateDialog_proposedPlates => 'Suggested Plates';

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
      'Weight must be more than the barbell weight';

  @override
  String get plateDialog_invalidTargetWeight => 'Target weight is too low';

  @override
  String get plateDialog_noCombinationFound =>
      'No plate combination found for the selected weight';

  @override
  String get measurementTile_noData =>
      'No data. Tap \'Measure\' to add a value';

  @override
  String get measurementTile_addData => 'Measure';

  @override
  String get measurementTile_baseline => 'Baseline';

  @override
  String get measurementTile_deleteCategory => 'Delete Category';

  @override
  String get measurementTile_today => 'Today';

  @override
  String get measurementTile_yesterday => 'Yesterday';

  @override
  String get measurementTracker_body_measurements => 'Body Measurements';

  @override
  String get measurementTracker_no_data_to_show => 'No data to display';

  @override
  String get measurementTracker_add_new_category => 'Add Category';

  @override
  String get measurementTracker_name_new_category => 'Category Name';

  @override
  String get measurementTracker_name_new_measurement => 'Measurement Value';

  @override
  String get measurementTracker_add_new_measurement => 'Add Measurement';

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
    return 'Measurement for \'$bodyPart\' has been deleted.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'Category \'$category\' has been deleted.';
  }

  @override
  String get measurementTracker_category_exists =>
      'That category already exists!';

  @override
  String get measurementTracker_invalid_value => 'Invalid value!';

  @override
  String get measurementTracker_invalid_category =>
      'Selected category is invalid!';

  @override
  String get measurementTracker_add_category_hint =>
      'Add a new category using the button below.';

  @override
  String get measurementTracker_measurementDate => 'Measurement Date';

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
  String get weightTracker_yourWeight => 'Your Weight';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' ($daysAgo days ago)';
  }

  @override
  String get weightTracker_legendWeightSaved => 'Days with recorded weight';

  @override
  String get drawer_tools_section => 'Tools';

  @override
  String get drawer_calculators_section => 'Calculators';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Plates on Barbell';

  @override
  String get drawer_time_section => 'Time';

  @override
  String get drawer_stopwatch => 'Stopwatch';

  @override
  String get drawer_trackers_section => 'Tracking';

  @override
  String get drawer_weightTracker => 'Weight Tracker';

  @override
  String get drawer_measurementTracker => 'Measurement Tracker';

  @override
  String get drawer_settings_section => 'Settings';

  @override
  String get drawer_customizeApp => 'Customize Theme';

  @override
  String get drawer_appLanguage => 'Language';

  @override
  String get drawer_notificationSettings => 'Notifications';

  @override
  String get drawer_appreciation_section => 'Support';

  @override
  String get drawer_supportButton => 'Donate';

  @override
  String get drawer_watchAd => 'Watch Ad';

  @override
  String get drawer_shareApp => 'Recommend GoGymSimple';

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
  String get searchDrawer_clear => 'Clear Search';

  @override
  String get addExerciseDialog_title => 'Add New Exercise';

  @override
  String get addExerciseDialog_label => 'Enter exercise name';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Exercise \"$exerciseName\" added';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Add another exercise?';

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
  String get addWorkoutPlan_noExercises => 'No exercises added yet.';

  @override
  String get addWorkoutPlan_availableExercises => 'Available Exercises:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Add New Exercise';

  @override
  String get addWorkoutPlan_save => 'Save Workout Plan';

  @override
  String get addWorkoutPlan_missingName => 'Please enter a workout plan name.';

  @override
  String get addWorkoutPlan_missingExercises => 'Add at least one exercise.';

  @override
  String get tabBottomDrawer_showOnly => 'Show only:';

  @override
  String get tabBottomDrawer_addNewGym => 'Add Gym';

  @override
  String get tabBottomDrawer_addNewUser => 'Add User';

  @override
  String get tabBottomDrawer_addNewExercise => 'Add Exercise';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan => 'Add Workout Plan';

  @override
  String get tabBottomDrawer_enterGymName => 'Enter Gym Name';

  @override
  String get tabBottomDrawer_enterUserName => 'Enter User Name';

  @override
  String get tabBottomDrawer_editTitle => 'Edit Name';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName => 'Enter Workout Plan Name';

  @override
  String get tabBottomDrawer_editExercise => 'Edit Exercise';

  @override
  String get tabBottomDrawer_editLabel => 'Type New Name';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Refresh the screen to see changes';

  @override
  String get tabBottomDrawer_reorderExercises => 'Reorder exercises';

  @override
  String get tabSector_gym => 'Gym';

  @override
  String get tabSector_user => 'User';

  @override
  String get tabSector_exercise => 'Exercise';

  @override
  String get tabSector_workoutPlan => 'Workout Plan';

  @override
  String get tabSector_filter => 'Filter';

  @override
  String get tabSector_userGym => 'User & Gym';

  @override
  String get sortSector_newest => 'Newest';

  @override
  String get sortSector_oldest => 'Oldest';

  @override
  String get sortSector_exerciseView => 'Exercises';

  @override
  String get sortSector_historyView => 'History';

  @override
  String get historyView_noWorkouts => 'No workouts available';

  @override
  String get historyView_exerciseNotFound => 'Exercise not found';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'Your workout notes will show up here';

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
  String get exerciseView_filteredOutExercises => 'Exercises filtered out:';

  @override
  String get exerciseView_noExercisesMessage =>
      'You don’t have any exercises yet. Head to the “Exercise” tab to add your first one.';

  @override
  String get iconSelection_chooseIcon => 'Choose Exercise Icon';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym => 'Add User & Gym to Exercise';

  @override
  String get exerciseExpansion_deleteExercise => 'Delete Exercise';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Are you sure you want to delete this exercise? This will also remove all related data.';

  @override
  String get exerciseExpansion_addIcon => 'Add Icon to Exercise';

  @override
  String get exerciseExpansion_unknownExercise => 'Unknown Exercise';

  @override
  String get exerciseExpansion_unknownUser => 'Unknown User';

  @override
  String get exerciseExpansion_unknownGym => 'Unknown Gym';

  @override
  String get exerciseExpansion_noWorkouts => 'No workouts available';

  @override
  String get exerciseExpansion_changeNameTitle => 'Rename Exercise';

  @override
  String get exerciseExpansion_enterNewName => 'New Exercise Name';

  @override
  String get exerciseExpansion_exerciseNoteLabel => 'Exercise note';

  @override
  String get exerciseExpansion_exerciseNoteHint =>
      'Add general info about the exercise—like a link to proper form or a helpful site—so it\'s always right at your fingertips.';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Assign Exercise to User & Gym';
  }

  @override
  String get addUserAndGym_selectUser => 'Select User';

  @override
  String get addUserAndGym_selectGym => 'Select Gym';

  @override
  String get addUserAndGym_confirmSelection => 'Confirm Selection';

  @override
  String get addUserAndGym_workoutExists =>
      'This exercise already exists for the selected user and gym.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Add a general note for the selected user and gym – e.g., preferred machines, settings, technique tips, etc.';
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
  String get resultsExpansion_quickValueSet =>
      'e.g., training goal or best set';

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
  String get notes_hint => 'Type your note...';

  @override
  String get notes_saveNote => 'Save Note';

  @override
  String get notes_updateNote => 'Update Note';

  @override
  String get notes_empty => 'No notes available';

  @override
  String get notes_emptyNote => 'No note';

  @override
  String get notes_deleteNoteTitle => 'Delete Note';

  @override
  String get notes_deleteNoteConfirm =>
      'Are you sure you want to delete this note?';

  @override
  String get notes_copy => 'Copy Note';

  @override
  String get notes_copied => 'Note copied to clipboard';

  @override
  String get globalNote_title => 'Global Note';

  @override
  String get globalNote_empty => 'No note';

  @override
  String get globalNote_hint => 'Set a global note for this exercise';

  @override
  String get notificationScreen_title => 'Notifications';

  @override
  String get notificationScreen_permissionTooltip =>
      'Tap to enable notification editing';

  @override
  String get notificationList_title => 'Saved Notifications:';

  @override
  String get notificationList_empty => 'No saved notifications.';

  @override
  String notificationList_hour(Object time) {
    return 'Time: $time';
  }

  @override
  String get notificationList_daily => 'Every Day';

  @override
  String notificationList_interval(Object days) {
    return 'Every $days Days';
  }

  @override
  String get notificationList_weekly_none => 'No days selected';

  @override
  String get notificationList_type_training => 'Workout';

  @override
  String get notificationList_type_weight => 'Weight';

  @override
  String get notificationList_type_measurement => 'Measurement';

  @override
  String get notificationList_type_custom => 'Custom';

  @override
  String get notificationList_confirm_title => 'Confirm';

  @override
  String get notificationList_confirm_content =>
      'Are you sure you want to delete this notification?';

  @override
  String get notificationList_deleteAll => 'Delete All';

  @override
  String get notificationList_confirmAll_title => 'Delete All Notifications?';

  @override
  String get notificationList_confirmAll_content =>
      'Are you sure you want to delete all saved notifications?';

  @override
  String get notificationForm_titleLabel => 'Notification Title:';

  @override
  String get notificationForm_titleHint => 'Enter notification title...';

  @override
  String get notificationForm_messageLabel => 'Notification Message:';

  @override
  String get notificationForm_messageHint => 'Enter your custom message...';

  @override
  String get notificationForm_addNotification => 'Add Notification';

  @override
  String get notificationForm_added => 'Notification added!';

  @override
  String get notificationForm_typeLabel => 'Reminder:';

  @override
  String get notificationForm_typeTraining => 'Workout';

  @override
  String get notificationForm_typeWeight => 'Weight Check';

  @override
  String get notificationForm_typeMeasurement => 'Measurements';

  @override
  String get notificationForm_typeCustom => 'Custom';

  @override
  String get notificationForm_modeLabel => 'Frequency:';

  @override
  String get notificationForm_modeDaily => 'Every Day';

  @override
  String get notificationForm_modeInterval => 'Every X Days';

  @override
  String get notificationForm_modeWeekly => 'Selected Days of the Week';

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
  String get notificationForm_defaultTitleTraining => 'Time to Work Out!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Don\'t forget your workout today.';

  @override
  String get notificationForm_defaultTitleWeight => 'Check Your Weight';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Time to weigh in. Log your results in the app.';

  @override
  String get notificationForm_defaultTitleMeasurement =>
      'Take Your Measurements';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'It\'s time for a body check. Track your progress!';

  @override
  String get notificationForm_testNotification => 'Test Notification';

  @override
  String get timePicker_label => 'Time';

  @override
  String get watchAds_title => 'Watch Ads to Support Us';

  @override
  String get watchAds_description =>
      'Watch a short video ad to support us without spending a dime.';

  @override
  String get watchAds_button => 'Watch Ad';

  @override
  String get watchAds_counter => 'Ads watched:';

  @override
  String get watchAds_error =>
      'Thanks for your support! Unfortunately, the ad failed to load.';

  @override
  String get watchAds_done =>
      'Congratulations! You’ve reached today’s limit. It will reset tomorrow.';

  @override
  String get watchAds_hide => 'Show ad button in training section';

  @override
  String get shareApp_title => 'Recommend';

  @override
  String get shareApp_inviteTitle => 'Share the app with friends and family!';

  @override
  String get shareApp_inviteSubtitle =>
      'Help us grow the community — share the app with people who might find it useful.';

  @override
  String get shareApp_shareButton => 'Share via...';

  @override
  String get shareApp_linkCopied => 'Link copied to clipboard';

  @override
  String get shareApp_shareText => 'Check out this app:';

  @override
  String get shareApp_ratingTitle => 'Love GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      'Rate us! Your feedback helps others discover the app.';

  @override
  String get shareApp_ratingYes => 'You bet!';

  @override
  String get donate_title => 'Support Us';

  @override
  String get donateSections_whyTitle => 'Why Support Us?';

  @override
  String get donateSections_whyDesc =>
      'Your donations help us keep this project going. All contributions are voluntary and don’t unlock any extra features.';

  @override
  String get donateSections_monthlyTitle => 'Monthly Support';

  @override
  String get donateSections_monthlyDesc =>
      'Support us monthly with a recurring donation.';

  @override
  String get donateSections_monthlyButton => 'Support Monthly';

  @override
  String get donateSections_oneTimeTitle => 'One-Time Donation';

  @override
  String get donateSections_oneTimeDesc =>
      'Make a one-time donation of any amount.';

  @override
  String get donateSections_oneTimeButton => 'Donate Once';

  @override
  String get donateSections_voluntaryTitle => '100% Voluntary';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Store is currently unavailable. Please check your internet connection.';

  @override
  String get donateSections_voluntaryDesc =>
      'Remember, all donations are completely voluntary. You won’t get any extra features — just our sincere thanks.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Favorite Exercises';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Pick a few exercises to get started';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Add your own exercise';

  @override
  String get welcomeExerciseStep_exampleExercise =>
      'e.g., Bulgarian split squats';

  @override
  String get welcomeExerciseStep_addButton => 'Add';

  @override
  String get welcomeExerciseStep_nextButton => 'Next';

  @override
  String get welcomeGymLocationStep_workoutPreferences => 'Workout Preferences';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Where do you usually work out?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'At home';

  @override
  String get welcomeGymLocationStep_gym => 'At the gym';

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
      'Set up your profile and start your journey with the app';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Let’s Get Started';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Your Info';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Name';

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
  String get welcomeScreen_languageTooltip => 'Change language';

  @override
  String get welcomeScreen_exercise_benchPress => 'Bench Press';

  @override
  String get welcomeScreen_exercise_squats => 'Squats';

  @override
  String get welcomeScreen_exercise_deadlift => 'Deadlift';

  @override
  String get welcomeScreen_exercise_pullUps => 'Pull-Ups';

  @override
  String get welcomeScreen_exercise_pushUps => 'Push-Ups';

  @override
  String get welcomeScreen_exercise_lunges => 'Lunges';

  @override
  String get welcomeEnd_welcome => 'Welcome to GoGymSimple';

  @override
  String get stopwatch_title => 'Stopwatch';

  @override
  String get workoutScreen_title => 'Workout';

  @override
  String get workoutScreen_gym => 'Select Gym';

  @override
  String get workoutScreen_gymAndDate => 'Select Gym and Date';

  @override
  String get workoutScreen_selectGymFirst => 'Please select a gym first';

  @override
  String get workoutScreen_noGymSelected => 'No gym selected';

  @override
  String get workoutScreen_saved => 'Workout saved!';

  @override
  String get workoutScreen_participants => 'Participants';

  @override
  String get workoutScreen_plans => 'Plans';

  @override
  String get workoutScreen_exercises => 'Exercises';

  @override
  String get workoutScreen_addExercise => 'Add Exercise';

  @override
  String get workoutScreen_addNote => 'Add Note';

  @override
  String get workoutScreen_saveNote => 'Save Note';

  @override
  String get workoutScreen_savedNote => 'Note saved';

  @override
  String get workoutScreen_showMoreInfo => 'Show more';

  @override
  String get workoutScreen_firstTime => 'First time';

  @override
  String get workoutScreen_cancelWorkout => 'Cancel workout';

  @override
  String get workoutScreen_workoutCancelled => 'Workout cancelled';

  @override
  String get workoutScreen_addGeneralNote => 'Workout note';

  @override
  String get restoreSession_title => 'Workout Interrupted';

  @override
  String get restoreSession_info => 'Your last workout was interrupted.';

  @override
  String get restoreSession_content =>
      'Would you like to restore your progress?';

  @override
  String get restoreSession_confirm => 'Yes, restore';

  @override
  String get restoreSession_deny => 'Start fresh';

  @override
  String get saveWorkoutDialog_save_workout_title => 'Save workout?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Save this workout so you can come back to it later';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Save Workout';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Not now';

  @override
  String get saveWorkoutDialog_support_us_title => 'Support Us';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      'Watch a short ad to help us keep improving the app!';

  @override
  String get editDeleteBottomSheet_edit => 'Edit';

  @override
  String get editDeleteBottomSheet_delete => 'Delete';

  @override
  String get noTrainingSection_noSaved =>
      'No saved trainings for this exercise';

  @override
  String get noTrainingSection_noSavedGlobal => 'No saved trainings';

  @override
  String get noTrainingSection_startNewFirst =>
      'Hit the \'Start\' button in the top right to begin your workout and start tracking progress.';

  @override
  String get noTrainingSection_startNewSecond =>
      'Once it\'s started, you can pause and jump back in anytime you like.';

  @override
  String get noTrainingSection_addPrevious =>
      'You can also add previous workouts using this button, just by changing the workout date.';

  @override
  String get shareApp_feedbackTitle => 'Got an idea?';

  @override
  String get shareApp_feedbackSubtitle =>
      'If you have an idea for a new feature – send a message on my private Instagram! This is a privilege available only to users of the first official version of GoGymSimple';

  @override
  String get shareApp_feedbackButton => 'Message on Instagram (@wisnia.55)';

  @override
  String get goalAndBest_goal_title => 'Goal';

  @override
  String get goalAndBest_goal_hint => 'Enter training goal';

  @override
  String get goalAndBest_bestSet_title => 'Best set';

  @override
  String get goalAndBest_bestSet_hint => 'Enter your best set';

  @override
  String get example_prefix => 'e.g.';

  @override
  String get exerciseStats_title => 'Statistics';

  @override
  String get exerciseStats_timeStats => 'Time statistics:';

  @override
  String get exerciseStats_noteStats => 'Note statistics:';

  @override
  String get exerciseStats_totalNotes => 'Notes (total)';

  @override
  String get exerciseStats_lastWeek => 'Notes (last week)';

  @override
  String get exerciseStats_lastMonth => 'Notes (last month)';

  @override
  String get exerciseStats_lastYear => 'Notes (last year)';

  @override
  String get exerciseStats_avgLines => 'Avg. line count';

  @override
  String get exerciseStats_avgChars => 'Avg. character count';

  @override
  String get exerciseStats_totalLines => 'Total line count';

  @override
  String get exerciseStats_totalChars => 'Total character count';

  @override
  String get exerciseStats_none => 'None';

  @override
  String get exerciseNoteTile_suggestedLength => 'Suggested length: ';

  @override
  String get exerciseNoteTile_infoTitle => 'Note length information';

  @override
  String get exerciseNoteTile_infoContent =>
      'While you can exceed 200 characters without problems, it\'s suggested to keep your notes concise. Longer notes may slightly impact storage usage and syncing performance.';

  @override
  String get exercise_barbellSquat => 'Barbell Squat';

  @override
  String get exercise_deadlift => 'Deadlift';

  @override
  String get exercise_benchPress => 'Bench Press';

  @override
  String get exercise_overheadPress => 'Overhead Press';

  @override
  String get exercise_pullUp => 'Pull-up';

  @override
  String get exercise_chinUp => 'Chin-up';

  @override
  String get exercise_barbellRow => 'Barbell Row';

  @override
  String get exercise_dumbbellCurl => 'Dumbbell Curl';

  @override
  String get exercise_tricepsDip => 'Triceps Dip';

  @override
  String get exercise_latPulldown => 'Lat Pulldown';

  @override
  String get exercise_inclineBenchPress => 'Incline Bench Press';

  @override
  String get exercise_declineBenchPress => 'Decline Bench Press';

  @override
  String get exercise_legPress => 'Leg Press';

  @override
  String get exercise_legCurl => 'Leg Curl';

  @override
  String get exercise_legExtension => 'Leg Extension';

  @override
  String get exercise_calfRaise => 'Calf Raise';

  @override
  String get exercise_seatedRow => 'Seated Row';

  @override
  String get exercise_tBarRow => 'T-Bar Row';

  @override
  String get exercise_pushUp => 'Push-up';

  @override
  String get exercise_sitUp => 'Sit-up';

  @override
  String get exercise_crunch => 'Crunch';

  @override
  String get exercise_plank => 'Plank';

  @override
  String get exercise_russianTwist => 'Russian Twist';

  @override
  String get exercise_jumpRope => 'Jump Rope';

  @override
  String get exercise_bicycleCrunch => 'Bicycle Crunch';

  @override
  String get exercise_mountainClimbers => 'Mountain Climbers';

  @override
  String get exercise_kettlebellSwing => 'Kettlebell Swing';

  @override
  String get exercise_sumoDeadlift => 'Sumo Deadlift';

  @override
  String get exercise_frontSquat => 'Front Squat';

  @override
  String get exercise_hackSquat => 'Hack Squat';

  @override
  String get exercise_hipThrust => 'Hip Thrust';

  @override
  String get exercise_gluteBridge => 'Glute Bridge';

  @override
  String get exercise_cableFly => 'Cable Fly';

  @override
  String get exercise_lateralRaise => 'Lateral Raise';

  @override
  String get exercise_rearDeltFly => 'Rear Delt Fly';

  @override
  String get exercise_hammerCurl => 'Hammer Curl';

  @override
  String get exercise_skullCrusher => 'Skull Crusher';

  @override
  String get exercise_facePull => 'Face Pull';

  @override
  String get exercise_farmersWalk => 'Farmer\'s Walk';

  @override
  String get exercise_abWheelRollout => 'Ab Wheel Rollout';

  @override
  String get exercise_cableRow => 'Cable Row';

  @override
  String get exercise_inclineDumbbellCurl => 'Incline Dumbbell Curl';

  @override
  String get exercise_oneArmDumbbellRow => 'One-arm Dumbbell Row';

  @override
  String get exercise_dumbbellLunges => 'Dumbbell Lunges';

  @override
  String get exercise_gobletSquat => 'Goblet Squat';

  @override
  String get exercise_bulgarianSplitSquat => 'Bulgarian Split Squat';

  @override
  String get exercise_stepUp => 'Step-up';

  @override
  String get exercise_ezBarCurl => 'EZ-Bar Curl';

  @override
  String get exercise_arnoldPress => 'Arnold Press';

  @override
  String get multiSelect_title => 'Select Multiple Exercises';

  @override
  String get multiSelect_subtitle => 'Choose from popular exercises';

  @override
  String get multiSelect_added => 'added';
}
