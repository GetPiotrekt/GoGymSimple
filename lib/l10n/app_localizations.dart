import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('es', 'CO'),
    Locale('es', 'ES'),
    Locale('it'),
    Locale('nl'),
    Locale('pl')
  ];

  /// No description provided for @unknownExercise.
  ///
  /// In en, this message translates to:
  /// **'Unknown Exercise'**
  String get unknownExercise;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_elementVisibility.
  ///
  /// In en, this message translates to:
  /// **'Show stopwatch on home screen'**
  String get settings_elementVisibility;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_english;

  /// No description provided for @settings_polish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get settings_polish;

  /// No description provided for @settings_spanish_spain.
  ///
  /// In en, this message translates to:
  /// **'Spanish – Spain'**
  String get settings_spanish_spain;

  /// No description provided for @settings_spanish_colombia.
  ///
  /// In en, this message translates to:
  /// **'Spanish – Colombia'**
  String get settings_spanish_colombia;

  /// No description provided for @settings_german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get settings_german;

  /// No description provided for @settings_dutch.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get settings_dutch;

  /// No description provided for @settings_portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get settings_portuguese;

  /// No description provided for @settings_italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get settings_italian;

  /// No description provided for @settings_otherLanguages.
  ///
  /// In en, this message translates to:
  /// **'Other languages (coming soon)'**
  String get settings_otherLanguages;

  /// No description provided for @settings_availableLanguages.
  ///
  /// In en, this message translates to:
  /// **'Available languages'**
  String get settings_availableLanguages;

  /// No description provided for @settings_units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get settings_units;

  /// No description provided for @settings_metric.
  ///
  /// In en, this message translates to:
  /// **'Meter/Kilogram'**
  String get settings_metric;

  /// No description provided for @settings_imperial.
  ///
  /// In en, this message translates to:
  /// **'Inch/Pound'**
  String get settings_imperial;

  /// No description provided for @daysAgo_noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get daysAgo_noData;

  /// No description provided for @daysAgo_lessThanOneHour.
  ///
  /// In en, this message translates to:
  /// **'<1 hour ago'**
  String get daysAgo_lessThanOneHour;

  /// No description provided for @daysAgo_oneHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get daysAgo_oneHourAgo;

  /// No description provided for @daysAgo_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 hour ago} other{{count} hours ago}}'**
  String daysAgo_hoursAgo(num count);

  /// No description provided for @daysAgo_oneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get daysAgo_oneDayAgo;

  /// No description provided for @daysAgo_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 day ago} other{{count} days ago}}'**
  String daysAgo_daysAgo(num count);

  /// No description provided for @daysAgo_oneWeekAgo.
  ///
  /// In en, this message translates to:
  /// **'1 week ago'**
  String get daysAgo_oneWeekAgo;

  /// No description provided for @daysAgo_weeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 week ago} other{{count} weeks ago}}'**
  String daysAgo_weeksAgo(num count);

  /// No description provided for @daysAgo_longTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'So long time ago'**
  String get daysAgo_longTimeAgo;

  /// No description provided for @confirmationDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmationDialog_title;

  /// No description provided for @deleteConfirmationDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Delete confirmation'**
  String get deleteConfirmationDialog_title;

  /// No description provided for @dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to proceed?'**
  String get dialog_content;

  /// No description provided for @dialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialog_cancel;

  /// No description provided for @dialog_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get dialog_confirm;

  /// No description provided for @dialog_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get dialog_save;

  /// No description provided for @inputFormField_labelText.
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get inputFormField_labelText;

  /// No description provided for @inputFormField_invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid value. Please enter a number.'**
  String get inputFormField_invalidValue;

  /// No description provided for @addPattern_title.
  ///
  /// In en, this message translates to:
  /// **'Add New Color Palette'**
  String get addPattern_title;

  /// No description provided for @addPattern_iconsText.
  ///
  /// In en, this message translates to:
  /// **'This is how icons and text will look in this color'**
  String get addPattern_iconsText;

  /// No description provided for @addPattern_textExample.
  ///
  /// In en, this message translates to:
  /// **'And this is how the text will look in a different shade'**
  String get addPattern_textExample;

  /// No description provided for @addPattern_backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get addPattern_backgroundColor;

  /// No description provided for @addPattern_sectionColor.
  ///
  /// In en, this message translates to:
  /// **'Section Color'**
  String get addPattern_sectionColor;

  /// No description provided for @addPattern_textIconsColor.
  ///
  /// In en, this message translates to:
  /// **'Text and Icon Color'**
  String get addPattern_textIconsColor;

  /// No description provided for @addPattern_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get addPattern_save;

  /// No description provided for @addPattern_moreColors.
  ///
  /// In en, this message translates to:
  /// **'More colors'**
  String get addPattern_moreColors;

  /// No description provided for @customizeApp_availableColorPalettes.
  ///
  /// In en, this message translates to:
  /// **'Available themes'**
  String get customizeApp_availableColorPalettes;

  /// No description provided for @customizeApp_currentTheme.
  ///
  /// In en, this message translates to:
  /// **'Currently Set Theme'**
  String get customizeApp_currentTheme;

  /// No description provided for @customizeApp_setTheme.
  ///
  /// In en, this message translates to:
  /// **'Set Theme'**
  String get customizeApp_setTheme;

  /// No description provided for @customizeApp_deleteTheme.
  ///
  /// In en, this message translates to:
  /// **'Delete Theme'**
  String get customizeApp_deleteTheme;

  /// No description provided for @customizeApp_confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this theme?'**
  String get customizeApp_confirmDelete;

  /// No description provided for @customizeApp_applyTheme.
  ///
  /// In en, this message translates to:
  /// **'Apply Theme'**
  String get customizeApp_applyTheme;

  /// No description provided for @savePalette_saveTheme.
  ///
  /// In en, this message translates to:
  /// **'Save Theme'**
  String get savePalette_saveTheme;

  /// No description provided for @savePalette_themeSaved.
  ///
  /// In en, this message translates to:
  /// **'The theme \"{name}\" has been saved. Go back to the previous screen to apply it.'**
  String savePalette_themeSaved(Object name);

  /// No description provided for @savePalette_themeName.
  ///
  /// In en, this message translates to:
  /// **'Theme Name'**
  String get savePalette_themeName;

  /// No description provided for @fullColorPicker_chooseColor.
  ///
  /// In en, this message translates to:
  /// **'Choose color'**
  String get fullColorPicker_chooseColor;

  /// No description provided for @fullColorPicker_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get fullColorPicker_save;

  /// No description provided for @applyNewTheme.
  ///
  /// In en, this message translates to:
  /// **'New theme applied'**
  String get applyNewTheme;

  /// No description provided for @calculator1RM_title.
  ///
  /// In en, this message translates to:
  /// **'1RM Calculator'**
  String get calculator1RM_title;

  /// No description provided for @calculator1RM_infoText.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields below to see the 1RM result'**
  String get calculator1RM_infoText;

  /// No description provided for @calculator1RM_weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get calculator1RM_weightLabel;

  /// No description provided for @calculator1RM_repsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get calculator1RM_repsLabel;

  /// No description provided for @calculator1RM_ResultKg.
  ///
  /// In en, this message translates to:
  /// **'Your 1RM is: {value} kg, which also corresponds to performing:'**
  String calculator1RM_ResultKg(Object value);

  /// No description provided for @calculator1RM_ResultLbs.
  ///
  /// In en, this message translates to:
  /// **'Your 1RM is: {value} lbs, which also corresponds to performing:'**
  String calculator1RM_ResultLbs(Object value);

  /// No description provided for @calculator1RM_table_header_percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get calculator1RM_table_header_percentage;

  /// No description provided for @calculator1RM_table_header_reps.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get calculator1RM_table_header_reps;

  /// No description provided for @calculator1RM_table_header_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get calculator1RM_table_header_weight;

  /// No description provided for @infoDialog1RM_title.
  ///
  /// In en, this message translates to:
  /// **'About 1RM Calculator'**
  String get infoDialog1RM_title;

  /// No description provided for @infoDialog1RM_description.
  ///
  /// In en, this message translates to:
  /// **'The 1RM calculator estimates the maximum weight you can lift for one repetition based on the weight and number of reps completed in a set. The formula used is the popular Brzycki formula.'**
  String get infoDialog1RM_description;

  /// No description provided for @infoDialog1RM_closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get infoDialog1RM_closeButton;

  /// No description provided for @bmrResults_title.
  ///
  /// In en, this message translates to:
  /// **'Your BMR by Activity Level:'**
  String get bmrResults_title;

  /// No description provided for @bmrResults_noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get bmrResults_noData;

  /// No description provided for @bmrResults_proteinOnlyGrams.
  ///
  /// In en, this message translates to:
  /// **'approx. {min}–{max}g of protein per day'**
  String bmrResults_proteinOnlyGrams(Object max, Object min);

  /// No description provided for @basicActivity.
  ///
  /// In en, this message translates to:
  /// **'Basal Metabolic Rate'**
  String get basicActivity;

  /// No description provided for @lowActivity.
  ///
  /// In en, this message translates to:
  /// **'Low activity'**
  String get lowActivity;

  /// No description provided for @moderateActivity.
  ///
  /// In en, this message translates to:
  /// **'Moderate activity'**
  String get moderateActivity;

  /// No description provided for @highActivity.
  ///
  /// In en, this message translates to:
  /// **'High activity'**
  String get highActivity;

  /// No description provided for @veryHighActivity.
  ///
  /// In en, this message translates to:
  /// **'Very high activity'**
  String get veryHighActivity;

  /// No description provided for @calculatorBmr_title.
  ///
  /// In en, this message translates to:
  /// **'BMR Calculator'**
  String get calculatorBmr_title;

  /// No description provided for @calculatorBmr_weight_label_metric.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get calculatorBmr_weight_label_metric;

  /// No description provided for @calculatorBmr_height_label_metric.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get calculatorBmr_height_label_metric;

  /// No description provided for @calculatorBmr_weight_label_imperial.
  ///
  /// In en, this message translates to:
  /// **'Weight (lbs)'**
  String get calculatorBmr_weight_label_imperial;

  /// No description provided for @calculatorBmr_height_label_imperial_feet.
  ///
  /// In en, this message translates to:
  /// **'Height (ft)'**
  String get calculatorBmr_height_label_imperial_feet;

  /// No description provided for @calculatorBmr_height_label_imperial_inches.
  ///
  /// In en, this message translates to:
  /// **'Height (in)'**
  String get calculatorBmr_height_label_imperial_inches;

  /// No description provided for @calculatorBmr_age_label.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get calculatorBmr_age_label;

  /// No description provided for @calculatorBmr_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get calculatorBmr_male;

  /// No description provided for @calculatorBmr_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get calculatorBmr_female;

  /// No description provided for @calculatorBmr_info.
  ///
  /// In en, this message translates to:
  /// **'Fill in all the fields below to see the BMR result'**
  String get calculatorBmr_info;

  /// No description provided for @bmrInfo_title.
  ///
  /// In en, this message translates to:
  /// **'BMR and Protein Information:'**
  String get bmrInfo_title;

  /// No description provided for @bmrInfo_text1.
  ///
  /// In en, this message translates to:
  /// **'BMR (Basal Metabolic Rate) is a measure of how many calories your body needs at rest to maintain basic life functions.'**
  String get bmrInfo_text1;

  /// No description provided for @bmrInfo_text2.
  ///
  /// In en, this message translates to:
  /// **'Activity level affects the BMR value. Higher activity means a higher calorie requirement.'**
  String get bmrInfo_text2;

  /// No description provided for @bmrInfo_recommended.
  ///
  /// In en, this message translates to:
  /// **'The recommended PROTEIN intake depends on the level of physical activity, and here are the ranges based on activity level:'**
  String get bmrInfo_recommended;

  /// No description provided for @bmrInfo_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get bmrInfo_close;

  /// No description provided for @perKilogram.
  ///
  /// In en, this message translates to:
  /// **'per kilogram of body weight'**
  String get perKilogram;

  /// No description provided for @perPound.
  ///
  /// In en, this message translates to:
  /// **'per pound of body weight'**
  String get perPound;

  /// No description provided for @plateCalculator_plateCalculator.
  ///
  /// In en, this message translates to:
  /// **'Barbell plate calculator'**
  String get plateCalculator_plateCalculator;

  /// No description provided for @plateCalculator_clickToSeePlates.
  ///
  /// In en, this message translates to:
  /// **'Click to see suggested plates'**
  String get plateCalculator_clickToSeePlates;

  /// No description provided for @plateCalculator_fillOutData.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields below to see the required weight per side. The TOTAL WEIGHT must be greater than the BARBELL WEIGHT.'**
  String get plateCalculator_fillOutData;

  /// No description provided for @plateCalculator_selectPlates.
  ///
  /// In en, this message translates to:
  /// **'Select available plates:'**
  String get plateCalculator_selectPlates;

  /// No description provided for @plateCalculator_barbellWeightLabelKg.
  ///
  /// In en, this message translates to:
  /// **'Barbell (kg)'**
  String get plateCalculator_barbellWeightLabelKg;

  /// No description provided for @plateCalculator_barbellWeightLabelLbs.
  ///
  /// In en, this message translates to:
  /// **'Barbell (lbs)'**
  String get plateCalculator_barbellWeightLabelLbs;

  /// No description provided for @plateCalculator_totalWeightLabelKg.
  ///
  /// In en, this message translates to:
  /// **'TOTAL (kg)'**
  String get plateCalculator_totalWeightLabelKg;

  /// No description provided for @plateCalculator_totalWeightLabelLbs.
  ///
  /// In en, this message translates to:
  /// **'TOTAL (lbs)'**
  String get plateCalculator_totalWeightLabelLbs;

  /// No description provided for @plateCalculator_weightOnSideKg.
  ///
  /// In en, this message translates to:
  /// **'Weight per side: {weight} kg'**
  String plateCalculator_weightOnSideKg(Object weight);

  /// No description provided for @plateCalculator_weightOnSideLbs.
  ///
  /// In en, this message translates to:
  /// **'Weight per side: {weight} lbs'**
  String plateCalculator_weightOnSideLbs(Object weight);

  /// No description provided for @plateCalculator_plateSizeKg.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg'**
  String plateCalculator_plateSizeKg(Object weight);

  /// No description provided for @plateCalculator_plateSizeLbs.
  ///
  /// In en, this message translates to:
  /// **'{weight} lbs'**
  String plateCalculator_plateSizeLbs(Object weight);

  /// No description provided for @plateDialog_proposedPlates.
  ///
  /// In en, this message translates to:
  /// **'Proposed Plates'**
  String get plateDialog_proposedPlates;

  /// No description provided for @plateDialog_forSide.
  ///
  /// In en, this message translates to:
  /// **'PER SIDE'**
  String get plateDialog_forSide;

  /// No description provided for @plateDialog_option.
  ///
  /// In en, this message translates to:
  /// **'Option {optionNumber}:'**
  String plateDialog_option(Object optionNumber);

  /// No description provided for @plateDialog_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get plateDialog_close;

  /// No description provided for @plateDialog_invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Target weight must be greater than barbell weight'**
  String get plateDialog_invalidWeight;

  /// No description provided for @plateDialog_invalidTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target weight is less than barbell weight'**
  String get plateDialog_invalidTargetWeight;

  /// No description provided for @plateDialog_noCombinationFound.
  ///
  /// In en, this message translates to:
  /// **'No valid plate combination could be found for the selected weight'**
  String get plateDialog_noCombinationFound;

  /// No description provided for @measurementTile_noData.
  ///
  /// In en, this message translates to:
  /// **'No data yet. Press \'Measure\' to add a new entry.'**
  String get measurementTile_noData;

  /// No description provided for @measurementTile_addData.
  ///
  /// In en, this message translates to:
  /// **'Measure'**
  String get measurementTile_addData;

  /// No description provided for @measurementTile_baseline.
  ///
  /// In en, this message translates to:
  /// **'Baseline'**
  String get measurementTile_baseline;

  /// No description provided for @measurementTile_deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get measurementTile_deleteCategory;

  /// No description provided for @measurementTile_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get measurementTile_today;

  /// No description provided for @measurementTile_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get measurementTile_yesterday;

  /// No description provided for @measurementTracker_body_measurements.
  ///
  /// In en, this message translates to:
  /// **'Body measurements'**
  String get measurementTracker_body_measurements;

  /// No description provided for @measurementTracker_no_data_to_show.
  ///
  /// In en, this message translates to:
  /// **'No data to show'**
  String get measurementTracker_no_data_to_show;

  /// No description provided for @measurementTracker_add_new_category.
  ///
  /// In en, this message translates to:
  /// **'Add new category'**
  String get measurementTracker_add_new_category;

  /// No description provided for @measurementTracker_name_new_category.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get measurementTracker_name_new_category;

  /// No description provided for @measurementTracker_name_new_measurement.
  ///
  /// In en, this message translates to:
  /// **'Measurement value'**
  String get measurementTracker_name_new_measurement;

  /// No description provided for @measurementTracker_add_new_measurement.
  ///
  /// In en, this message translates to:
  /// **'Add new measurement'**
  String get measurementTracker_add_new_measurement;

  /// No description provided for @measurementTracker_update_category.
  ///
  /// In en, this message translates to:
  /// **'Update Category'**
  String get measurementTracker_update_category;

  /// No description provided for @measurementTracker_delete_category_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get measurementTracker_delete_category_confirmation;

  /// No description provided for @measurementTracker_delete_measurement_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this measurement?'**
  String get measurementTracker_delete_measurement_confirmation;

  /// No description provided for @measurementTracker_measurement_deleted.
  ///
  /// In en, this message translates to:
  /// **'Measurement for \'{bodyPart}\' deleted.'**
  String measurementTracker_measurement_deleted(Object bodyPart);

  /// No description provided for @measurementTracker_category_deleted.
  ///
  /// In en, this message translates to:
  /// **'Category \'{category}\' deleted.'**
  String measurementTracker_category_deleted(Object category);

  /// No description provided for @measurementTracker_category_exists.
  ///
  /// In en, this message translates to:
  /// **'This category already exists!'**
  String get measurementTracker_category_exists;

  /// No description provided for @measurementTracker_invalid_value.
  ///
  /// In en, this message translates to:
  /// **'Invalid value!'**
  String get measurementTracker_invalid_value;

  /// No description provided for @measurementTracker_invalid_category.
  ///
  /// In en, this message translates to:
  /// **'Invalid category selected!'**
  String get measurementTracker_invalid_category;

  /// No description provided for @measurementTracker_add_category_hint.
  ///
  /// In en, this message translates to:
  /// **'You can add a new category using the button below.'**
  String get measurementTracker_add_category_hint;

  /// No description provided for @measurementTracker_measurementDate.
  ///
  /// In en, this message translates to:
  /// **'Measurement Date'**
  String get measurementTracker_measurementDate;

  /// No description provided for @weightTracker_title.
  ///
  /// In en, this message translates to:
  /// **'Weight Tracker'**
  String get weightTracker_title;

  /// No description provided for @weightTracker_enterWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Enter weight (kg)'**
  String get weightTracker_enterWeightKg;

  /// No description provided for @weightTracker_enterWeightLbs.
  ///
  /// In en, this message translates to:
  /// **'Enter weight (lbs)'**
  String get weightTracker_enterWeightLbs;

  /// No description provided for @weightTracker_saveWeight.
  ///
  /// In en, this message translates to:
  /// **'Save Weight'**
  String get weightTracker_saveWeight;

  /// No description provided for @weightTracker_updateWeight.
  ///
  /// In en, this message translates to:
  /// **'Update Weight'**
  String get weightTracker_updateWeight;

  /// No description provided for @weightTracker_yourWeight.
  ///
  /// In en, this message translates to:
  /// **'Your weight'**
  String get weightTracker_yourWeight;

  /// No description provided for @weightTracker_daysAgo.
  ///
  /// In en, this message translates to:
  /// **' ({daysAgo} ago)'**
  String weightTracker_daysAgo(Object daysAgo);

  /// No description provided for @weightTracker_legendWeightSaved.
  ///
  /// In en, this message translates to:
  /// **'Days with saved weight'**
  String get weightTracker_legendWeightSaved;

  /// No description provided for @drawer_tools_section.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get drawer_tools_section;

  /// No description provided for @drawer_calculators_section.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get drawer_calculators_section;

  /// No description provided for @drawer_oneRepMax.
  ///
  /// In en, this message translates to:
  /// **'One Rep Max'**
  String get drawer_oneRepMax;

  /// No description provided for @drawer_bmr.
  ///
  /// In en, this message translates to:
  /// **'BMR'**
  String get drawer_bmr;

  /// No description provided for @drawer_platesOnBarbell.
  ///
  /// In en, this message translates to:
  /// **'Plates on barbell'**
  String get drawer_platesOnBarbell;

  /// No description provided for @drawer_time_section.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get drawer_time_section;

  /// No description provided for @drawer_stopwatch.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch'**
  String get drawer_stopwatch;

  /// No description provided for @drawer_trackers_section.
  ///
  /// In en, this message translates to:
  /// **'Trackers'**
  String get drawer_trackers_section;

  /// No description provided for @drawer_weightTracker.
  ///
  /// In en, this message translates to:
  /// **'Weight tracker'**
  String get drawer_weightTracker;

  /// No description provided for @drawer_measurementTracker.
  ///
  /// In en, this message translates to:
  /// **'Measurement tracker'**
  String get drawer_measurementTracker;

  /// No description provided for @drawer_settings_section.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawer_settings_section;

  /// No description provided for @drawer_customizeApp.
  ///
  /// In en, this message translates to:
  /// **'Customize app'**
  String get drawer_customizeApp;

  /// No description provided for @drawer_appLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get drawer_appLanguage;

  /// No description provided for @drawer_notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get drawer_notificationSettings;

  /// No description provided for @drawer_appreciation_section.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get drawer_appreciation_section;

  /// No description provided for @drawer_supportButton.
  ///
  /// In en, this message translates to:
  /// **'Make a donation'**
  String get drawer_supportButton;

  /// No description provided for @drawer_watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch ad'**
  String get drawer_watchAd;

  /// No description provided for @drawer_shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get drawer_shareApp;

  /// No description provided for @drawer_noteCount.
  ///
  /// In en, this message translates to:
  /// **'Number of saved notes: '**
  String get drawer_noteCount;

  /// No description provided for @drawer_guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get drawer_guest;

  /// No description provided for @drawer_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get drawer_privacyPolicy;

  /// No description provided for @drawer_termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get drawer_termsOfUse;

  /// No description provided for @searchDrawer_hint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchDrawer_hint;

  /// No description provided for @searchDrawer_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get searchDrawer_clear;

  /// No description provided for @addExerciseDialog_title.
  ///
  /// In en, this message translates to:
  /// **'Add new exercise'**
  String get addExerciseDialog_title;

  /// No description provided for @addExerciseDialog_label.
  ///
  /// In en, this message translates to:
  /// **'Enter exercise name'**
  String get addExerciseDialog_label;

  /// No description provided for @addExerciseDialog_success.
  ///
  /// In en, this message translates to:
  /// **'Exercise \"{exerciseName}\" added successfully'**
  String addExerciseDialog_success(Object exerciseName);

  /// No description provided for @addExerciseDialog_anotherTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Another Exercise?'**
  String get addExerciseDialog_anotherTitle;

  /// No description provided for @addExerciseDialog_anotherContent.
  ///
  /// In en, this message translates to:
  /// **'Would you like to add another exercise?'**
  String get addExerciseDialog_anotherContent;

  /// No description provided for @addWorkoutPlan_title.
  ///
  /// In en, this message translates to:
  /// **'Add Workout Plan'**
  String get addWorkoutPlan_title;

  /// No description provided for @addWorkoutPlan_planName.
  ///
  /// In en, this message translates to:
  /// **'Workout Plan Name'**
  String get addWorkoutPlan_planName;

  /// No description provided for @addWorkoutPlan_selectedExercises.
  ///
  /// In en, this message translates to:
  /// **'Selected Exercises:'**
  String get addWorkoutPlan_selectedExercises;

  /// No description provided for @addWorkoutPlan_noExercises.
  ///
  /// In en, this message translates to:
  /// **'No exercises selected yet.'**
  String get addWorkoutPlan_noExercises;

  /// No description provided for @addWorkoutPlan_availableExercises.
  ///
  /// In en, this message translates to:
  /// **'Available Exercises:'**
  String get addWorkoutPlan_availableExercises;

  /// No description provided for @addWorkoutPlan_addNewExercise.
  ///
  /// In en, this message translates to:
  /// **'Add New Exercise'**
  String get addWorkoutPlan_addNewExercise;

  /// No description provided for @addWorkoutPlan_save.
  ///
  /// In en, this message translates to:
  /// **'Save Workout Plan'**
  String get addWorkoutPlan_save;

  /// No description provided for @addWorkoutPlan_missingName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a workout plan name.'**
  String get addWorkoutPlan_missingName;

  /// No description provided for @addWorkoutPlan_missingExercises.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one exercise.'**
  String get addWorkoutPlan_missingExercises;

  /// No description provided for @tabBottomDrawer_showOnly.
  ///
  /// In en, this message translates to:
  /// **'Show only:'**
  String get tabBottomDrawer_showOnly;

  /// No description provided for @tabBottomDrawer_addNewGym.
  ///
  /// In en, this message translates to:
  /// **'Add New Gym'**
  String get tabBottomDrawer_addNewGym;

  /// No description provided for @tabBottomDrawer_addNewUser.
  ///
  /// In en, this message translates to:
  /// **'Add New User'**
  String get tabBottomDrawer_addNewUser;

  /// No description provided for @tabBottomDrawer_addNewExercise.
  ///
  /// In en, this message translates to:
  /// **'Add New Exercise'**
  String get tabBottomDrawer_addNewExercise;

  /// No description provided for @tabBottomDrawer_addNewWorkoutPlan.
  ///
  /// In en, this message translates to:
  /// **'Add New Workout Plan'**
  String get tabBottomDrawer_addNewWorkoutPlan;

  /// No description provided for @tabBottomDrawer_enterGymName.
  ///
  /// In en, this message translates to:
  /// **'Enter gym name'**
  String get tabBottomDrawer_enterGymName;

  /// No description provided for @tabBottomDrawer_enterUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter user name'**
  String get tabBottomDrawer_enterUserName;

  /// No description provided for @tabBottomDrawer_enterWorkoutPlanName.
  ///
  /// In en, this message translates to:
  /// **'Enter workout plan name'**
  String get tabBottomDrawer_enterWorkoutPlanName;

  /// No description provided for @tabBottomDrawer_editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get tabBottomDrawer_editTitle;

  /// No description provided for @tabBottomDrawer_editExercise.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get tabBottomDrawer_editExercise;

  /// No description provided for @tabBottomDrawer_editLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter new name'**
  String get tabBottomDrawer_editLabel;

  /// No description provided for @tabBottomDrawer_refreshScreen.
  ///
  /// In en, this message translates to:
  /// **'Refresh the screen to see the changes'**
  String get tabBottomDrawer_refreshScreen;

  /// No description provided for @tabSector_gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get tabSector_gym;

  /// No description provided for @tabSector_user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get tabSector_user;

  /// No description provided for @tabSector_exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get tabSector_exercise;

  /// No description provided for @tabSector_workoutPlan.
  ///
  /// In en, this message translates to:
  /// **'Workout plan'**
  String get tabSector_workoutPlan;

  /// No description provided for @tabSector_userGym.
  ///
  /// In en, this message translates to:
  /// **'User & Gym'**
  String get tabSector_userGym;

  /// No description provided for @tabSector_filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get tabSector_filter;

  /// No description provided for @sortSector_aToZ.
  ///
  /// In en, this message translates to:
  /// **'A ... Z'**
  String get sortSector_aToZ;

  /// No description provided for @sortSector_zToA.
  ///
  /// In en, this message translates to:
  /// **'Z ... A'**
  String get sortSector_zToA;

  /// No description provided for @sortSector_newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortSector_newest;

  /// No description provided for @sortSector_oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get sortSector_oldest;

  /// No description provided for @sortSector_exerciseView.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get sortSector_exerciseView;

  /// No description provided for @sortSector_historyView.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get sortSector_historyView;

  /// No description provided for @historyView_noWorkouts.
  ///
  /// In en, this message translates to:
  /// **'No workouts available'**
  String get historyView_noWorkouts;

  /// No description provided for @historyView_exerciseNotFound.
  ///
  /// In en, this message translates to:
  /// **'Exercise Not Found'**
  String get historyView_exerciseNotFound;

  /// No description provided for @historyView_noWorkoutNotesMessage.
  ///
  /// In en, this message translates to:
  /// **'This section will display notes from your workouts'**
  String get historyView_noWorkoutNotesMessage;

  /// No description provided for @historyView_noWorkoutNotesFilteredMessage.
  ///
  /// In en, this message translates to:
  /// **'No results match your filters.'**
  String get historyView_noWorkoutNotesFilteredMessage;

  /// No description provided for @notes_justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notes_justNow;

  /// No description provided for @notes_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String notes_minutesAgo(Object count);

  /// No description provided for @notes_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String notes_hoursAgo(Object count);

  /// No description provided for @notes_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String notes_daysAgo(Object count);

  /// No description provided for @notes_invalidDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get notes_invalidDate;

  /// No description provided for @notes_showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get notes_showMore;

  /// No description provided for @notes_showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get notes_showLess;

  /// No description provided for @notes_deleteNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Note'**
  String get notes_deleteNoteTitle;

  /// No description provided for @notes_deleteNoteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get notes_deleteNoteConfirm;

  /// No description provided for @notes_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy note'**
  String get notes_copy;

  /// No description provided for @notes_copied.
  ///
  /// In en, this message translates to:
  /// **'Note copied to clipboard'**
  String get notes_copied;

  /// No description provided for @exerciseView_sortDesc.
  ///
  /// In en, this message translates to:
  /// **'Z ... A'**
  String get exerciseView_sortDesc;

  /// No description provided for @exerciseView_sortAsc.
  ///
  /// In en, this message translates to:
  /// **'A ... Z'**
  String get exerciseView_sortAsc;

  /// No description provided for @exerciseView_filteredOutExercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises not matching the filters:'**
  String get exerciseView_filteredOutExercises;

  /// No description provided for @exerciseView_noExercisesMessage.
  ///
  /// In en, this message translates to:
  /// **'Go to the \'Exercise\' section to add your first exercise.'**
  String get exerciseView_noExercisesMessage;

  /// No description provided for @iconSelection_chooseIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose exercise icon'**
  String get iconSelection_chooseIcon;

  /// No description provided for @iconSelection_exerciseName.
  ///
  /// In en, this message translates to:
  /// **'{exerciseName}'**
  String iconSelection_exerciseName(Object exerciseName);

  /// No description provided for @exerciseExpansion_addUserGym.
  ///
  /// In en, this message translates to:
  /// **'Add a user and gym to the exercise'**
  String get exerciseExpansion_addUserGym;

  /// No description provided for @exerciseExpansion_deleteExercise.
  ///
  /// In en, this message translates to:
  /// **'Delete Exercise'**
  String get exerciseExpansion_deleteExercise;

  /// No description provided for @exerciseExpansion_confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this exercise? This will also remove all data associated with this exercise.'**
  String get exerciseExpansion_confirmDelete;

  /// No description provided for @exerciseExpansion_addIcon.
  ///
  /// In en, this message translates to:
  /// **'Add an icon to the exercise'**
  String get exerciseExpansion_addIcon;

  /// No description provided for @exerciseExpansion_unknownExercise.
  ///
  /// In en, this message translates to:
  /// **'Unknown Exercise'**
  String get exerciseExpansion_unknownExercise;

  /// No description provided for @exerciseExpansion_unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get exerciseExpansion_unknownUser;

  /// No description provided for @exerciseExpansion_unknownGym.
  ///
  /// In en, this message translates to:
  /// **'Unknown Gym'**
  String get exerciseExpansion_unknownGym;

  /// No description provided for @exerciseExpansion_noWorkouts.
  ///
  /// In en, this message translates to:
  /// **'No workouts available'**
  String get exerciseExpansion_noWorkouts;

  /// No description provided for @exerciseExpansion_changeNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Change exercise name'**
  String get exerciseExpansion_changeNameTitle;

  /// No description provided for @exerciseExpansion_enterNewName.
  ///
  /// In en, this message translates to:
  /// **'Enter new exercise name'**
  String get exerciseExpansion_enterNewName;

  /// No description provided for @addUserAndGym_title.
  ///
  /// In en, this message translates to:
  /// **'Assign Exercise to User and Gym'**
  String addUserAndGym_title(Object exercise);

  /// No description provided for @addUserAndGym_selectUser.
  ///
  /// In en, this message translates to:
  /// **'Select user'**
  String get addUserAndGym_selectUser;

  /// No description provided for @addUserAndGym_selectGym.
  ///
  /// In en, this message translates to:
  /// **'Select gym'**
  String get addUserAndGym_selectGym;

  /// No description provided for @addUserAndGym_confirmSelection.
  ///
  /// In en, this message translates to:
  /// **'Confirm Selection'**
  String get addUserAndGym_confirmSelection;

  /// No description provided for @addUserAndGym_workoutExists.
  ///
  /// In en, this message translates to:
  /// **'This workout already exists for the selected user and gym.'**
  String get addUserAndGym_workoutExists;

  /// No description provided for @addUserAndGym_workoutGlobalNote.
  ///
  /// In en, this message translates to:
  /// **'Add a general note for the exercise – e.g. machine setup, grip type, technical tips, etc.'**
  String addUserAndGym_workoutGlobalNote(Object exerciseName);

  /// No description provided for @resultsExpansion_title.
  ///
  /// In en, this message translates to:
  /// **'{userName} • {gymName}'**
  String resultsExpansion_title(Object gymName, Object userName);

  /// No description provided for @resultsExpansion_lastNoteDate.
  ///
  /// In en, this message translates to:
  /// **'Last note: {date}'**
  String resultsExpansion_lastNoteDate(Object date);

  /// No description provided for @resultsExpansion_quickValue.
  ///
  /// In en, this message translates to:
  /// **'Set Quick Value'**
  String get resultsExpansion_quickValue;

  /// No description provided for @resultsExpansion_quickValueSet.
  ///
  /// In en, this message translates to:
  /// **'e.g. training goal or best set'**
  String get resultsExpansion_quickValueSet;

  /// No description provided for @resultsExpansion_deleteWorkoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this section along with all its results?'**
  String get resultsExpansion_deleteWorkoutConfirmation;

  /// No description provided for @notes_title.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get notes_title;

  /// No description provided for @notes_addNote.
  ///
  /// In en, this message translates to:
  /// **'+ Add Note'**
  String get notes_addNote;

  /// No description provided for @notes_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get notes_cancel;

  /// No description provided for @notes_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your note...'**
  String get notes_hint;

  /// No description provided for @notes_saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get notes_saveNote;

  /// No description provided for @notes_updateNote.
  ///
  /// In en, this message translates to:
  /// **'Update Note'**
  String get notes_updateNote;

  /// No description provided for @notes_empty.
  ///
  /// In en, this message translates to:
  /// **'No notes available'**
  String get notes_empty;

  /// No description provided for @notes_emptyNote.
  ///
  /// In en, this message translates to:
  /// **'No note'**
  String get notes_emptyNote;

  /// No description provided for @globalNote_title.
  ///
  /// In en, this message translates to:
  /// **'Global Note'**
  String get globalNote_title;

  /// No description provided for @globalNote_empty.
  ///
  /// In en, this message translates to:
  /// **'No note...'**
  String get globalNote_empty;

  /// No description provided for @globalNote_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your note'**
  String get globalNote_hint;

  /// No description provided for @notificationScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationScreen_title;

  /// No description provided for @notificationScreen_permissionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Click here to enable editable notifications'**
  String get notificationScreen_permissionTooltip;

  /// No description provided for @notificationList_title.
  ///
  /// In en, this message translates to:
  /// **'Saved notifications:'**
  String get notificationList_title;

  /// No description provided for @notificationList_empty.
  ///
  /// In en, this message translates to:
  /// **'No saved notifications.'**
  String get notificationList_empty;

  /// No description provided for @notificationList_hour.
  ///
  /// In en, this message translates to:
  /// **'Time: {time}'**
  String notificationList_hour(Object time);

  /// No description provided for @notificationList_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get notificationList_daily;

  /// No description provided for @notificationList_interval.
  ///
  /// In en, this message translates to:
  /// **'Every {days} days'**
  String notificationList_interval(Object days);

  /// No description provided for @notificationList_weekly_none.
  ///
  /// In en, this message translates to:
  /// **'No days'**
  String get notificationList_weekly_none;

  /// No description provided for @notificationList_type_training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get notificationList_type_training;

  /// No description provided for @notificationList_type_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get notificationList_type_weight;

  /// No description provided for @notificationList_type_measurement.
  ///
  /// In en, this message translates to:
  /// **'Measurement'**
  String get notificationList_type_measurement;

  /// No description provided for @notificationList_type_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get notificationList_type_custom;

  /// No description provided for @notificationList_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get notificationList_confirm_title;

  /// No description provided for @notificationList_confirm_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this notification?'**
  String get notificationList_confirm_content;

  /// No description provided for @notificationList_deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get notificationList_deleteAll;

  /// No description provided for @notificationList_confirmAll_title.
  ///
  /// In en, this message translates to:
  /// **'Delete all notifications?'**
  String get notificationList_confirmAll_title;

  /// No description provided for @notificationList_confirmAll_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all saved notifications?'**
  String get notificationList_confirmAll_content;

  /// No description provided for @notificationForm_titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification title:'**
  String get notificationForm_titleLabel;

  /// No description provided for @notificationForm_titleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your custom notification title...'**
  String get notificationForm_titleHint;

  /// No description provided for @notificationForm_messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification message:'**
  String get notificationForm_messageLabel;

  /// No description provided for @notificationForm_messageHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your custom notification message...'**
  String get notificationForm_messageHint;

  /// No description provided for @notificationForm_addNotification.
  ///
  /// In en, this message translates to:
  /// **'Add notification'**
  String get notificationForm_addNotification;

  /// No description provided for @notificationForm_added.
  ///
  /// In en, this message translates to:
  /// **'Notification added!'**
  String get notificationForm_added;

  /// No description provided for @notificationForm_typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder:'**
  String get notificationForm_typeLabel;

  /// No description provided for @notificationForm_typeTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get notificationForm_typeTraining;

  /// No description provided for @notificationForm_typeWeight.
  ///
  /// In en, this message translates to:
  /// **'Weigh-in'**
  String get notificationForm_typeWeight;

  /// No description provided for @notificationForm_typeMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Body measurement'**
  String get notificationForm_typeMeasurement;

  /// No description provided for @notificationForm_typeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get notificationForm_typeCustom;

  /// No description provided for @notificationForm_modeLabel.
  ///
  /// In en, this message translates to:
  /// **'Schedule:'**
  String get notificationForm_modeLabel;

  /// No description provided for @notificationForm_modeDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get notificationForm_modeDaily;

  /// No description provided for @notificationForm_modeInterval.
  ///
  /// In en, this message translates to:
  /// **'Every X days'**
  String get notificationForm_modeInterval;

  /// No description provided for @notificationForm_modeWeekly.
  ///
  /// In en, this message translates to:
  /// **'Selected weekdays'**
  String get notificationForm_modeWeekly;

  /// No description provided for @notificationForm_intervalPrefix.
  ///
  /// In en, this message translates to:
  /// **'Every'**
  String get notificationForm_intervalPrefix;

  /// No description provided for @notificationForm_intervalSuffix.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get notificationForm_intervalSuffix;

  /// No description provided for @notificationForm_weekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get notificationForm_weekdayMon;

  /// No description provided for @notificationForm_weekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get notificationForm_weekdayTue;

  /// No description provided for @notificationForm_weekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get notificationForm_weekdayWed;

  /// No description provided for @notificationForm_weekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get notificationForm_weekdayThu;

  /// No description provided for @notificationForm_weekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get notificationForm_weekdayFri;

  /// No description provided for @notificationForm_weekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get notificationForm_weekdaySat;

  /// No description provided for @notificationForm_weekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get notificationForm_weekdaySun;

  /// No description provided for @notificationForm_defaultTitleTraining.
  ///
  /// In en, this message translates to:
  /// **'Workout time!'**
  String get notificationForm_defaultTitleTraining;

  /// No description provided for @notificationForm_defaultMessageTraining.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget your physical activity.'**
  String get notificationForm_defaultMessageTraining;

  /// No description provided for @notificationForm_defaultTitleWeight.
  ///
  /// In en, this message translates to:
  /// **'Check your weight'**
  String get notificationForm_defaultTitleWeight;

  /// No description provided for @notificationForm_defaultMessageWeight.
  ///
  /// In en, this message translates to:
  /// **'Time to weigh yourself. Log it in the app.'**
  String get notificationForm_defaultMessageWeight;

  /// No description provided for @notificationForm_defaultTitleMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Take measurements'**
  String get notificationForm_defaultTitleMeasurement;

  /// No description provided for @notificationForm_defaultMessageMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Time to measure your body. Track your progress!'**
  String get notificationForm_defaultMessageMeasurement;

  /// No description provided for @notificationForm_testNotification.
  ///
  /// In en, this message translates to:
  /// **'Test notification'**
  String get notificationForm_testNotification;

  /// No description provided for @timePicker_label.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timePicker_label;

  /// No description provided for @watchAds_title.
  ///
  /// In en, this message translates to:
  /// **'Watch Ads to Support'**
  String get watchAds_title;

  /// No description provided for @watchAds_description.
  ///
  /// In en, this message translates to:
  /// **'Watch short video ads to support us without spending money'**
  String get watchAds_description;

  /// No description provided for @watchAds_button.
  ///
  /// In en, this message translates to:
  /// **'Watch Ad'**
  String get watchAds_button;

  /// No description provided for @watchAds_counter.
  ///
  /// In en, this message translates to:
  /// **'Ads Watched:'**
  String get watchAds_counter;

  /// No description provided for @watchAds_error.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support! Unfortunately, the ad could not be loaded'**
  String get watchAds_error;

  /// No description provided for @shareApp_title.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp_title;

  /// No description provided for @shareApp_inviteTitle.
  ///
  /// In en, this message translates to:
  /// **'Share this app with your friends and family!'**
  String get shareApp_inviteTitle;

  /// No description provided for @shareApp_inviteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us grow our community by sharing this app with people who might find it useful.'**
  String get shareApp_inviteSubtitle;

  /// No description provided for @shareApp_shareText.
  ///
  /// In en, this message translates to:
  /// **'Check out this app:'**
  String get shareApp_shareText;

  /// No description provided for @shareApp_shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share with...'**
  String get shareApp_shareButton;

  /// No description provided for @shareApp_linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied to clipboard'**
  String get shareApp_linkCopied;

  /// No description provided for @shareApp_ratingTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying GoGymSimple?'**
  String get shareApp_ratingTitle;

  /// No description provided for @shareApp_ratingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Would you like to rate GoGymSimple? Your review helps others discover the app.'**
  String get shareApp_ratingSubtitle;

  /// No description provided for @shareApp_ratingYes.
  ///
  /// In en, this message translates to:
  /// **'Sure!'**
  String get shareApp_ratingYes;

  /// No description provided for @donate_title.
  ///
  /// In en, this message translates to:
  /// **'Support Us'**
  String get donate_title;

  /// No description provided for @donateSections_whyTitle.
  ///
  /// In en, this message translates to:
  /// **'Why Support Us?'**
  String get donateSections_whyTitle;

  /// No description provided for @donateSections_whyDesc.
  ///
  /// In en, this message translates to:
  /// **'Your donations help us maintain and improve this project. All contributions are voluntary and don’t unlock any special features or content.'**
  String get donateSections_whyDesc;

  /// No description provided for @donateSections_monthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get donateSections_monthlyTitle;

  /// No description provided for @donateSections_monthlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Support us with a recurring monthly donation'**
  String get donateSections_monthlyDesc;

  /// No description provided for @donateSections_monthlyButton.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Monthly'**
  String get donateSections_monthlyButton;

  /// No description provided for @donateSections_oneTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'One-Time Donation'**
  String get donateSections_oneTimeTitle;

  /// No description provided for @donateSections_oneTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Make a single contribution of your chosen amount'**
  String get donateSections_oneTimeDesc;

  /// No description provided for @donateSections_oneTimeButton.
  ///
  /// In en, this message translates to:
  /// **'Donate Now'**
  String get donateSections_oneTimeButton;

  /// No description provided for @donateSections_voluntaryTitle.
  ///
  /// In en, this message translates to:
  /// **'100% Voluntary'**
  String get donateSections_voluntaryTitle;

  /// No description provided for @donateSections_storeUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Store unavailable. Check your internet connection'**
  String get donateSections_storeUnavailableMessage;

  /// No description provided for @donateSections_voluntaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Remember, all donations are completely voluntary. You will not receive any special features or content for your contribution – just our sincere gratitude for supporting this project.'**
  String get donateSections_voluntaryDesc;

  /// No description provided for @welcomeExerciseStep_favoriteExercises.
  ///
  /// In en, this message translates to:
  /// **'Favorite Exercises'**
  String get welcomeExerciseStep_favoriteExercises;

  /// No description provided for @welcomeExerciseStep_selectFew.
  ///
  /// In en, this message translates to:
  /// **'Select a few exercises to get started with'**
  String get welcomeExerciseStep_selectFew;

  /// No description provided for @welcomeExerciseStep_addYourOwn.
  ///
  /// In en, this message translates to:
  /// **'Add your own exercise'**
  String get welcomeExerciseStep_addYourOwn;

  /// No description provided for @welcomeExerciseStep_exampleExercise.
  ///
  /// In en, this message translates to:
  /// **'e.g. Bulgarian Split Squat'**
  String get welcomeExerciseStep_exampleExercise;

  /// No description provided for @welcomeExerciseStep_addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get welcomeExerciseStep_addButton;

  /// No description provided for @welcomeExerciseStep_nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeExerciseStep_nextButton;

  /// No description provided for @welcomeGymLocationStep_workoutPreferences.
  ///
  /// In en, this message translates to:
  /// **'Workout Preferences'**
  String get welcomeGymLocationStep_workoutPreferences;

  /// No description provided for @welcomeGymLocationStep_whereDoYouTrain.
  ///
  /// In en, this message translates to:
  /// **'Where do you usually train?'**
  String get welcomeGymLocationStep_whereDoYouTrain;

  /// No description provided for @welcomeGymLocationStep_homeWorkout.
  ///
  /// In en, this message translates to:
  /// **'Home Workout'**
  String get welcomeGymLocationStep_homeWorkout;

  /// No description provided for @welcomeGymLocationStep_gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get welcomeGymLocationStep_gym;

  /// No description provided for @welcomeGymLocationStep_gymNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Gym Name {index}'**
  String welcomeGymLocationStep_gymNameLabel(Object index);

  /// No description provided for @welcomeGymLocationStep_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeGymLocationStep_next;

  /// No description provided for @welcomeIntroSteps_welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to GoGymSimple'**
  String get welcomeIntroSteps_welcomeTitle;

  /// No description provided for @welcomeIntroSteps_welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your profile to get started with your app journey'**
  String get welcomeIntroSteps_welcomeSubtitle;

  /// No description provided for @welcomeIntroSteps_getStartedButton.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeIntroSteps_getStartedButton;

  /// No description provided for @welcomeIntroSteps_personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get welcomeIntroSteps_personalInfoTitle;

  /// No description provided for @welcomeIntroSteps_yourNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get welcomeIntroSteps_yourNameLabel;

  /// No description provided for @welcomeIntroSteps_nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeIntroSteps_nextButton;

  /// No description provided for @welcomeSettingStep_appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get welcomeSettingStep_appSettings;

  /// No description provided for @welcomeSettingStep_measurementSystem.
  ///
  /// In en, this message translates to:
  /// **'Measurement System'**
  String get welcomeSettingStep_measurementSystem;

  /// No description provided for @welcomeSettingStep_metric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get welcomeSettingStep_metric;

  /// No description provided for @welcomeSettingStep_imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get welcomeSettingStep_imperial;

  /// No description provided for @welcomeSettingStep_appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get welcomeSettingStep_appTheme;

  /// No description provided for @welcomeSettingStep_enterGoGymSimple.
  ///
  /// In en, this message translates to:
  /// **'Enter GoGymSimple'**
  String get welcomeSettingStep_enterGoGymSimple;

  /// No description provided for @welcomeScreen_chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get welcomeScreen_chooseLanguage;

  /// No description provided for @welcomeScreen_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get welcomeScreen_english;

  /// No description provided for @welcomeScreen_polish.
  ///
  /// In en, this message translates to:
  /// **'Polski'**
  String get welcomeScreen_polish;

  /// No description provided for @welcomeScreen_languageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get welcomeScreen_languageTooltip;

  /// No description provided for @welcomeScreen_exercise_benchPress.
  ///
  /// In en, this message translates to:
  /// **'Bench Press'**
  String get welcomeScreen_exercise_benchPress;

  /// No description provided for @welcomeScreen_exercise_squats.
  ///
  /// In en, this message translates to:
  /// **'Squats'**
  String get welcomeScreen_exercise_squats;

  /// No description provided for @welcomeScreen_exercise_deadlift.
  ///
  /// In en, this message translates to:
  /// **'Deadlift'**
  String get welcomeScreen_exercise_deadlift;

  /// No description provided for @welcomeScreen_exercise_pullUps.
  ///
  /// In en, this message translates to:
  /// **'Pull-ups'**
  String get welcomeScreen_exercise_pullUps;

  /// No description provided for @welcomeScreen_exercise_pushUps.
  ///
  /// In en, this message translates to:
  /// **'Push-ups'**
  String get welcomeScreen_exercise_pushUps;

  /// No description provided for @welcomeScreen_exercise_lunges.
  ///
  /// In en, this message translates to:
  /// **'Lunges'**
  String get welcomeScreen_exercise_lunges;

  /// No description provided for @welcomeEnd_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to GoGymSimple'**
  String get welcomeEnd_welcome;

  /// No description provided for @stopwatch_title.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch'**
  String get stopwatch_title;

  /// No description provided for @workoutScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get workoutScreen_title;

  /// No description provided for @workoutScreen_gym.
  ///
  /// In en, this message translates to:
  /// **'Choose gym'**
  String get workoutScreen_gym;

  /// No description provided for @workoutScreen_gymAndDate.
  ///
  /// In en, this message translates to:
  /// **'Select Gym & Date'**
  String get workoutScreen_gymAndDate;

  /// No description provided for @workoutScreen_selectGymFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a gym first'**
  String get workoutScreen_selectGymFirst;

  /// No description provided for @workoutScreen_noGymSelected.
  ///
  /// In en, this message translates to:
  /// **'No gym selected'**
  String get workoutScreen_noGymSelected;

  /// No description provided for @workoutScreen_saved.
  ///
  /// In en, this message translates to:
  /// **'Workout saved!'**
  String get workoutScreen_saved;

  /// No description provided for @workoutScreen_participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get workoutScreen_participants;

  /// No description provided for @workoutScreen_plans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get workoutScreen_plans;

  /// No description provided for @workoutScreen_exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get workoutScreen_exercises;

  /// No description provided for @workoutScreen_addExercise.
  ///
  /// In en, this message translates to:
  /// **'Add Exercise'**
  String get workoutScreen_addExercise;

  /// No description provided for @workoutScreen_addNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get workoutScreen_addNote;

  /// No description provided for @workoutScreen_saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get workoutScreen_saveNote;

  /// No description provided for @workoutScreen_savedNote.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get workoutScreen_savedNote;

  /// No description provided for @workoutScreen_showMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'Show more information'**
  String get workoutScreen_showMoreInfo;

  /// No description provided for @workoutScreen_firstTime.
  ///
  /// In en, this message translates to:
  /// **'First time'**
  String get workoutScreen_firstTime;

  /// No description provided for @restoreSession_title.
  ///
  /// In en, this message translates to:
  /// **'Workout Interrupted'**
  String get restoreSession_title;

  /// No description provided for @restoreSession_info.
  ///
  /// In en, this message translates to:
  /// **'Your previous training session was interrupted.'**
  String get restoreSession_info;

  /// No description provided for @restoreSession_content.
  ///
  /// In en, this message translates to:
  /// **'Would you like to restore your progress?'**
  String get restoreSession_content;

  /// No description provided for @restoreSession_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, restore'**
  String get restoreSession_confirm;

  /// No description provided for @restoreSession_deny.
  ///
  /// In en, this message translates to:
  /// **'Start Fresh'**
  String get restoreSession_deny;

  /// No description provided for @saveWorkoutDialog_save_workout_title.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save your workout?'**
  String get saveWorkoutDialog_save_workout_title;

  /// No description provided for @saveWorkoutDialog_save_workout_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Save this workout so you can revisit it later'**
  String get saveWorkoutDialog_save_workout_subtitle;

  /// No description provided for @saveWorkoutDialog_save_workout_button.
  ///
  /// In en, this message translates to:
  /// **'Save Workout'**
  String get saveWorkoutDialog_save_workout_button;

  /// No description provided for @saveWorkoutDialog_dont_save_workout_button.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get saveWorkoutDialog_dont_save_workout_button;

  /// No description provided for @saveWorkoutDialog_support_us_title.
  ///
  /// In en, this message translates to:
  /// **'Support Us'**
  String get saveWorkoutDialog_support_us_title;

  /// No description provided for @saveWorkoutDialog_support_us_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Watch a short ad to support the app!'**
  String get saveWorkoutDialog_support_us_subtitle;

  /// No description provided for @editDeleteBottomSheet_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editDeleteBottomSheet_edit;

  /// No description provided for @editDeleteBottomSheet_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get editDeleteBottomSheet_delete;

  /// No description provided for @noTrainingSection_noSaved.
  ///
  /// In en, this message translates to:
  /// **'No saved workouts for this exercise'**
  String get noTrainingSection_noSaved;

  /// No description provided for @noTrainingSection_startNew.
  ///
  /// In en, this message translates to:
  /// **'To start a new workout and save results, click the button:'**
  String get noTrainingSection_startNew;

  /// No description provided for @noTrainingSection_addPrevious.
  ///
  /// In en, this message translates to:
  /// **'You can also use this button to add previous workouts'**
  String get noTrainingSection_addPrevious;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'it',
        'nl',
        'pl'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case 'CO':
            return AppLocalizationsEsCo();
          case 'ES':
            return AppLocalizationsEsEs();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
