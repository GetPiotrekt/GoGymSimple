// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get unknownExercise => 'Unbekannte Übung';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_elementVisibility =>
      'Stoppuhr auf dem Hauptbildschirm anzeigen';

  @override
  String get settings_language => 'Sprache';

  @override
  String get settings_english => 'Englisch';

  @override
  String get settings_polish => 'Polnisch';

  @override
  String get settings_spanish_spain => 'Spanisch – Spanien';

  @override
  String get settings_spanish_colombia => 'Spanisch – Kolumbien';

  @override
  String get settings_german => 'Deutsch';

  @override
  String get settings_dutch => 'Niederländisch';

  @override
  String get settings_portuguese => 'Portugiesisch';

  @override
  String get settings_italian => 'Italienisch';

  @override
  String get settings_otherLanguages => 'Andere Sprachen (bald)';

  @override
  String get settings_availableLanguages => 'Verfügbare Sprachen';

  @override
  String get settings_units => 'Einheiten';

  @override
  String get settings_metric => 'Meter/Kilogramm';

  @override
  String get settings_imperial => 'Zoll/Pfund';

  @override
  String get daysAgo_noData => 'Keine Daten';

  @override
  String get daysAgo_lessThanOneHour => '<1 Stunde her';

  @override
  String get daysAgo_oneHourAgo => 'Vor 1 Stunde';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Stunden',
      many: 'vor $count Stunden',
      few: 'vor $count Stunden',
      one: 'vor 1 Stunde',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => 'Vor 1 Tag';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Tagen',
      many: 'vor $count Tagen',
      few: 'vor $count Tagen',
      one: 'vor 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => 'Vor 1 Woche';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Wochen',
      many: 'vor $count Wochen',
      few: 'vor $count Wochen',
      one: 'vor 1 Woche',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Vor langer Zeit';

  @override
  String get confirmationDialog_title => 'Bestätigung';

  @override
  String get deleteConfirmationDialog_title => 'Löschbestätigung';

  @override
  String get dialog_content => 'Möchten Sie wirklich fortfahren?';

  @override
  String get dialog_cancel => 'Abbrechen';

  @override
  String get dialog_confirm => 'Bestätigen';

  @override
  String get dialog_save => 'Speichern';

  @override
  String get inputFormField_labelText => 'Wert eingeben';

  @override
  String get inputFormField_invalidValue =>
      'Ungültiger Wert. Bitte eine Zahl eingeben.';

  @override
  String get addPattern_title => 'Neue Farbpalette hinzufügen';

  @override
  String get addPattern_iconsText =>
      'So sehen die Symbole und Texte in dieser Farbe aus';

  @override
  String get addPattern_textExample =>
      'So sieht dieser Text mit einem anderen Farbton aus';

  @override
  String get addPattern_backgroundColor => 'Hintergrundfarbe';

  @override
  String get addPattern_sectionColor => 'Sektionenfarbe';

  @override
  String get addPattern_textIconsColor => 'Farbe von Text und Symbolen';

  @override
  String get addPattern_save => 'Speichern';

  @override
  String get customizeApp_availableColorPalettes => 'Verfügbare Themen';

  @override
  String get customizeApp_currentTheme => 'Aktuell eingestelltes Thema';

  @override
  String get customizeApp_setTheme => 'Thema einstellen';

  @override
  String get customizeApp_deleteTheme => 'Thema löschen';

  @override
  String get customizeApp_confirmDelete =>
      'Möchten Sie dieses Thema wirklich löschen?';

  @override
  String get customizeApp_applyTheme => 'Thema anwenden';

  @override
  String get savePalette_saveTheme => 'Thema speichern';

  @override
  String savePalette_themeSaved(Object name) {
    return 'Thema „$name“ wurde gespeichert. Gehen Sie zurück, um es anzuwenden';
  }

  @override
  String get savePalette_themeName => 'Themenname';

  @override
  String get addPattern_moreColors => 'Weitere Farben';

  @override
  String get fullColorPicker_chooseColor => 'Farbe auswählen';

  @override
  String get fullColorPicker_save => 'Speichern';

  @override
  String get applyNewTheme => 'Neues Thema angewendet';

  @override
  String get calculator1RM_title => '1RM Rechner';

  @override
  String get calculator1RM_infoText =>
      'Füllen Sie alle Felder unten aus, um das 1RM Ergebnis zu sehen';

  @override
  String get calculator1RM_weightLabelKg => 'Weight (kg)';

  @override
  String get calculator1RM_weightLabelLbs => 'Weight (lbs)';

  @override
  String get calculator1RM_repsLabel => 'ANZAHL DER WIEDERHOLUNGEN';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Ihr 1RM beträgt: $value kg, was entspricht:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Ihr 1RM beträgt: $value lbs, was entspricht:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Prozent';

  @override
  String get calculator1RM_table_header_reps => 'Wiederholungen';

  @override
  String get calculator1RM_table_header_weight => 'Gewicht';

  @override
  String get infoDialog1RM_title => 'Über den 1RM Rechner';

  @override
  String get infoDialog1RM_description =>
      'Der 1RM Rechner berechnet das ungefähre maximale Gewicht, das Sie für eine Wiederholung heben können, basierend auf dem Gewicht und der Anzahl der Wiederholungen in einem Satz. Die verwendete Formel ist die bekannte Brzycki-Formel.';

  @override
  String get infoDialog1RM_closeButton => 'Schließen';

  @override
  String get bmrResults_title => 'Ihr BMR abhängig von der Aktivität:';

  @override
  String get bmrResults_noData => 'Keine Daten';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'ca. $max – ${min}g Protein pro Tag';
  }

  @override
  String get basicActivity => 'Grundbedarf';

  @override
  String get lowActivity => 'Geringe Aktivität';

  @override
  String get moderateActivity => 'Mittlere Aktivität';

  @override
  String get highActivity => 'Hohe Aktivität';

  @override
  String get veryHighActivity => 'Sehr hohe Aktivität';

  @override
  String get calculatorBmr_title => 'BMR Rechner';

  @override
  String get calculatorBmr_weight => 'Weight';

  @override
  String get calculatorBmr_height_label_metric => 'GRÖSSE (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'GRÖSSE (ft)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'GRÖSSE (in)';

  @override
  String get calculatorBmr_age_label => 'ALTER';

  @override
  String get calculatorBmr_male => 'Männlich';

  @override
  String get calculatorBmr_female => 'Weiblich';

  @override
  String get calculatorBmr_info =>
      'Füllen Sie alle Felder unten aus, um Ihr BMR Ergebnis zu sehen';

  @override
  String get bmrInfo_title => 'Informationen zu BMR und Protein:';

  @override
  String get bmrInfo_text1 =>
      'BMR (Basal Metabolic Rate) ist ein Wert, der angibt, wie viele Kalorien Ihr Körper im Ruhezustand für grundlegende Funktionen benötigt.';

  @override
  String get bmrInfo_text2 =>
      'Das Aktivitätsniveau beeinflusst den BMR-Wert. Höhere Aktivität bedeutet einen höheren Kalorienbedarf.';

  @override
  String get bmrInfo_recommended =>
      'Die empfohlene PROTEINZUFUHR hängt vom Aktivitätsniveau ab und liegt in folgenden Bereichen:';

  @override
  String get bmrInfo_close => 'Schließen';

  @override
  String get perKilogram => 'pro Kilogramm Körpergewicht';

  @override
  String get perPound => 'pro Pfund Körpergewicht';

  @override
  String get plateCalculator_plateCalculator => 'Tellerrechner pro Seite';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Klicken, um vorgeschlagene Teller zu sehen';

  @override
  String get plateCalculator_fillOutData =>
      'Füllen Sie die Felder unten aus, um das benötigte Gewicht pro Seite zu sehen. DAS GESAMTGEWICHT muss größer als das LANGHANTELGEWICHT sein.';

  @override
  String get plateCalculator_selectPlates => 'Verfügbare Teller auswählen:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'LANGHANTELGEWICHT (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'LANGHANTELGEWICHT (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'GESAMTGEWICHT (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'GESAMTGEWICHT (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Gewicht pro Seite: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Gewicht pro Seite: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Vorgeschlagene Teller';

  @override
  String get plateDialog_forSide => 'PRO SEITE';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Option $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Schließen';

  @override
  String get plateDialog_invalidWeight =>
      'Gewicht muss das Langhantelgewicht überschreiten';

  @override
  String get plateDialog_invalidTargetWeight => 'Zielgewicht zu niedrig';

  @override
  String get plateDialog_noCombinationFound =>
      'Keine gültige Scheibenkombination für das gewählte Gewicht gefunden';

  @override
  String get measurementTile_noData =>
      'Keine Daten. Drücken Sie die Taste \'Messung\', um einen Wert hinzuzufügen.';

  @override
  String get measurementTile_addData => 'Messung';

  @override
  String get measurementTile_baseline => 'Basis';

  @override
  String get measurementTile_deleteCategory => 'Kategorie löschen';

  @override
  String get measurementTile_today => 'Heute';

  @override
  String get measurementTile_yesterday => 'Gestern';

  @override
  String get measurementTracker_body_measurements => 'Körpermessungen';

  @override
  String get measurementTracker_no_data_to_show => 'Keine Daten zum Anzeigen';

  @override
  String get measurementTracker_add_new_category => 'Neue Kategorie hinzufügen';

  @override
  String get measurementTracker_name_new_category => 'Kategoriename';

  @override
  String get measurementTracker_name_new_measurement => 'Messwert';

  @override
  String get measurementTracker_add_new_measurement =>
      'Neue Messung hinzufügen';

  @override
  String get measurementTracker_update_category => 'Kategorie aktualisieren';

  @override
  String get measurementTracker_delete_category_confirmation =>
      'Möchten Sie diese Kategorie wirklich löschen?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      'Möchten Sie diese Messung wirklich löschen?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'Messung für \'$bodyPart\' wurde gelöscht.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'Kategorie \'$category\' wurde gelöscht.';
  }

  @override
  String get measurementTracker_category_exists =>
      'Diese Kategorie existiert bereits!';

  @override
  String get measurementTracker_invalid_value => 'Ungültiger Wert!';

  @override
  String get measurementTracker_invalid_category =>
      'Ausgewählte Kategorie ist ungültig!';

  @override
  String get measurementTracker_add_category_hint =>
      'Sie können eine neue Kategorie mit der Schaltfläche unten hinzufügen.';

  @override
  String get measurementTracker_measurementDate => 'Messdatum';

  @override
  String get weightTracker_title => 'Gewicht verfolgen';

  @override
  String get weightTracker_enterWeightKg => 'Gewicht eingeben (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Gewicht eingeben (lbs)';

  @override
  String get weightTracker_saveWeight => 'Gewicht speichern';

  @override
  String get weightTracker_updateWeight => 'Gewicht aktualisieren';

  @override
  String get weightTracker_yourWeight => 'Ihr Gewicht';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' vor $daysAgo Tagen';
  }

  @override
  String get weightTracker_legendWeightSaved =>
      'Tage mit gespeichertem Gewicht';

  @override
  String get drawer_tools_section => 'Werkzeuge';

  @override
  String get drawer_calculators_section => 'Rechner';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Teller auf der Langhantel';

  @override
  String get drawer_time_section => 'Zeit';

  @override
  String get drawer_stopwatch => 'Stoppuhr';

  @override
  String get drawer_trackers_section => 'Verfolgung';

  @override
  String get drawer_weightTracker => 'Gewichtsverfolgung';

  @override
  String get drawer_measurementTracker => 'Messungsverfolgung';

  @override
  String get drawer_settings_section => 'Einstellungen';

  @override
  String get drawer_customizeApp => 'Design anpassen';

  @override
  String get drawer_appLanguage => 'Sprache';

  @override
  String get drawer_notificationSettings => 'Benachrichtigungen';

  @override
  String get drawer_appreciation_section => 'Unterstützung';

  @override
  String get drawer_supportButton => 'Spenden';

  @override
  String get drawer_watchAd => 'Anzeige ansehen';

  @override
  String get drawer_shareApp => 'App teilen';

  @override
  String get drawer_noteCount => 'Gespeicherte Notizen: ';

  @override
  String get drawer_guest => 'Gast';

  @override
  String get drawer_privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get drawer_termsOfUse => 'Nutzungsbedingungen';

  @override
  String get searchDrawer_hint => 'Suchen...';

  @override
  String get searchDrawer_clear => 'Suche löschen';

  @override
  String get addExerciseDialog_title => 'Neues Training hinzufügen';

  @override
  String get addExerciseDialog_label => 'Übungsnamen eingeben';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Übung \"$exerciseName\" wurde hinzugefügt';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Weitere Übung hinzufügen?';

  @override
  String get addExerciseDialog_anotherContent =>
      'Möchten Sie eine weitere Übung hinzufügen?';

  @override
  String get addWorkoutPlan_title => 'Trainingsplan hinzufügen';

  @override
  String get addWorkoutPlan_planName => 'Name des Trainingsplans';

  @override
  String get addWorkoutPlan_selectedExercises => 'Ausgewählte Übungen:';

  @override
  String get addWorkoutPlan_noExercises => 'Noch keine Übungen ausgewählt.';

  @override
  String get addWorkoutPlan_availableExercises => 'Verfügbare Übungen:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Neue Übung hinzufügen';

  @override
  String get addWorkoutPlan_save => 'Trainingsplan speichern';

  @override
  String get addWorkoutPlan_missingName =>
      'Bitte gib einen Namen für den Trainingsplan ein.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Bitte wähle mindestens eine Übung aus.';

  @override
  String get tabBottomDrawer_showOnly => 'Nur anzeigen:';

  @override
  String get tabBottomDrawer_addNewGym => 'Fitnessstudio hinzufügen';

  @override
  String get tabBottomDrawer_addNewUser => 'Benutzer hinzufügen';

  @override
  String get tabBottomDrawer_addNewExercise => 'Übung hinzufügen';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan => 'Trainingsplan hinzufügen';

  @override
  String get tabBottomDrawer_enterGymName => 'Name des Fitnessstudios eingeben';

  @override
  String get tabBottomDrawer_enterUserName => 'Benutzernamen eingeben';

  @override
  String get tabBottomDrawer_editTitle => 'Name bearbeiten';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Name des Trainingsplans eingeben';

  @override
  String get tabBottomDrawer_editExercise => 'Übung bearbeiten';

  @override
  String get tabBottomDrawer_editLabel => 'Gib einen neuen Namen ein';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Aktualisiere den Bildschirm, um die Änderungen anzuzeigen';

  @override
  String get tabBottomDrawer_reorderExercises => 'Reorder exercises';

  @override
  String get tabSector_gym => 'Fitnessstudio';

  @override
  String get tabSector_user => 'Benutzer';

  @override
  String get tabSector_exercise => 'Übung';

  @override
  String get tabSector_workoutPlan => 'Trainingsplan';

  @override
  String get tabSector_filter => 'Filtern';

  @override
  String get tabSector_userGym => 'Benutzer & Fitnessstudio';

  @override
  String get sortSector_newest => 'Neueste';

  @override
  String get sortSector_oldest => 'Älteste';

  @override
  String get sortSector_exerciseView => 'Übungen';

  @override
  String get sortSector_historyView => 'Verlauf';

  @override
  String get historyView_noWorkouts => 'Keine verfügbaren Trainings';

  @override
  String get historyView_exerciseNotFound => 'Übung nicht gefunden';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'In diesem Bereich werden deine Trainingsnotizen angezeigt';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Keine Ergebnisse entsprechen deinen Filtern.';

  @override
  String get notes_justNow => 'Gerade eben';

  @override
  String notes_minutesAgo(Object count) {
    return 'vor $count Minuten';
  }

  @override
  String notes_hoursAgo(Object count) {
    return 'vor $count Stunden';
  }

  @override
  String notes_daysAgo(Object count) {
    return 'vor $count Tagen';
  }

  @override
  String get notes_invalidDate => 'Ungültiges Datum';

  @override
  String get notes_showMore => 'Mehr anzeigen';

  @override
  String get notes_showLess => 'Weniger anzeigen';

  @override
  String get exerciseView_filteredOutExercises => 'Nicht passende Übungen:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Du hast noch keine Übungen. Gehe zum Bereich \'Übung\', um die erste hinzuzufügen.';

  @override
  String get iconSelection_chooseIcon => 'Übungssymbol auswählen';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Benutzer und Fitnessstudio zur Übung hinzufügen';

  @override
  String get exerciseExpansion_deleteExercise => 'Übung löschen';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Möchtest du diese Übung wirklich löschen? Dadurch werden auch alle mit dieser Übung verbundenen Daten gelöscht.';

  @override
  String get exerciseExpansion_addIcon => 'Symbol zur Übung hinzufügen';

  @override
  String get exerciseExpansion_unknownExercise => 'Unbekannte Übung';

  @override
  String get exerciseExpansion_unknownUser => 'Unbekannter Benutzer';

  @override
  String get exerciseExpansion_unknownGym => 'Unbekanntes Fitnessstudio';

  @override
  String get exerciseExpansion_noWorkouts => 'Keine verfügbaren Trainings';

  @override
  String get exerciseExpansion_changeNameTitle => 'Übungsnamen ändern';

  @override
  String get exerciseExpansion_enterNewName => 'Neuer Übungsname';

  @override
  String get exerciseExpansion_exerciseNoteLabel => 'Exercise note';

  @override
  String get exerciseExpansion_exerciseNoteHint =>
      'Add general info about the exercise—like a link to proper form or a helpful site—so it\'s always right at your fingertips.';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Weise Übung einem Benutzer und Fitnessstudio zu';
  }

  @override
  String get addUserAndGym_selectUser => 'Benutzer auswählen';

  @override
  String get addUserAndGym_selectGym => 'Fitnessstudio auswählen';

  @override
  String get addUserAndGym_confirmSelection => 'Auswahl bestätigen';

  @override
  String get addUserAndGym_workoutExists =>
      'Dieses Training existiert bereits für den ausgewählten Benutzer und das Fitnessstudio.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Füge eine allgemeine Notiz für die Übung hinzu – z. B. Geräteeinstellung, Griffart, technische Hinweise usw.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Letzte Notiz: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Schnellen Wert setzen';

  @override
  String get resultsExpansion_quickValueSet =>
      'z. B. Trainingsziel oder bester Set';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      'Möchtest du diesen Abschnitt zusammen mit allen Ergebnissen wirklich löschen?';

  @override
  String get notes_title => 'Trainingsnotizen';

  @override
  String get notes_addNote => '+ Notiz hinzufügen';

  @override
  String get notes_cancel => 'Abbrechen';

  @override
  String get notes_hint => 'Gib deine Notiz ein...';

  @override
  String get notes_saveNote => 'Notiz speichern';

  @override
  String get notes_updateNote => 'Notiz aktualisieren';

  @override
  String get notes_empty => 'Keine verfügbaren Notizen';

  @override
  String get notes_emptyNote => 'Keine Notiz';

  @override
  String get notes_deleteNoteTitle => 'Notiz löschen';

  @override
  String get notes_deleteNoteConfirm =>
      'Möchtest du diese Notiz wirklich löschen?';

  @override
  String get notes_copy => 'Notiz kopieren';

  @override
  String get notes_copied => 'Notiz in die Zwischenablage kopiert';

  @override
  String get globalNote_title => 'Globale Notiz';

  @override
  String get globalNote_empty => 'Keine Notiz...';

  @override
  String get globalNote_hint => 'Notiz eingeben';

  @override
  String get notificationScreen_title => 'Benachrichtigungen';

  @override
  String get notificationScreen_permissionTooltip =>
      'Klicken Sie hier, um bearbeitbare Benachrichtigungen zu aktivieren';

  @override
  String get notificationList_title => 'Gespeicherte Benachrichtigungen:';

  @override
  String get notificationList_empty =>
      'Keine gespeicherten Benachrichtigungen.';

  @override
  String notificationList_hour(Object time) {
    return 'Uhrzeit: $time';
  }

  @override
  String get notificationList_daily => 'Täglich';

  @override
  String notificationList_interval(Object days) {
    return 'Alle $days Tage';
  }

  @override
  String get notificationList_weekly_none => 'Keine Tage';

  @override
  String get notificationList_type_training => 'Training';

  @override
  String get notificationList_type_weight => 'Gewicht';

  @override
  String get notificationList_type_measurement => 'Messung';

  @override
  String get notificationList_type_custom => 'Benutzerdefiniert';

  @override
  String get notificationList_confirm_title => 'Bestätigung';

  @override
  String get notificationList_confirm_content =>
      'Möchtest du diese Benachrichtigung wirklich löschen?';

  @override
  String get notificationList_deleteAll => 'Alle löschen';

  @override
  String get notificationList_confirmAll_title =>
      'Alle Benachrichtigungen löschen?';

  @override
  String get notificationList_confirmAll_content =>
      'Möchtest du wirklich alle gespeicherten Benachrichtigungen löschen?';

  @override
  String get notificationForm_titleLabel => 'Benachrichtigungstitel:';

  @override
  String get notificationForm_titleHint =>
      'Gib einen eigenen Benachrichtigungstitel ein...';

  @override
  String get notificationForm_messageLabel => 'Benachrichtigungstext:';

  @override
  String get notificationForm_messageHint =>
      'Gib einen eigenen Benachrichtigungstext ein...';

  @override
  String get notificationForm_addNotification => 'Benachrichtigung hinzufügen';

  @override
  String get notificationForm_added => 'Benachrichtigung hinzugefügt!';

  @override
  String get notificationForm_typeLabel => 'Erinnerung:';

  @override
  String get notificationForm_typeTraining => 'Zum Training';

  @override
  String get notificationForm_typeWeight => 'Zur Gewichtsmessung';

  @override
  String get notificationForm_typeMeasurement => 'Zur Körpermessung';

  @override
  String get notificationForm_typeCustom => 'Benutzerdefiniert';

  @override
  String get notificationForm_modeLabel => 'Zeitplan:';

  @override
  String get notificationForm_modeDaily => 'Täglich';

  @override
  String get notificationForm_modeInterval => 'Alle X Tage';

  @override
  String get notificationForm_modeWeekly => 'Ausgewählte Wochentage';

  @override
  String get notificationForm_intervalPrefix => 'Alle';

  @override
  String get notificationForm_intervalSuffix => 'T.';

  @override
  String get notificationForm_weekdayMon => 'Mo';

  @override
  String get notificationForm_weekdayTue => 'Di';

  @override
  String get notificationForm_weekdayWed => 'Mi';

  @override
  String get notificationForm_weekdayThu => 'Do';

  @override
  String get notificationForm_weekdayFri => 'Fr';

  @override
  String get notificationForm_weekdaySat => 'Sa';

  @override
  String get notificationForm_weekdaySun => 'So';

  @override
  String get notificationForm_defaultTitleTraining => 'Zeit fürs Training!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Vergiss deine körperliche Aktivität nicht.';

  @override
  String get notificationForm_defaultTitleWeight => 'Gewicht überprüfen';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Erinnerung an die Gewichtsmessung. Speichere dein Ergebnis in der App.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Maß nehmen';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Zeit für die Körpermessung. Verfolge deine Fortschritte!';

  @override
  String get notificationForm_testNotification => 'Benachrichtigung testen';

  @override
  String get timePicker_label => 'Uhrzeit';

  @override
  String get watchAds_title => 'Schau Werbung, um uns zu unterstützen';

  @override
  String get watchAds_description =>
      'Sieh dir ein kurzes Video an, um uns zu unterstützen, ohne Geld auszugeben';

  @override
  String get watchAds_button => 'Werbung ansehen';

  @override
  String get watchAds_counter => 'Angesehene Werbungen:';

  @override
  String get watchAds_error =>
      'Vielen Dank für Ihre Unterstützung! Leider konnte die Anzeige nicht geladen werden';

  @override
  String get watchAds_done =>
      'Congratulations! You’ve reached today’s limit. It will reset tomorrow.';

  @override
  String get watchAds_hide => 'Show ad button in training section';

  @override
  String get shareApp_title => 'App teilen';

  @override
  String get shareApp_inviteTitle => 'Teile die App mit Freunden und Familie!';

  @override
  String get shareApp_inviteSubtitle =>
      'Hilf uns, die Community zu vergrößern, indem du die App mit Personen teilst, die sie nützlich finden könnten.';

  @override
  String get shareApp_shareButton => 'Teilen über...';

  @override
  String get shareApp_linkCopied => 'Link in die Zwischenablage kopiert';

  @override
  String get shareApp_shareText => 'Schau dir diese App an:';

  @override
  String get shareApp_ratingTitle => 'Gefällt dir GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      'Möchtest du GoGymSimple bewerten? Dein Feedback hilft anderen, die App zu entdecken.';

  @override
  String get shareApp_ratingYes => 'Klar!';

  @override
  String get donate_title => 'Unterstütze uns';

  @override
  String get donateSections_whyTitle => 'Warum uns unterstützen?';

  @override
  String get donateSections_whyDesc =>
      'Deine Spenden helfen uns, dieses Projekt zu erhalten und weiterzuentwickeln. Alle Zahlungen sind freiwillig und schalten keine speziellen Funktionen oder Inhalte frei.';

  @override
  String get donateSections_monthlyTitle => 'Monatliches Abo';

  @override
  String get donateSections_monthlyDesc =>
      'Unterstütze uns mit einer monatlichen Spende';

  @override
  String get donateSections_monthlyButton => 'Monatlich abonnieren';

  @override
  String get donateSections_oneTimeTitle => 'Einmalige Spende';

  @override
  String get donateSections_oneTimeDesc =>
      'Leiste eine einmalige Zahlung in beliebiger Höhe';

  @override
  String get donateSections_oneTimeButton => 'Jetzt spenden';

  @override
  String get donateSections_voluntaryTitle => '100% Freiwillig';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Shop nicht verfügbar. Überprüfen Sie Ihre Internetverbindung';

  @override
  String get donateSections_voluntaryDesc =>
      'Bitte denk daran, dass alle Spenden vollkommen freiwillig sind. Du erhältst keine speziellen Funktionen oder Inhalte – nur unseren aufrichtigen Dank für deine Unterstützung des Projekts.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Lieblingsübungen';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Wähle einige Übungen zum Starten aus';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Füge eine eigene Übung hinzu';

  @override
  String get welcomeExerciseStep_exampleExercise =>
      'z.B. Bulgarische Kniebeugen';

  @override
  String get welcomeExerciseStep_addButton => 'Hinzufügen';

  @override
  String get welcomeExerciseStep_nextButton => 'Weiter';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Trainingspräferenzen';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Wo trainierst du normalerweise?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Training zu Hause';

  @override
  String get welcomeGymLocationStep_gym => 'Fitnessstudio';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Name des Fitnessstudios $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Weiter';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Willkommen bei GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Richte dein Profil ein, um dein Abenteuer mit der App zu beginnen';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Loslegen';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Persönliche Daten';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Dein Name';

  @override
  String get welcomeIntroSteps_nextButton => 'Weiter';

  @override
  String get welcomeSettingStep_appSettings => 'App-Einstellungen';

  @override
  String get welcomeSettingStep_measurementSystem => 'Maßsystem';

  @override
  String get welcomeSettingStep_metric => 'Metrisch';

  @override
  String get welcomeSettingStep_imperial => 'Imperial';

  @override
  String get welcomeSettingStep_appTheme => 'App-Thema';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'GoGymSimple betreten';

  @override
  String get welcomeScreen_chooseLanguage => 'Sprache wählen';

  @override
  String get welcomeScreen_english => 'Englisch';

  @override
  String get welcomeScreen_polish => 'Polnisch';

  @override
  String get welcomeScreen_languageTooltip => 'Sprache ändern';

  @override
  String get welcomeScreen_exercise_benchPress => 'Bankdrücken';

  @override
  String get welcomeScreen_exercise_squats => 'Kniebeugen';

  @override
  String get welcomeScreen_exercise_deadlift => 'Kreuzheben';

  @override
  String get welcomeScreen_exercise_pullUps => 'Klimmzüge';

  @override
  String get welcomeScreen_exercise_pushUps => 'Liegestütze';

  @override
  String get welcomeScreen_exercise_lunges => 'Ausfallschritte';

  @override
  String get welcomeEnd_welcome => 'Willkommen bei GoGymSimple';

  @override
  String get stopwatch_title => 'Stoppuhr';

  @override
  String get workoutScreen_title => 'Training';

  @override
  String get workoutScreen_gym => 'Fitnessstudio auswählen';

  @override
  String get workoutScreen_gymAndDate => 'Wähle Fitnessstudio und Datum';

  @override
  String get workoutScreen_selectGymFirst => 'Wähle zuerst eine Fitnessstudio';

  @override
  String get workoutScreen_noGymSelected => 'Keine Fitnessstudio ausgewählt';

  @override
  String get workoutScreen_saved => 'Training gespeichert!';

  @override
  String get workoutScreen_participants => 'Teilnehmer';

  @override
  String get workoutScreen_plans => 'Pläne';

  @override
  String get workoutScreen_exercises => 'Übungen';

  @override
  String get workoutScreen_addExercise => 'Übung hinzufügen';

  @override
  String get workoutScreen_addNote => 'Notiz hinzufügen';

  @override
  String get workoutScreen_saveNote => 'Notiz speichern';

  @override
  String get workoutScreen_savedNote => 'Gespeichert';

  @override
  String get workoutScreen_showMoreInfo => 'Mehr Informationen anzeigen';

  @override
  String get workoutScreen_firstTime => 'Zum ersten Mal';

  @override
  String get workoutScreen_cancelWorkout => 'Cancel workout';

  @override
  String get workoutScreen_workoutCancelled => 'Workout cancelled';

  @override
  String get workoutScreen_addGeneralNote => 'Workout note';

  @override
  String get restoreSession_title => 'Training unterbrochen';

  @override
  String get restoreSession_info =>
      'Deine letzte Trainingseinheit wurde unterbrochen.';

  @override
  String get restoreSession_content =>
      'Möchtest du deinen Fortschritt wiederherstellen?';

  @override
  String get restoreSession_confirm => 'Ja, wiederherstellen';

  @override
  String get restoreSession_deny => 'Neu starten';

  @override
  String get saveWorkoutDialog_save_workout_title =>
      'Möchtest du das Training speichern?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Speichere dieses Training, um später darauf zurückzukommen';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Training speichern';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Nicht jetzt';

  @override
  String get saveWorkoutDialog_support_us_title => 'Unterstütze uns';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      'Sieh dir eine kurze Werbung an, um die App zu unterstützen!';

  @override
  String get editDeleteBottomSheet_edit => 'Bearbeiten';

  @override
  String get editDeleteBottomSheet_delete => 'Löschen';

  @override
  String get noTrainingSection_noSaved =>
      'Keine gespeicherten Trainings für diese Übung';

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
      'Sie können diese Schaltfläche auch verwenden, um vorherige Trainings hinzuzufügen';

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
