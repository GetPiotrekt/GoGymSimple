// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get unknownExercise => 'Onbekende oefening';

  @override
  String get settings_title => 'Instellingen';

  @override
  String get settings_elementVisibility => 'Toon stopwatch op het startscherm';

  @override
  String get settings_language => 'Taal';

  @override
  String get settings_english => 'Engels';

  @override
  String get settings_polish => 'Pools';

  @override
  String get settings_spanish_spain => 'Spaans – Spanje';

  @override
  String get settings_spanish_colombia => 'Spaans – Colombia';

  @override
  String get settings_german => 'Duits';

  @override
  String get settings_dutch => 'Nederlands';

  @override
  String get settings_portuguese => 'Portugees';

  @override
  String get settings_italian => 'Italiaans';

  @override
  String get settings_otherLanguages => 'Andere talen (binnenkort)';

  @override
  String get settings_availableLanguages => 'Beschikbare talen';

  @override
  String get settings_units => 'Eenheden';

  @override
  String get settings_metric => 'Meter/Kilogram';

  @override
  String get settings_imperial => 'Inch/Pond';

  @override
  String get daysAgo_noData => 'Geen gegevens';

  @override
  String get daysAgo_lessThanOneHour => '<1 uur geleden';

  @override
  String get daysAgo_oneHourAgo => '1 uur geleden';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uur geleden',
      many: '$count uur geleden',
      few: '$count uur geleden',
      one: '1 uur geleden',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => '1 dag geleden';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagen geleden',
      many: '$count dagen geleden',
      few: '$count dagen geleden',
      one: '1 dag geleden',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => '1 week geleden';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weken geleden',
      many: '$count weken geleden',
      few: '$count weken geleden',
      one: '1 week geleden',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Heel lang geleden';

  @override
  String get confirmationDialog_title => 'Bevestiging';

  @override
  String get deleteConfirmationDialog_title => 'Bevestiging verwijderen';

  @override
  String get dialog_content => 'Weet je zeker dat je wilt doorgaan?';

  @override
  String get dialog_cancel => 'Annuleren';

  @override
  String get dialog_confirm => 'Bevestigen';

  @override
  String get dialog_save => 'Opslaan';

  @override
  String get inputFormField_labelText => 'Voer waarde in';

  @override
  String get inputFormField_invalidValue =>
      'Ongeldige waarde. Voer een getal in.';

  @override
  String get addPattern_title => 'Voeg een nieuw kleurenpalet toe';

  @override
  String get addPattern_iconsText =>
      'Zo zien de iconen en tekst eruit op deze kleur';

  @override
  String get addPattern_textExample =>
      'En zo ziet deze tekst eruit met een andere tint';

  @override
  String get addPattern_backgroundColor => 'Achtergrondkleur';

  @override
  String get addPattern_sectionColor => 'Sectiekleur';

  @override
  String get addPattern_textIconsColor => 'Tekst- en icoonkleur';

  @override
  String get addPattern_save => 'Opslaan';

  @override
  String get addPattern_moreColors => 'Meer kleuren';

  @override
  String get customizeApp_availableColorPalettes => 'Beschikbare thema\'s';

  @override
  String get customizeApp_currentTheme => 'Huidig thema';

  @override
  String get customizeApp_setTheme => 'Stel thema in';

  @override
  String get customizeApp_deleteTheme => 'Verwijder thema';

  @override
  String get customizeApp_confirmDelete =>
      'Weet je zeker dat je dit thema wilt verwijderen?';

  @override
  String get customizeApp_applyTheme => 'Pas thema toe';

  @override
  String get savePalette_saveTheme => 'Sla thema op';

  @override
  String savePalette_themeSaved(Object name) {
    return 'Thema \"$name\" is opgeslagen. Ga terug naar het vorige scherm om het toe te passen';
  }

  @override
  String get savePalette_themeName => 'Themanaam';

  @override
  String get fullColorPicker_chooseColor => 'Kies kleur';

  @override
  String get fullColorPicker_save => 'Opslaan';

  @override
  String get applyNewTheme => 'Nieuw thema toegepast';

  @override
  String get calculator1RM_title => '1RM Calculator';

  @override
  String get calculator1RM_infoText =>
      'Vul alle gegevens hieronder in om je 1RM resultaat te zien';

  @override
  String get calculator1RM_weightLabel => 'GETILD GEWICHT';

  @override
  String get calculator1RM_repsLabel => 'AANTAL HERHALINGEN';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Je 1RM is: $value kg, wat overeenkomt met:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Je 1RM is: $value lbs, wat overeenkomt met:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Percentage';

  @override
  String get calculator1RM_table_header_reps => 'Herhalingen';

  @override
  String get calculator1RM_table_header_weight => 'Gewicht';

  @override
  String get infoDialog1RM_title => 'Over de 1RM Calculator';

  @override
  String get infoDialog1RM_description =>
      'De 1RM Calculator berekent het geschatte maximale gewicht dat je kunt tillen voor één herhaling op basis van het gewicht en het aantal herhalingen in een set. De gebruikte formule is de populaire Brzycki-formule.';

  @override
  String get infoDialog1RM_closeButton => 'Sluiten';

  @override
  String get bmrResults_title => 'Je BMR afhankelijk van activiteit:';

  @override
  String get bmrResults_noData => 'Geen gegevens';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'ongeveer $max – ${min}g eiwit per dag';
  }

  @override
  String get basicActivity => 'Normale activiteit';

  @override
  String get lowActivity => 'Lage activiteit';

  @override
  String get moderateActivity => 'Gemiddelde activiteit';

  @override
  String get highActivity => 'Hoge activiteit';

  @override
  String get veryHighActivity => 'Zeer hoge activiteit';

  @override
  String get calculatorBmr_title => 'BMR Calculator';

  @override
  String get calculatorBmr_weight_label_metric => 'GEWICHT (kg)';

  @override
  String get calculatorBmr_height_label_metric => 'LENGTE (cm)';

  @override
  String get calculatorBmr_weight_label_imperial => 'GEWICHT (lbs)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'LENGTE (ft)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'LENGTE (in)';

  @override
  String get calculatorBmr_age_label => 'LEEFTIJD';

  @override
  String get calculatorBmr_male => 'Man';

  @override
  String get calculatorBmr_female => 'Vrouw';

  @override
  String get calculatorBmr_info =>
      'Vul alle gegevens hieronder in om je BMR resultaat te zien';

  @override
  String get bmrInfo_title => 'Informatie over BMR en eiwit:';

  @override
  String get bmrInfo_text1 =>
      'BMR (Basal Metabolic Rate) is een indicator die aangeeft hoeveel calorieën je lichaam in rust nodig heeft om de basislevensfuncties te onderhouden.';

  @override
  String get bmrInfo_text2 =>
      'Het activiteitsniveau beïnvloedt de BMR-waarde. Een hoger activiteitsniveau betekent een grotere caloriebehoefte.';

  @override
  String get bmrInfo_recommended =>
      'De aanbevolen EIWIT-inname hangt af van het niveau van fysieke activiteit. Hier zijn de reeksen afhankelijk van het activiteitsniveau:';

  @override
  String get bmrInfo_close => 'Sluiten';

  @override
  String get perKilogram => 'per kilogram lichaamsgewicht';

  @override
  String get perPound => 'per pond lichaamsgewicht';

  @override
  String get plateCalculator_plateCalculator => 'Schijfcalculator per zijde';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Klik om de aangeraden plates te zien';

  @override
  String get plateCalculator_fillOutData =>
      'Vul onderstaande velden in om het benodigde gewicht per zijde te zien. TOTAAL GEWICHT moet groter zijn dan HET STAANGAANGEWICHT.';

  @override
  String get plateCalculator_selectPlates => 'Selecteer beschikbare schijven:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'BARBELL WEIGHT (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'BARBELL WEIGHT (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'TOTAAL GEWICHT (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'TOTAAL GEWICHT (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Gewicht per zijde: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Gewicht per zijde: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Aangeraden plates';

  @override
  String get plateDialog_forSide => 'PER ZIJDE';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Optie $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Sluiten';

  @override
  String get plateDialog_invalidWeight =>
      'Gewicht moet groter zijn dan het staangaangewicht';

  @override
  String get plateDialog_invalidTargetWeight => 'Doelgewicht te laag';

  @override
  String get measurementTile_noData =>
      'Nog geen gegevens. Druk op meten om een nieuwe waarde toe te voegen';

  @override
  String get measurementTile_addData => 'Meten';

  @override
  String get measurementTile_baseline => 'Basislijn';

  @override
  String get measurementTile_deleteCategory => 'Categorie verwijderen';

  @override
  String get measurementTile_today => 'Vandaag';

  @override
  String get measurementTile_yesterday => 'Gisteren';

  @override
  String get measurementTracker_body_measurements => 'Lichaamsmetingen';

  @override
  String get measurementTracker_no_data_to_show =>
      'Geen gegevens om weer te geven';

  @override
  String get measurementTracker_add_new_category =>
      'Nieuwe categorie toevoegen';

  @override
  String get measurementTracker_name_new_category => 'Categorienaam';

  @override
  String get measurementTracker_name_new_measurement => 'Meetwaarde';

  @override
  String get measurementTracker_add_new_measurement =>
      'Nieuwe meting toevoegen';

  @override
  String get measurementTracker_update_category => 'Categorie bijwerken';

  @override
  String get measurementTracker_delete_category_confirmation =>
      'Weet je zeker dat je deze categorie wilt verwijderen?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      'Weet je zeker dat je deze meting wilt verwijderen?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'Meting voor \'$bodyPart\' is verwijderd.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'Categorie \'$category\' is verwijderd.';
  }

  @override
  String get measurementTracker_category_exists => 'Deze categorie bestaat al!';

  @override
  String get measurementTracker_invalid_value => 'Ongeldige waarde!';

  @override
  String get measurementTracker_invalid_category =>
      'Geselecteerde categorie is ongeldig!';

  @override
  String get measurementTracker_add_category_hint =>
      'Je kunt een nieuwe categorie toevoegen met de knop hieronder.';

  @override
  String get weightTracker_title => 'Gewicht bijhouden';

  @override
  String get weightTracker_enterWeightKg => 'Voer gewicht in (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Voer gewicht in (lbs)';

  @override
  String get weightTracker_saveWeight => 'Gewicht opslaan';

  @override
  String get weightTracker_updateWeight => 'Gewicht bijwerken';

  @override
  String get weightTracker_yourWeight => 'Jouw gewicht';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' ($daysAgo dagen geleden)';
  }

  @override
  String get drawer_tools_section => 'Gereedschappen';

  @override
  String get drawer_calculators_section => 'Calculators';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Plates op Barbel';

  @override
  String get drawer_time_section => 'Tijd';

  @override
  String get drawer_stopwatch => 'Stopwatch';

  @override
  String get drawer_trackers_section => 'Tracking';

  @override
  String get drawer_weightTracker => 'Gewicht bijhouden';

  @override
  String get drawer_measurementTracker => 'Metingen bijhouden';

  @override
  String get drawer_settings_section => 'Instellingen';

  @override
  String get drawer_customizeApp => 'Thema aanpassen';

  @override
  String get drawer_appLanguage => 'Taal';

  @override
  String get drawer_notificationSettings => 'Meldingen';

  @override
  String get drawer_appreciation_section => 'Ondersteuning';

  @override
  String get drawer_supportButton => 'Doneer';

  @override
  String get drawer_watchAd => 'Bekijk advertentie';

  @override
  String get drawer_shareApp => 'Deel app';

  @override
  String get drawer_noteCount => 'Aantal opgeslagen notities: ';

  @override
  String get drawer_guest => 'Gast';

  @override
  String get drawer_privacyPolicy => 'Privacybeleid';

  @override
  String get drawer_termsOfUse => 'Gebruiksvoorwaarden';

  @override
  String get searchDrawer_hint => 'Zoeken...';

  @override
  String get searchDrawer_clear => 'Zoekopdracht wissen';

  @override
  String get addExerciseDialog_title => 'Nieuwe oefening toevoegen';

  @override
  String get addExerciseDialog_label => 'Voer de naam van de oefening in';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Oefening \"$exerciseName\" is toegevoegd';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Nog een oefening toevoegen?';

  @override
  String get addExerciseDialog_anotherContent =>
      'Wil je nog een oefening toevoegen?';

  @override
  String get addWorkoutPlan_title => 'Trainingsschema toevoegen';

  @override
  String get addWorkoutPlan_planName => 'Naam van het trainingsschema';

  @override
  String get addWorkoutPlan_selectedExercises => 'Geselecteerde oefeningen:';

  @override
  String get addWorkoutPlan_noExercises => 'Nog geen oefeningen geselecteerd.';

  @override
  String get addWorkoutPlan_availableExercises => 'Beschikbare oefeningen:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Nieuwe oefening toevoegen';

  @override
  String get addWorkoutPlan_save => 'Schema opslaan';

  @override
  String get addWorkoutPlan_missingName =>
      'Voer een naam in voor het trainingsschema.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Selecteer minstens één oefening.';

  @override
  String get tabBottomDrawer_showOnly => 'Alleen tonen:';

  @override
  String get tabBottomDrawer_addNewGym => 'Sportschool toevoegen';

  @override
  String get tabBottomDrawer_addNewUser => 'Gebruiker toevoegen';

  @override
  String get tabBottomDrawer_addNewExercise => 'Oefening toevoegen';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan => 'Trainingsschema toevoegen';

  @override
  String get tabBottomDrawer_enterGymName =>
      'Voer de naam van de sportschool in';

  @override
  String get tabBottomDrawer_enterUserName =>
      'Voer de naam van de gebruiker in';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Voer de naam van het trainingsschema in';

  @override
  String get tabSector_gym => 'Sportschool';

  @override
  String get tabSector_user => 'Gebruiker';

  @override
  String get tabSector_exercise => 'Oefening';

  @override
  String get tabSector_workoutPlan => 'Trainingsschema';

  @override
  String get sortSector_aToZ => 'A ... Z';

  @override
  String get sortSector_zToA => 'Z ... A';

  @override
  String get sortSector_newest => 'Nieuwste';

  @override
  String get sortSector_oldest => 'Oudste';

  @override
  String get sortSector_exerciseView => 'Oefeningen';

  @override
  String get sortSector_historyView => 'Geschiedenis';

  @override
  String get historyView_noWorkouts => 'Geen beschikbare trainingen';

  @override
  String get historyView_exerciseNotFound => 'Oefening niet gevonden';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'Hier worden notities van je trainingen getoond';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Geen resultaten voldoen aan je filters.';

  @override
  String get notes_justNow => 'Zojuist';

  @override
  String notes_minutesAgo(Object count) {
    return '$count minuten geleden';
  }

  @override
  String notes_hoursAgo(Object count) {
    return '$count uur geleden';
  }

  @override
  String notes_daysAgo(Object count) {
    return '$count dagen geleden';
  }

  @override
  String get notes_invalidDate => 'Ongeldige datum';

  @override
  String get notes_showMore => 'Toon meer';

  @override
  String get notes_showLess => 'Toon minder';

  @override
  String get notes_deleteNoteTitle => 'Verwijder notitie';

  @override
  String get notes_deleteNoteConfirm =>
      'Weet je zeker dat je deze notitie wilt verwijderen?';

  @override
  String get notes_copy => 'Kopieer notitie';

  @override
  String get notes_copied => 'Notitie gekopieerd naar klembord';

  @override
  String get exerciseView_sortDesc => 'Z ... A';

  @override
  String get exerciseView_sortAsc => 'A ... Z';

  @override
  String get exerciseView_filteredOutExercises =>
      'Oefeningen die niet aan de filters voldoen:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Je hebt nog geen oefeningen. Ga naar de sectie \'Oefening\' om je eerste toe te voegen.';

  @override
  String get iconSelection_chooseIcon => 'Kies een oefeningsicoon';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Voeg gebruiker en sportschool toe aan oefening';

  @override
  String get exerciseExpansion_deleteExercise => 'Verwijder oefening';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Weet je zeker dat je deze oefening wilt verwijderen? Dit zal ook alle bijbehorende gegevens verwijderen.';

  @override
  String get exerciseExpansion_addIcon => 'Voeg icoon toe aan oefening';

  @override
  String get exerciseExpansion_unknownExercise => 'Onbekende oefening';

  @override
  String get exerciseExpansion_unknownUser => 'Onbekende gebruiker';

  @override
  String get exerciseExpansion_unknownGym => 'Onbekende sportschool';

  @override
  String get exerciseExpansion_noWorkouts => 'Geen beschikbare trainingen';

  @override
  String get exerciseExpansion_changeNameTitle => 'Wijzig naam van oefening';

  @override
  String get exerciseExpansion_enterNewName => 'Nieuwe naam voor oefening';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Wijs $exercise toe aan gebruiker en sportschool';
  }

  @override
  String get addUserAndGym_selectUser => 'Selecteer gebruiker';

  @override
  String get addUserAndGym_selectGym => 'Selecteer sportschool';

  @override
  String get addUserAndGym_confirmSelection => 'Bevestig selectie';

  @override
  String get addUserAndGym_workoutExists =>
      'Deze training bestaat al voor de geselecteerde gebruiker en sportschool.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Globale notitie voor oefening $exerciseName';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Laatste notitie: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Stel snelle waarde in';

  @override
  String get resultsExpansion_quickValueSet => 'Voer tekst of nummer in';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      'Weet je zeker dat je deze sectie en alle resultaten wilt verwijderen?';

  @override
  String get notes_title => 'Trainingsnotities';

  @override
  String get notes_addNote => '+ Voeg notitie toe';

  @override
  String get notes_cancel => 'Annuleer';

  @override
  String get notes_hint => 'Typ je notitie...';

  @override
  String get notes_saveNote => 'Notitie opslaan';

  @override
  String get notes_updateNote => 'Notitie bijwerken';

  @override
  String get notes_empty => 'Geen beschikbare notities';

  @override
  String get notes_emptyNote => 'Geen notitie';

  @override
  String get globalNote_title => 'Globale notitie';

  @override
  String get globalNote_empty => 'Geen notitie...';

  @override
  String get globalNote_hint => 'Voer notitie in';

  @override
  String get notificationScreen_title => 'Meldingen';

  @override
  String get notificationScreen_permissionTooltip =>
      'Vraag toestemming voor meldingen';

  @override
  String get notificationList_title => 'Opgeslagen meldingen:';

  @override
  String get notificationList_empty => 'Geen opgeslagen meldingen.';

  @override
  String notificationList_hour(Object time) {
    return 'Tijd: $time';
  }

  @override
  String get notificationList_daily => 'Dagelijks';

  @override
  String notificationList_interval(Object days) {
    return 'Elke $days dagen';
  }

  @override
  String get notificationList_weekly_none => 'Geen dagen';

  @override
  String get notificationList_type_training => 'Training';

  @override
  String get notificationList_type_weight => 'Gewicht';

  @override
  String get notificationList_type_measurement => 'Meting';

  @override
  String get notificationList_type_custom => 'Aangepast';

  @override
  String get notificationList_confirm_title => 'Bevestiging';

  @override
  String get notificationList_confirm_content =>
      'Weet je zeker dat je deze melding wilt verwijderen?';

  @override
  String get notificationForm_titleLabel => 'Meldingstitel:';

  @override
  String get notificationForm_titleHint => 'Typ een eigen meldingstitel...';

  @override
  String get notificationForm_messageLabel => 'Meldingstekst:';

  @override
  String get notificationForm_messageHint => 'Typ een eigen meldingstekst...';

  @override
  String get notificationForm_addNotification => 'Voeg melding toe';

  @override
  String get notificationForm_added => 'Melding toegevoegd!';

  @override
  String get notificationForm_typeLabel => 'Meldingstype:';

  @override
  String get notificationForm_typeTraining => 'Over training';

  @override
  String get notificationForm_typeWeight => 'Over gewicht meten';

  @override
  String get notificationForm_typeMeasurement => 'Over lichaamsmeting';

  @override
  String get notificationForm_typeCustom => 'Aangepast';

  @override
  String get notificationForm_modeLabel => 'Meldingmodus:';

  @override
  String get notificationForm_modeDaily => 'Dagelijks';

  @override
  String get notificationForm_modeInterval => 'Elke X dagen';

  @override
  String get notificationForm_modeWeekly => 'Geselecteerde weekdagen';

  @override
  String get notificationForm_intervalPrefix => 'Elke';

  @override
  String get notificationForm_intervalSuffix => 'd.';

  @override
  String get notificationForm_weekdayMon => 'Ma';

  @override
  String get notificationForm_weekdayTue => 'Di';

  @override
  String get notificationForm_weekdayWed => 'Wo';

  @override
  String get notificationForm_weekdayThu => 'Do';

  @override
  String get notificationForm_weekdayFri => 'Vr';

  @override
  String get notificationForm_weekdaySat => 'Za';

  @override
  String get notificationForm_weekdaySun => 'Zo';

  @override
  String get notificationForm_defaultTitleTraining => 'Tijd om te trainen!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Vergeet je fysieke activiteit niet.';

  @override
  String get notificationForm_defaultTitleWeight => 'Weeg jezelf';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Herinnering om je gewicht te meten. Noteer het resultaat in de app.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Doe metingen';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Tijd voor lichaamsmetingen. Volg je voortgang!';

  @override
  String get timePicker_label => 'Tijd';

  @override
  String get watchAds_title => 'Bekijk advertenties om ons te steunen';

  @override
  String get watchAds_description =>
      'Bekijk een korte video-advertentie om ons te steunen zonder geld uit te geven';

  @override
  String get watchAds_button => 'Bekijk advertentie';

  @override
  String get watchAds_counter => 'Bekeken advertenties:';

  @override
  String get shareApp_title => 'Deel de app';

  @override
  String get shareApp_inviteTitle => 'Deel de app met vrienden en familie!';

  @override
  String get shareApp_inviteSubtitle =>
      'Help ons de community te laten groeien door de app te delen met mensen die het nuttig kunnen vinden.';

  @override
  String get shareApp_shareText => 'Bekijk deze app:';

  @override
  String get shareApp_shareButton => 'Delen via...';

  @override
  String get shareApp_linkCopied => 'Link gekopieerd naar klembord';

  @override
  String get donate_title => 'Steun Ons';

  @override
  String get donateSections_whyTitle => 'Waarom ons steunen?';

  @override
  String get donateSections_whyDesc =>
      'Jouw donaties helpen ons dit project te onderhouden en te ontwikkelen. Alle bijdragen zijn vrijwillig en ontgrendelen geen speciale functies of content.';

  @override
  String get donateSections_monthlyTitle => 'Maandelijkse abonnement';

  @override
  String get donateSections_monthlyDesc =>
      'Steun ons met een maandelijkse donatie';

  @override
  String get donateSections_monthlyButton => 'Abonneer maandelijks';

  @override
  String get donateSections_oneTimeTitle => 'Eenmalige donatie';

  @override
  String get donateSections_oneTimeDesc =>
      'Doe een eenmalige donatie naar keuze';

  @override
  String get donateSections_oneTimeButton => 'Doneer nu';

  @override
  String get donateSections_voluntaryTitle => '100% Vrijwillig';

  @override
  String get donateSections_voluntaryDesc =>
      'Onthoud dat alle donaties volledig vrijwillig zijn. Je krijgt geen speciale functies of content – alleen onze oprechte dank voor je steun aan het project.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Favoriete oefeningen';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Kies een paar oefeningen om te beginnen';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Voeg je eigen oefening toe';

  @override
  String get welcomeExerciseStep_exampleExercise =>
      'bijv. Bulgaarse split squats';

  @override
  String get welcomeExerciseStep_addButton => 'Toevoegen';

  @override
  String get welcomeExerciseStep_nextButton => 'Volgende';

  @override
  String get welcomeGymLocationStep_workoutPreferences => 'Trainingsvoorkeuren';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain => 'Waar train je meestal?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Thuis trainen';

  @override
  String get welcomeGymLocationStep_gym => 'Sportschool';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Naam sportschool $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Volgende';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Welkom bij GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Stel je profiel in om te beginnen met de app';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Begin';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Persoonlijke gegevens';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Je naam';

  @override
  String get welcomeIntroSteps_nextButton => 'Volgende';

  @override
  String get welcomeSettingStep_appSettings => 'App-instellingen';

  @override
  String get welcomeSettingStep_measurementSystem => 'Meet systeem';

  @override
  String get welcomeSettingStep_metric => 'Metrisch';

  @override
  String get welcomeSettingStep_imperial => 'Imperiaal';

  @override
  String get welcomeSettingStep_appTheme => 'App-thema';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Ga naar GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Kies taal';

  @override
  String get welcomeScreen_english => 'Engels';

  @override
  String get welcomeScreen_polish => 'Pools';

  @override
  String get welcomeScreen_languageTooltip => 'Verander taal';

  @override
  String get welcomeScreen_exercise_benchPress => 'BenchPress';

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
  String get welcomeEnd_welcome => 'Welkom bij GoGymSimple';

  @override
  String get stopwatch_title => 'Stopwatch';
}
