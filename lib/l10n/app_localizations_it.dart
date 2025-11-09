// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get unknownExercise => 'Esercizio sconosciuto';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_elementVisibility =>
      'Mostra cronometro nella schermata principale';

  @override
  String get settings_language => 'Lingua';

  @override
  String get settings_english => 'Inglese';

  @override
  String get settings_polish => 'Polacco';

  @override
  String get settings_spanish_spain => 'Spagnolo – Spagna';

  @override
  String get settings_spanish_colombia => 'Spagnolo – Colombia';

  @override
  String get settings_german => 'Tedesco';

  @override
  String get settings_dutch => 'Olandese';

  @override
  String get settings_portuguese => 'Portoghese';

  @override
  String get settings_italian => 'Italiano';

  @override
  String get settings_otherLanguages => 'Altre lingue (presto disponibili)';

  @override
  String get settings_availableLanguages => 'Lingue disponibili';

  @override
  String get settings_units => 'Unità';

  @override
  String get settings_metric => 'Metro/Chilogrammo';

  @override
  String get settings_imperial => 'Pollice/Libbra';

  @override
  String get daysAgo_noData => 'Nessun dato';

  @override
  String get daysAgo_lessThanOneHour => 'Meno di un\'ora fa';

  @override
  String get daysAgo_oneHourAgo => '1 ora fa';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore fa',
      one: '1 ora fa',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => '1 giorno fa';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni fa',
      one: '1 giorno fa',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => '1 settimana fa';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane fa',
      one: '1 settimana fa',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Molto tempo fa';

  @override
  String get confirmationDialog_title => 'Conferma';

  @override
  String get deleteConfirmationDialog_title => 'Conferma eliminazione';

  @override
  String get dialog_content => 'Sei sicuro di voler continuare?';

  @override
  String get dialog_cancel => 'Annulla';

  @override
  String get dialog_confirm => 'Conferma';

  @override
  String get dialog_save => 'Salva';

  @override
  String get inputFormField_labelText => 'Inserisci un valore';

  @override
  String get inputFormField_invalidValue =>
      'Valore non valido. Inserisci un numero.';

  @override
  String get addPattern_title => 'Aggiungi nuova palette di colori';

  @override
  String get addPattern_iconsText =>
      'Così appariranno le icone e il testo su questo colore';

  @override
  String get addPattern_textExample =>
      'Ecco come apparirà questo testo con una tonalità diversa';

  @override
  String get addPattern_backgroundColor => 'Colore di sfondo';

  @override
  String get addPattern_sectionColor => 'Colore della sezione';

  @override
  String get addPattern_textIconsColor => 'Colore del testo e delle icone';

  @override
  String get addPattern_save => 'Salva';

  @override
  String get customizeApp_availableColorPalettes => 'Temi disponibili';

  @override
  String get customizeApp_currentTheme => 'Tema attualmente impostato';

  @override
  String get customizeApp_setTheme => 'Imposta tema';

  @override
  String get customizeApp_deleteTheme => 'Elimina tema';

  @override
  String get customizeApp_confirmDelete =>
      'Sei sicuro di voler eliminare questo tema?';

  @override
  String get customizeApp_applyTheme => 'Applica tema';

  @override
  String get savePalette_saveTheme => 'Salva tema';

  @override
  String savePalette_themeSaved(Object name) {
    return 'Tema \"$name\" salvato. Torna alla finestra precedente per applicarlo';
  }

  @override
  String get savePalette_themeName => 'Nome del tema';

  @override
  String get addPattern_moreColors => 'Altri colori';

  @override
  String get fullColorPicker_chooseColor => 'Scegli colore';

  @override
  String get fullColorPicker_save => 'Salva';

  @override
  String get applyNewTheme => 'Nuovo tema applicato';

  @override
  String get calculator1RM_title => 'Calcolatore 1RM';

  @override
  String get calculator1RM_infoText =>
      'Compila tutti i campi sottostanti per visualizzare il risultato 1RM';

  @override
  String get calculator1RM_weightLabelKg => 'Weight (kg)';

  @override
  String get calculator1RM_weightLabelLbs => 'Weight (lbs)';

  @override
  String get calculator1RM_repsLabel => 'NUMERO DI RIPETIZIONI';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Il tuo 1RM è: $value kg, che corrisponde a:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Il tuo 1RM è: $value lbs, che corrisponde a:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Percentuale';

  @override
  String get calculator1RM_table_header_reps => 'Ripetizioni';

  @override
  String get calculator1RM_table_header_weight => 'Peso';

  @override
  String get infoDialog1RM_title => 'Informazioni sul Calcolatore 1RM';

  @override
  String get infoDialog1RM_description =>
      'Il Calcolatore 1RM stima il peso massimo che puoi sollevare per una singola ripetizione, basandosi sul peso e sul numero di ripetizioni effettuate in una serie. La formula utilizzata è quella di Brzycki.';

  @override
  String get infoDialog1RM_closeButton => 'Chiudi';

  @override
  String get bmrResults_title => 'Il tuo BMR in base all\'attività:';

  @override
  String get bmrResults_noData => 'Nessun dato';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'circa $max – ${min}g di proteine al giorno';
  }

  @override
  String get basicActivity => 'Fabbisogno di base';

  @override
  String get lowActivity => 'Attività bassa';

  @override
  String get moderateActivity => 'Attività moderata';

  @override
  String get highActivity => 'Attività alta';

  @override
  String get veryHighActivity => 'Attività molto alta';

  @override
  String get calculatorBmr_title => 'Calcolatore BMR';

  @override
  String get calculatorBmr_weight => 'Weight';

  @override
  String get calculatorBmr_height_label_metric => 'ALTEZZA (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ALTEZZA (ft)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'ALTEZZA (in)';

  @override
  String get calculatorBmr_age_label => 'ETÀ';

  @override
  String get calculatorBmr_male => 'Maschio';

  @override
  String get calculatorBmr_female => 'Femmina';

  @override
  String get calculatorBmr_info =>
      'Compila tutti i campi sottostanti per visualizzare il risultato BMR';

  @override
  String get bmrInfo_title => 'Informazioni su BMR e proteine:';

  @override
  String get bmrInfo_text1 =>
      'Il BMR (Tasso Metabolico Basale) indica quante calorie il tuo corpo necessita a riposo per mantenere le funzioni vitali di base.';

  @override
  String get bmrInfo_text2 =>
      'Il livello di attività influisce sul valore del BMR. Un\'attività più intensa comporta un maggiore fabbisogno calorico.';

  @override
  String get bmrInfo_recommended =>
      'L\'assunzione raccomandata di PROTEINE dipende dal livello di attività fisica. Ecco i range in base al livello di attività:';

  @override
  String get bmrInfo_close => 'Chiudi';

  @override
  String get perKilogram => 'per chilogrammo di peso corporeo';

  @override
  String get perPound => 'per libbra di peso corporeo';

  @override
  String get plateCalculator_plateCalculator => 'Calcolatore dischi per lato';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Clicca per vedere i dischi suggeriti';

  @override
  String get plateCalculator_fillOutData =>
      'Compila i campi sottostanti per visualizzare il peso richiesto per lato. IL PESO TOTALE deve essere maggiore del PESO DEL BILANCIERE.';

  @override
  String get plateCalculator_selectPlates => 'Seleziona i dischi disponibili:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'PESO DEL BILANCIERE (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs =>
      'PESO DEL BILANCIERE (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'PESO TOTALE (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'PESO TOTALE (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Peso per lato: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Peso per lato: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Dischi suggeriti';

  @override
  String get plateDialog_forSide => 'PER LATO';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Opzione $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Chiudi';

  @override
  String get plateDialog_invalidWeight =>
      'Il peso deve superare quello del bilanciere';

  @override
  String get plateDialog_invalidTargetWeight => 'Peso target troppo basso';

  @override
  String get plateDialog_noCombinationFound =>
      'Nessuna combinazione valida di dischi per il peso selezionato';

  @override
  String get measurementTile_noData =>
      'Nessun dato. Premi il pulsante \'Misura\' per aggiungere un valore.';

  @override
  String get measurementTile_addData => 'Misura';

  @override
  String get measurementTile_baseline => 'Base';

  @override
  String get measurementTile_deleteCategory => 'Elimina categoria';

  @override
  String get measurementTile_today => 'Oggi';

  @override
  String get measurementTile_yesterday => 'Ieri';

  @override
  String get measurementTracker_body_measurements => 'Misure corporee';

  @override
  String get measurementTracker_no_data_to_show =>
      'Nessun dato da visualizzare';

  @override
  String get measurementTracker_add_new_category => 'Aggiungi nuova categoria';

  @override
  String get measurementTracker_name_new_category => 'Nome della categoria';

  @override
  String get measurementTracker_name_new_measurement => 'Valore della misura';

  @override
  String get measurementTracker_add_new_measurement => 'Aggiungi nuova misura';

  @override
  String get measurementTracker_update_category => 'Aggiorna categoria';

  @override
  String get measurementTracker_delete_category_confirmation =>
      'Sei sicuro di voler eliminare questa categoria?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      'Sei sicuro di voler eliminare questa misura?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'La misura per \'$bodyPart\' è stata eliminata.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'La categoria \'$category\' è stata eliminata.';
  }

  @override
  String get measurementTracker_category_exists =>
      'Questa categoria esiste già!';

  @override
  String get measurementTracker_invalid_value => 'Valore non valido!';

  @override
  String get measurementTracker_invalid_category =>
      'Categoria selezionata non valida!';

  @override
  String get measurementTracker_add_category_hint =>
      'Puoi aggiungere una nuova categoria utilizzando il pulsante sottostante.';

  @override
  String get measurementTracker_measurementDate => 'Data della misurazione';

  @override
  String get weightTracker_title => 'Monitoraggio Peso';

  @override
  String get weightTracker_enterWeightKg => 'Inserisci peso (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Inserisci peso (lbs)';

  @override
  String get weightTracker_saveWeight => 'Salva peso';

  @override
  String get weightTracker_updateWeight => 'Aggiorna peso';

  @override
  String get weightTracker_yourWeight => 'Il tuo peso';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' ($daysAgo giorni fa)';
  }

  @override
  String get weightTracker_legendWeightSaved => 'Giorni con peso salvato';

  @override
  String get drawer_tools_section => 'Strumenti';

  @override
  String get drawer_calculators_section => 'Calcolatrici';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Dischi sul bilanciere';

  @override
  String get drawer_time_section => 'Tempo';

  @override
  String get drawer_stopwatch => 'Cronometro';

  @override
  String get drawer_trackers_section => 'Tracciamento';

  @override
  String get drawer_weightTracker => 'Tracciamento peso';

  @override
  String get drawer_measurementTracker => 'Tracciamento misure';

  @override
  String get drawer_settings_section => 'Impostazioni';

  @override
  String get drawer_customizeApp => 'Personalizza tema';

  @override
  String get drawer_appLanguage => 'Lingua';

  @override
  String get drawer_notificationSettings => 'Notifiche';

  @override
  String get drawer_appreciation_section => 'Supporto';

  @override
  String get drawer_supportButton => 'Fai una donazione';

  @override
  String get drawer_watchAd => 'Guarda la pubblicità';

  @override
  String get drawer_shareApp => 'Condividi l\'app';

  @override
  String get drawer_noteCount => 'Numero di note salvate: ';

  @override
  String get drawer_guest => 'Ospite';

  @override
  String get drawer_privacyPolicy => 'Informativa sulla privacy';

  @override
  String get drawer_termsOfUse => 'Termini di utilizzo';

  @override
  String get searchDrawer_hint => 'Cerca...';

  @override
  String get searchDrawer_clear => 'Pulisci ricerca';

  @override
  String get addExerciseDialog_title => 'Aggiungi nuovo esercizio';

  @override
  String get addExerciseDialog_label => 'Inserisci nome esercizio';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'L\'esercizio \"$exerciseName\" è stato aggiunto';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Aggiungere un altro esercizio?';

  @override
  String get addExerciseDialog_anotherContent =>
      'Vuoi aggiungere un altro esercizio?';

  @override
  String get addWorkoutPlan_title => 'Aggiungi piano di allenamento';

  @override
  String get addWorkoutPlan_planName => 'Nome del piano di allenamento';

  @override
  String get addWorkoutPlan_selectedExercises => 'Esercizi selezionati:';

  @override
  String get addWorkoutPlan_noExercises => 'Nessun esercizio selezionato.';

  @override
  String get addWorkoutPlan_availableExercises => 'Esercizi disponibili:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Aggiungi nuovo esercizio';

  @override
  String get addWorkoutPlan_save => 'Salva piano di allenamento';

  @override
  String get addWorkoutPlan_missingName =>
      'Inserisci un nome per il piano di allenamento.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Seleziona almeno un esercizio.';

  @override
  String get tabBottomDrawer_showOnly => 'Mostra solo:';

  @override
  String get tabBottomDrawer_addNewGym => 'Aggiungi palestra';

  @override
  String get tabBottomDrawer_addNewUser => 'Aggiungi utente';

  @override
  String get tabBottomDrawer_addNewExercise => 'Aggiungi esercizio';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan =>
      'Aggiungi piano di allenamento';

  @override
  String get tabBottomDrawer_enterGymName => 'Inserisci nome palestra';

  @override
  String get tabBottomDrawer_enterUserName => 'Inserisci nome utente';

  @override
  String get tabBottomDrawer_editTitle => 'Modifica nome';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Inserisci nome piano di allenamento';

  @override
  String get tabBottomDrawer_editExercise => 'Modifica esercizio';

  @override
  String get tabBottomDrawer_editLabel => 'Inserisci un nuovo nome';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Aggiorna lo schermo per visualizzare le modifiche';

  @override
  String get tabBottomDrawer_reorderExercises => 'Reorder exercises';

  @override
  String get tabSector_gym => 'Palestra';

  @override
  String get tabSector_user => 'Utente';

  @override
  String get tabSector_exercise => 'Esercizio';

  @override
  String get tabSector_workoutPlan => 'Piano di allenamento';

  @override
  String get tabSector_filter => 'Filtra';

  @override
  String get tabSector_userGym => 'Utente e Palestra';

  @override
  String get sortSector_newest => 'Più recenti';

  @override
  String get sortSector_oldest => 'Più vecchi';

  @override
  String get sortSector_exerciseView => 'Esercizi';

  @override
  String get sortSector_historyView => 'Cronologia';

  @override
  String get historyView_noWorkouts => 'Nessun allenamento disponibile';

  @override
  String get historyView_exerciseNotFound => 'Esercizio non trovato';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'In questa sezione verranno mostrati gli appunti dei tuoi allenamenti';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Nessun risultato corrisponde ai filtri.';

  @override
  String get notes_justNow => 'Proprio adesso';

  @override
  String notes_minutesAgo(Object count) {
    return '$count minuti fa';
  }

  @override
  String notes_hoursAgo(Object count) {
    return '$count ore fa';
  }

  @override
  String notes_daysAgo(Object count) {
    return '$count giorni fa';
  }

  @override
  String get notes_invalidDate => 'Data non valida';

  @override
  String get notes_showMore => 'Mostra di più';

  @override
  String get notes_showLess => 'Mostra di meno';

  @override
  String get exerciseView_filteredOutExercises =>
      'Esercizi esclusi dai filtri:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Non hai ancora esercizi. Vai alla sezione \'Esercizio\' per aggiungere il primo.';

  @override
  String get iconSelection_chooseIcon => 'Scegli l\'icona dell\'esercizio';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Assegna utente e palestra all\'esercizio';

  @override
  String get exerciseExpansion_deleteExercise => 'Elimina esercizio';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Sei sicuro di voler eliminare questo esercizio? Ciò eliminerà anche tutti i dati correlati a questo esercizio.';

  @override
  String get exerciseExpansion_addIcon => 'Aggiungi icona all\'esercizio';

  @override
  String get exerciseExpansion_unknownExercise => 'Esercizio sconosciuto';

  @override
  String get exerciseExpansion_unknownUser => 'Utente sconosciuto';

  @override
  String get exerciseExpansion_unknownGym => 'Palestra sconosciuta';

  @override
  String get exerciseExpansion_noWorkouts => 'Nessun allenamento disponibile';

  @override
  String get exerciseExpansion_changeNameTitle => 'Cambia nome esercizio';

  @override
  String get exerciseExpansion_enterNewName => 'Nuovo nome esercizio';

  @override
  String get exerciseExpansion_exerciseNoteLabel => 'Exercise note';

  @override
  String get exerciseExpansion_exerciseNoteHint =>
      'Add general info about the exercise—like a link to proper form or a helpful site—so it\'s always right at your fingertips.';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Assegna esercizio a utente e palestra';
  }

  @override
  String get addUserAndGym_selectUser => 'Seleziona utente';

  @override
  String get addUserAndGym_selectGym => 'Seleziona palestra';

  @override
  String get addUserAndGym_confirmSelection => 'Conferma selezione';

  @override
  String get addUserAndGym_workoutExists =>
      'Questo allenamento esiste già per l\'utente e la palestra selezionati.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Aggiungi una nota generale per l\'esercizio – ad es. impostazioni della macchina, tipo di presa, consigli tecnici, ecc.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Ultima nota: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Imposta valore rapido';

  @override
  String get resultsExpansion_quickValueSet =>
      'es. obiettivo dell\'allenamento o la migliore serie';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      'Sei sicuro di voler eliminare questa sezione con tutti i suoi risultati?';

  @override
  String get notes_title => 'Appunti allenamento';

  @override
  String get notes_addNote => '+ Aggiungi nota';

  @override
  String get notes_cancel => 'Annulla';

  @override
  String get notes_hint => 'Scrivi la tua nota...';

  @override
  String get notes_saveNote => 'Salva nota';

  @override
  String get notes_updateNote => 'Aggiorna nota';

  @override
  String get notes_empty => 'Nessuna nota disponibile';

  @override
  String get notes_emptyNote => 'Nessuna nota';

  @override
  String get notes_deleteNoteTitle => 'Elimina nota';

  @override
  String get notes_deleteNoteConfirm =>
      'Sei sicuro di voler eliminare questa nota?';

  @override
  String get notes_copy => 'Copia nota';

  @override
  String get notes_copied => 'Nota copiata negli appunti';

  @override
  String get globalNote_title => 'Nota globale';

  @override
  String get globalNote_empty => 'Nessuna nota...';

  @override
  String get globalNote_hint => 'Inserisci nota';

  @override
  String get notificationScreen_title => 'Notifiche';

  @override
  String get notificationScreen_permissionTooltip =>
      'Clicca qui per abilitare le notifiche modificabili';

  @override
  String get notificationList_title => 'Notifiche salvate:';

  @override
  String get notificationList_empty => 'Nessuna notifica salvata.';

  @override
  String notificationList_hour(Object time) {
    return 'Ora: $time';
  }

  @override
  String get notificationList_daily => 'Ogni giorno';

  @override
  String notificationList_interval(Object days) {
    return 'Ogni $days giorni';
  }

  @override
  String get notificationList_weekly_none => 'Nessun giorno';

  @override
  String get notificationList_type_training => 'Allenamento';

  @override
  String get notificationList_type_weight => 'Peso';

  @override
  String get notificationList_type_measurement => 'Misura';

  @override
  String get notificationList_type_custom => 'Personalizzato';

  @override
  String get notificationList_confirm_title => 'Conferma';

  @override
  String get notificationList_confirm_content =>
      'Sei sicuro di voler eliminare questa notifica?';

  @override
  String get notificationList_deleteAll => 'Elimina tutte';

  @override
  String get notificationList_confirmAll_title =>
      'Eliminare tutte le notifiche?';

  @override
  String get notificationList_confirmAll_content =>
      'Sei sicuro di voler eliminare tutte le notifiche salvate?';

  @override
  String get notificationForm_titleLabel => 'Titolo della notifica:';

  @override
  String get notificationForm_titleHint =>
      'Inserisci il titolo della notifica...';

  @override
  String get notificationForm_messageLabel => 'Contenuto della notifica:';

  @override
  String get notificationForm_messageHint =>
      'Inserisci il contenuto della notifica...';

  @override
  String get notificationForm_addNotification => 'Aggiungi notifica';

  @override
  String get notificationForm_added => 'Notifica aggiunta!';

  @override
  String get notificationForm_typeLabel => 'Promemoria:';

  @override
  String get notificationForm_typeTraining => 'Allenamento';

  @override
  String get notificationForm_typeWeight => 'Misurazione peso';

  @override
  String get notificationForm_typeMeasurement => 'Misurazione corpo';

  @override
  String get notificationForm_typeCustom => 'Personalizzato';

  @override
  String get notificationForm_modeLabel => 'Programma:';

  @override
  String get notificationForm_modeDaily => 'Ogni giorno';

  @override
  String get notificationForm_modeInterval => 'Ogni X giorni';

  @override
  String get notificationForm_modeWeekly =>
      'Giorni della settimana selezionati';

  @override
  String get notificationForm_intervalPrefix => 'Ogni';

  @override
  String get notificationForm_intervalSuffix => 'gg';

  @override
  String get notificationForm_weekdayMon => 'Lun';

  @override
  String get notificationForm_weekdayTue => 'Mar';

  @override
  String get notificationForm_weekdayWed => 'Mer';

  @override
  String get notificationForm_weekdayThu => 'Gio';

  @override
  String get notificationForm_weekdayFri => 'Ven';

  @override
  String get notificationForm_weekdaySat => 'Sab';

  @override
  String get notificationForm_weekdaySun => 'Dom';

  @override
  String get notificationForm_defaultTitleTraining => 'È ora di allenarsi!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Non dimenticare la tua attività fisica.';

  @override
  String get notificationForm_defaultTitleWeight => 'Controlla il peso';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Promemoria per la pesatura. Registra il risultato nell\'app.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Fai le misurazioni';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'È ora di misurare il corpo. Monitora i tuoi progressi!';

  @override
  String get notificationForm_testNotification => 'Testa notifica';

  @override
  String get timePicker_label => 'Ora';

  @override
  String get watchAds_title => 'Guarda pubblicità per supportarci';

  @override
  String get watchAds_description =>
      'Guarda un breve video pubblicitario per supportarci senza spendere soldi';

  @override
  String get watchAds_button => 'Guarda pubblicità';

  @override
  String get watchAds_counter => 'Pubblicità viste:';

  @override
  String get watchAds_error =>
      'Grazie per il tuo supporto! Sfortunatamente, l\'annuncio non è stato caricato';

  @override
  String get watchAds_done =>
      'Congratulations! You’ve reached today’s limit. It will reset tomorrow.';

  @override
  String get watchAds_hide => 'Show ad button in training section';

  @override
  String get shareApp_title => 'Condividi l\'app';

  @override
  String get shareApp_inviteTitle => 'Condividi l\'app con amici e famiglia!';

  @override
  String get shareApp_inviteSubtitle =>
      'Aiutaci a far crescere la comunità condividendo l\'app con chi potrebbe trovarla utile.';

  @override
  String get shareApp_shareButton => 'Condividi tramite...';

  @override
  String get shareApp_linkCopied => 'Link copiato negli appunti';

  @override
  String get shareApp_shareText => 'Dai un\'occhiata a questa app:';

  @override
  String get shareApp_ratingTitle => 'Ti piace GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      'Ti andrebbe di valutare GoGymSimple? La tua opinione aiuta altri a scoprire l’app.';

  @override
  String get shareApp_ratingYes => 'Certo!';

  @override
  String get donate_title => 'Sostienici';

  @override
  String get donateSections_whyTitle => 'Perché sostenerci?';

  @override
  String get donateSections_whyDesc =>
      'Le tue donazioni ci aiutano a mantenere e sviluppare questo progetto. Tutti i contributi sono volontari e non sbloccano funzioni o contenuti speciali.';

  @override
  String get donateSections_monthlyTitle => 'Abbonamento mensile';

  @override
  String get donateSections_monthlyDesc =>
      'Sostienici con una donazione mensile';

  @override
  String get donateSections_monthlyButton => 'Abbonati mensilmente';

  @override
  String get donateSections_oneTimeTitle => 'Donazione una tantum';

  @override
  String get donateSections_oneTimeDesc =>
      'Effettua una donazione una tantum dell\'importo scelto';

  @override
  String get donateSections_oneTimeButton => 'Dona ora';

  @override
  String get donateSections_voluntaryTitle => '100% Volontario';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Negozio non disponibile. Controlla la connessione a Internet';

  @override
  String get donateSections_voluntaryDesc =>
      'Ricorda che tutte le donazioni sono completamente volontarie. Non riceverai funzionalità o contenuti speciali, solo la nostra sincera gratitudine per il supporto al progetto.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Esercizi preferiti';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Seleziona alcuni esercizi per iniziare';

  @override
  String get welcomeExerciseStep_addYourOwn =>
      'Aggiungi un esercizio personale';

  @override
  String get welcomeExerciseStep_exampleExercise => 'es. Squat bulgaro';

  @override
  String get welcomeExerciseStep_addButton => 'Aggiungi';

  @override
  String get welcomeExerciseStep_nextButton => 'Avanti';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferenze di allenamento';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Dove ti alleni di solito?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Allenamento a casa';

  @override
  String get welcomeGymLocationStep_gym => 'Palestra';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Nome palestra $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Avanti';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Benvenuto in GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Imposta il tuo profilo per iniziare la tua esperienza con l\'app';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Inizia';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Informazioni personali';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Il tuo nome';

  @override
  String get welcomeIntroSteps_nextButton => 'Avanti';

  @override
  String get welcomeSettingStep_appSettings => 'Impostazioni app';

  @override
  String get welcomeSettingStep_measurementSystem => 'Sistema di misura';

  @override
  String get welcomeSettingStep_metric => 'Metrico';

  @override
  String get welcomeSettingStep_imperial => 'Imperiale';

  @override
  String get welcomeSettingStep_appTheme => 'Tema dell\'app';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Entra in GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Scegli la lingua';

  @override
  String get welcomeScreen_english => 'Inglese';

  @override
  String get welcomeScreen_polish => 'Polacco';

  @override
  String get welcomeScreen_languageTooltip => 'Cambia lingua';

  @override
  String get welcomeScreen_exercise_benchPress => 'Panca piana';

  @override
  String get welcomeScreen_exercise_squats => 'Squat';

  @override
  String get welcomeScreen_exercise_deadlift => 'Stacco da terra';

  @override
  String get welcomeScreen_exercise_pullUps => 'Trazioni alla sbarra';

  @override
  String get welcomeScreen_exercise_pushUps => 'Piegamenti';

  @override
  String get welcomeScreen_exercise_lunges => 'Affondi';

  @override
  String get welcomeEnd_welcome => 'Benvenuto su GoGymSimple';

  @override
  String get stopwatch_title => 'Cronometro';

  @override
  String get workoutScreen_title => 'Allenamento';

  @override
  String get workoutScreen_gym => 'Seleziona palestra';

  @override
  String get workoutScreen_gymAndDate => 'Seleziona palestra e data';

  @override
  String get workoutScreen_selectGymFirst => 'Seleziona prima una palestra';

  @override
  String get workoutScreen_noGymSelected => 'Nessuna palestra selezionata';

  @override
  String get workoutScreen_saved => 'Allenamento salvato!';

  @override
  String get workoutScreen_participants => 'Partecipanti';

  @override
  String get workoutScreen_plans => 'Piani';

  @override
  String get workoutScreen_exercises => 'Esercizi';

  @override
  String get workoutScreen_addExercise => 'Aggiungi esercizio';

  @override
  String get workoutScreen_addNote => 'Aggiungi nota';

  @override
  String get workoutScreen_saveNote => 'Salva nota';

  @override
  String get workoutScreen_savedNote => 'Salvato';

  @override
  String get workoutScreen_showMoreInfo => 'Mostra più informazioni';

  @override
  String get workoutScreen_firstTime => 'Prima volta';

  @override
  String get workoutScreen_cancelWorkout => 'Cancel workout';

  @override
  String get workoutScreen_workoutCancelled => 'Workout cancelled';

  @override
  String get workoutScreen_addGeneralNote => 'Workout note';

  @override
  String get restoreSession_title => 'Allenamento interrotto';

  @override
  String get restoreSession_info =>
      'La tua sessione di allenamento precedente è stata interrotta.';

  @override
  String get restoreSession_content => 'Vuoi ripristinare i tuoi progressi?';

  @override
  String get restoreSession_confirm => 'Sì, ripristina';

  @override
  String get restoreSession_deny => 'Inizia da capo';

  @override
  String get saveWorkoutDialog_save_workout_title =>
      'Vuoi salvare l’allenamento?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Salva questo allenamento per tornare più tardi';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Salva allenamento';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Non ora';

  @override
  String get saveWorkoutDialog_support_us_title => 'Supportaci';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      'Guarda un breve annuncio per supportare l\'app!';

  @override
  String get editDeleteBottomSheet_edit => 'Modifica';

  @override
  String get editDeleteBottomSheet_delete => 'Elimina';

  @override
  String get noTrainingSection_noSaved =>
      'Nessun allenamento salvato per questo esercizio';

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
      'Puoi anche usare questo pulsante per aggiungere allenamenti precedenti';

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
