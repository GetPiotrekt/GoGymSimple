// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get unknownExercise => 'Nieznane ćwiczenie';

  @override
  String get settings_title => 'Ustawienia';

  @override
  String get settings_elementVisibility => 'Pokaż stoper w menu głównym';

  @override
  String get settings_language => 'Język';

  @override
  String get settings_english => 'Angielski';

  @override
  String get settings_polish => 'Polski';

  @override
  String get settings_spanish_spain => 'Hiszpański – Hiszpania';

  @override
  String get settings_spanish_colombia => 'Hiszpański – Kolumbia';

  @override
  String get settings_german => 'Niemiecki';

  @override
  String get settings_dutch => 'Holenderski';

  @override
  String get settings_portuguese => 'Portugalski';

  @override
  String get settings_italian => 'Włoski';

  @override
  String get settings_otherLanguages => 'Inne języki (wkrótce)';

  @override
  String get settings_availableLanguages => 'Dostępne języki';

  @override
  String get settings_units => 'Jednostki';

  @override
  String get settings_metric => 'Metryczne (kg/m)';

  @override
  String get settings_imperial => 'Imperialne (lbs/inch)';

  @override
  String get daysAgo_noData => 'Brak danych';

  @override
  String get daysAgo_lessThanOneHour => 'Mniej niż godzinę temu';

  @override
  String get daysAgo_oneHourAgo => '1 godzinę temu';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count godziny temu',
      many: '$count godzin temu',
      few: '$count godziny temu',
      one: '1 godzinę temu',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => '1 dzień temu';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dni temu',
      many: '$count dni temu',
      few: '$count dni temu',
      one: '1 dzień temu',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => '1 tydzień temu';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tygodnia temu',
      many: '$count tygodni temu',
      few: '$count tygodnie temu',
      one: '1 tydzień temu',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Bardzo dawno temu';

  @override
  String get confirmationDialog_title => 'Potwierdzenie';

  @override
  String get deleteConfirmationDialog_title => 'Potwierdzenie usunięcia';

  @override
  String get dialog_content => 'Na pewno chcesz kontynuować?';

  @override
  String get dialog_cancel => 'Anuluj';

  @override
  String get dialog_confirm => 'Potwierdź';

  @override
  String get dialog_save => 'Zapisz';

  @override
  String get inputFormField_labelText => 'Wpisz wartość';

  @override
  String get inputFormField_invalidValue =>
      'Nieprawidłowa wartość – wpisz liczbę.';

  @override
  String get addPattern_title => 'Dodaj nowy motyw';

  @override
  String get addPattern_iconsText => 'Przykład wyglądu ikon i tekstu';

  @override
  String get addPattern_textExample => 'Przykład tekstu z innym odcieniem';

  @override
  String get addPattern_backgroundColor => 'Kolor tła';

  @override
  String get addPattern_sectionColor => 'Kolor sekcji';

  @override
  String get addPattern_textIconsColor => 'Kolor tekstu i ikon';

  @override
  String get addPattern_save => 'Zapisz';

  @override
  String get customizeApp_availableColorPalettes => 'Dostępne motywy';

  @override
  String get customizeApp_currentTheme => 'Obecny motyw';

  @override
  String get customizeApp_setTheme => 'Ustaw motyw';

  @override
  String get customizeApp_deleteTheme => 'Usuń motyw';

  @override
  String get customizeApp_confirmDelete => 'Na pewno chcesz usunąć ten motyw?';

  @override
  String get customizeApp_applyTheme => 'Zastosuj motyw';

  @override
  String get savePalette_saveTheme => 'Zapisz motyw';

  @override
  String savePalette_themeSaved(Object name) {
    return 'Motyw \"$name\" zapisany. Możesz go teraz zastosować.';
  }

  @override
  String get savePalette_themeName => 'Nazwa motywu';

  @override
  String get addPattern_moreColors => 'Więcej kolorów';

  @override
  String get fullColorPicker_chooseColor => 'Wybierz kolor';

  @override
  String get fullColorPicker_save => 'Zapisz';

  @override
  String get applyNewTheme => 'Zastosowano nowy motyw';

  @override
  String get calculator1RM_title => 'Kalkulator 1RM';

  @override
  String get calculator1RM_infoText =>
      'Wypełnij pola poniżej, aby obliczyć 1RM';

  @override
  String get calculator1RM_weightLabelKg => 'Waga (kg)';

  @override
  String get calculator1RM_weightLabelLbs => 'Waga (lbs)';

  @override
  String get calculator1RM_repsLabel => 'Powtórzenia';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Twoje 1RM wynosi: $value kg, co odpowiada wykonaniu:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Twoje 1RM wynosi: $value lbs, co odpowiada wykonaniu:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Procent';

  @override
  String get calculator1RM_table_header_reps => 'Powtórzenia';

  @override
  String get calculator1RM_table_header_weight => 'Ciężar';

  @override
  String get infoDialog1RM_title => 'O Kalkulatorze 1RM';

  @override
  String get infoDialog1RM_description =>
      'Kalkulator 1RM oblicza przybliżoną maksymalną wagę, jaką możesz podnieść na jedno powtórzenie na podstawie wagi i liczby powtórzeń wykonanych w serii. Zastosowany wzór to popularny wzór Brzyckiego.';

  @override
  String get infoDialog1RM_closeButton => 'Zamknij';

  @override
  String get bmrResults_title => 'Twoje BMR w zależności od aktywności:';

  @override
  String get bmrResults_noData => 'Brak danych';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'ok. $min–$max g białka dziennie';
  }

  @override
  String get basicActivity => 'Podstawowe zapotrzebowanie';

  @override
  String get lowActivity => 'Niska aktywność';

  @override
  String get moderateActivity => 'Średnia aktywność';

  @override
  String get highActivity => 'Wysoka aktywność';

  @override
  String get veryHighActivity => 'Bardzo wysoka aktywność';

  @override
  String get calculatorBmr_title => 'Kalkulator BMR';

  @override
  String get calculatorBmr_weight => 'Waga';

  @override
  String get calculatorBmr_height_label_metric => 'Wzrost (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ft';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'in';

  @override
  String get calculatorBmr_age_label => 'Wiek';

  @override
  String get calculatorBmr_male => 'Mężczyzna';

  @override
  String get calculatorBmr_female => 'Kobieta';

  @override
  String get calculatorBmr_info => 'Wypełnij dane, by zobaczyć wynik BMR';

  @override
  String get bmrInfo_title => 'Informacje o BMR i białku:';

  @override
  String get bmrInfo_text1 =>
      'BMR (podstawowa przemiana materii) to ilość kalorii, jakiej Twoje ciało potrzebuje w spoczynku, by podtrzymać podstawowe funkcje życiowe.';

  @override
  String get bmrInfo_text2 =>
      'Poziom aktywności wpływa na zapotrzebowanie kaloryczne – im jesteś bardziej aktywny, tym więcej kalorii potrzebujesz.';

  @override
  String get bmrInfo_recommended =>
      'Zalecane spożycie BIAŁKA zależy od Twojej aktywności fizycznej. Oto sugerowane zakresy w zależności od jej poziomu:';

  @override
  String get bmrInfo_close => 'Zamknij';

  @override
  String get perKilogram => 'na kg masy ciała';

  @override
  String get perPound => 'na funt masy ciała';

  @override
  String get plateCalculator_plateCalculator => 'Kalkulator talerzy na stronę';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Kliknij, aby zobaczyć proponowane talerze';

  @override
  String get plateCalculator_fillOutData =>
      'Uzupełnij dane poniżej, aby zobaczyć potrzebny ciężar na stronę. Całkowita waga musi być większa niż waga sztangi.';

  @override
  String get plateCalculator_selectPlates => 'Wybierz dostępne talerze:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'Sztanga (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'Sztanga (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'Całość (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'Całość (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Ciężar na stronę: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Ciężar na stronę: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Proponowane talerze';

  @override
  String get plateDialog_forSide => 'NA STRONĘ';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Opcja $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Zamknij';

  @override
  String get plateDialog_invalidWeight =>
      'Waga musi być większa niż waga sztangi';

  @override
  String get plateDialog_invalidTargetWeight => 'Docelowa waga jest zbyt mała';

  @override
  String get plateDialog_noCombinationFound =>
      'Nie można ułożyć odpowiedniej kombinacji talerzy dla wybranej wagi';

  @override
  String get measurementTile_noData =>
      'Brak danych. Kliknij \'Pomiar\', aby dodać wartość';

  @override
  String get measurementTile_addData => 'Pomiar';

  @override
  String get measurementTile_baseline => 'Bazowy';

  @override
  String get measurementTile_deleteCategory => 'Usuń kategorię';

  @override
  String get measurementTile_today => 'Dziś';

  @override
  String get measurementTile_yesterday => 'Wczoraj';

  @override
  String get measurementTracker_body_measurements => 'Pomiary ciała';

  @override
  String get measurementTracker_no_data_to_show =>
      'Brak danych do wyświetlenia';

  @override
  String get measurementTracker_add_new_category => 'Dodaj kategorię';

  @override
  String get measurementTracker_name_new_category => 'Nazwa kategorii';

  @override
  String get measurementTracker_name_new_measurement => 'Wartość pomiaru';

  @override
  String get measurementTracker_add_new_measurement => 'Dodaj pomiar';

  @override
  String get measurementTracker_update_category => 'Aktualizuj kategorię';

  @override
  String get measurementTracker_delete_category_confirmation =>
      'Czy na pewno chcesz usunąć tę kategorię?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      'Czy na pewno chcesz usunąć ten pomiar?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'Pomiar dla \'$bodyPart\' został usunięty.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'Kategoria \'$category\' została usunięta.';
  }

  @override
  String get measurementTracker_category_exists =>
      'Taka kategoria już istnieje!';

  @override
  String get measurementTracker_invalid_value => 'Nieprawidłowa wartość!';

  @override
  String get measurementTracker_invalid_category =>
      'Wybrana kategoria jest nieprawidłowa!';

  @override
  String get measurementTracker_add_category_hint =>
      'Dodaj nową kategorię za pomocą przycisku poniżej.';

  @override
  String get measurementTracker_measurementDate => 'Data pomiaru';

  @override
  String get weightTracker_title => 'Śledzenie Wagi';

  @override
  String get weightTracker_enterWeightKg => 'Wprowadź wagę (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Wprowadź wagę (lbs)';

  @override
  String get weightTracker_saveWeight => 'Zapisz wagę';

  @override
  String get weightTracker_updateWeight => 'Zaktualizuj wagę';

  @override
  String get weightTracker_yourWeight => 'Twoja waga';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' ($daysAgo dni temu)';
  }

  @override
  String get weightTracker_legendWeightSaved => 'Dni z zapisaną wagą';

  @override
  String get drawer_tools_section => 'Narzędzia';

  @override
  String get drawer_calculators_section => 'Kalkulatory';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Talerze na sztandze';

  @override
  String get drawer_time_section => 'Czas';

  @override
  String get drawer_stopwatch => 'Stoper';

  @override
  String get drawer_trackers_section => 'Śledzenie';

  @override
  String get drawer_weightTracker => 'Śledzenie wagi';

  @override
  String get drawer_measurementTracker => 'Śledzenie pomiarów';

  @override
  String get drawer_settings_section => 'Ustawienia';

  @override
  String get drawer_customizeApp => 'Dostosuj motyw';

  @override
  String get drawer_appLanguage => 'Język';

  @override
  String get drawer_notificationSettings => 'Powiadomienia';

  @override
  String get drawer_appreciation_section => 'Wsparcie';

  @override
  String get drawer_supportButton => 'Przekaż darowiznę';

  @override
  String get drawer_watchAd => 'Obejrzyj reklamę';

  @override
  String get drawer_shareApp => 'Poleć GoGymSimple';

  @override
  String get drawer_noteCount => 'Liczba zapisanych notatek: ';

  @override
  String get drawer_guest => 'Gość';

  @override
  String get drawer_privacyPolicy => 'Polityka prywatności';

  @override
  String get drawer_termsOfUse => 'Regulamin';

  @override
  String get searchDrawer_hint => 'Szukaj...';

  @override
  String get searchDrawer_clear => 'Wyczyść wyszukiwanie';

  @override
  String get addExerciseDialog_title => 'Dodaj nowe ćwiczenie';

  @override
  String get addExerciseDialog_label => 'Wpisz nazwę ćwiczenia';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Ćwiczenie \"$exerciseName\" zostało dodane';
  }

  @override
  String get addExerciseDialog_anotherTitle => 'Dodać kolejne ćwiczenie?';

  @override
  String get addExerciseDialog_anotherContent =>
      'Czy chcesz dodać kolejne ćwiczenie?';

  @override
  String get addWorkoutPlan_title => 'Dodaj plan treningowy';

  @override
  String get addWorkoutPlan_planName => 'Nazwa planu treningowego';

  @override
  String get addWorkoutPlan_selectedExercises => 'Wybrane ćwiczenia:';

  @override
  String get addWorkoutPlan_noExercises =>
      'Nie dodano jeszcze żadnych ćwiczeń.';

  @override
  String get addWorkoutPlan_availableExercises => 'Dostępne ćwiczenia:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Dodaj nowe ćwiczenie';

  @override
  String get addWorkoutPlan_save => 'Zapisz plan treningowy';

  @override
  String get addWorkoutPlan_missingName => 'Wpisz nazwę planu treningowego.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Dodaj przynajmniej jedno ćwiczenie.';

  @override
  String get tabBottomDrawer_showOnly => 'Pokaż tylko:';

  @override
  String get tabBottomDrawer_addNewGym => 'Dodaj siłownię';

  @override
  String get tabBottomDrawer_addNewUser => 'Dodaj użytkownika';

  @override
  String get tabBottomDrawer_addNewExercise => 'Dodaj ćwiczenie';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan => 'Dodaj plan treningowy';

  @override
  String get tabBottomDrawer_enterGymName => 'Wprowadź nazwę siłowni';

  @override
  String get tabBottomDrawer_enterUserName => 'Wprowadź nazwę użytkownika';

  @override
  String get tabBottomDrawer_editTitle => 'Edytuj nazwę';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Wprowadź nazwę planu treningowego';

  @override
  String get tabBottomDrawer_editExercise => 'Edytuj ćwiczenie';

  @override
  String get tabBottomDrawer_editLabel => 'Wpisz nową nazwę';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Odśwież ekran, aby zobaczyć zmiany';

  @override
  String get tabBottomDrawer_reorderExercises => 'Zmień kolejność ćwiczeń';

  @override
  String get tabSector_gym => 'Siłownia';

  @override
  String get tabSector_user => 'Użytkownik';

  @override
  String get tabSector_exercise => 'Ćwiczenie';

  @override
  String get tabSector_workoutPlan => 'Plan treningowy';

  @override
  String get tabSector_filter => 'Filtruj';

  @override
  String get tabSector_userGym => 'Użytkownik i siłownia';

  @override
  String get sortSector_newest => 'Najnowsze';

  @override
  String get sortSector_oldest => 'Najstarsze';

  @override
  String get sortSector_exerciseView => 'Ćwiczenia';

  @override
  String get sortSector_historyView => 'Historia';

  @override
  String get historyView_noWorkouts => 'Brak dostępnych treningów';

  @override
  String get historyView_exerciseNotFound => 'Nie znaleziono ćwiczenia';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'Tutaj pojawią się notatki z Twoich treningów';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Brak wyników pasujących do filtrów.';

  @override
  String get notes_justNow => 'Przed chwilą';

  @override
  String notes_minutesAgo(Object count) {
    return '$count minut temu';
  }

  @override
  String notes_hoursAgo(Object count) {
    return '$count godzin temu';
  }

  @override
  String notes_daysAgo(Object count) {
    return '$count dni temu';
  }

  @override
  String get notes_invalidDate => 'Nieprawidłowa data';

  @override
  String get notes_showMore => 'Pokaż więcej';

  @override
  String get notes_showLess => 'Pokaż mniej';

  @override
  String get exerciseView_filteredOutExercises =>
      'Ćwiczenia niepasujące do filtrów:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Nie masz jeszcze żadnych ćwiczeń. Przejdź do sekcji „Ćwiczenie”, aby dodać pierwsze.';

  @override
  String get iconSelection_chooseIcon => 'Wybierz ikonę ćwiczenia';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Dodaj użytkownika i siłownię do ćwiczenia';

  @override
  String get exerciseExpansion_deleteExercise => 'Usuń ćwiczenie';

  @override
  String get exerciseExpansion_confirmDelete =>
      'Na pewno chcesz usunąć to ćwiczenie? Spowoduje to również usunięcie wszystkich powiązanych danych.';

  @override
  String get exerciseExpansion_addIcon => 'Dodaj ikonę do ćwiczenia';

  @override
  String get exerciseExpansion_unknownExercise => 'Nieznane ćwiczenie';

  @override
  String get exerciseExpansion_unknownUser => 'Nieznany użytkownik';

  @override
  String get exerciseExpansion_unknownGym => 'Nieznana siłownia';

  @override
  String get exerciseExpansion_noWorkouts => 'Brak dostępnych treningów';

  @override
  String get exerciseExpansion_changeNameTitle => 'Zmień nazwę ćwiczenia';

  @override
  String get exerciseExpansion_enterNewName => 'Nowa nazwa ćwiczenia';

  @override
  String get exerciseExpansion_exerciseNoteLabel => 'Notatka do ćwiczenia';

  @override
  String get exerciseExpansion_exerciseNoteHint =>
      'Dodaj ogólne informacje o ćwiczeniu, link do techniki lub ważne szczegóły, by mieć je pod ręką.';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Przypisz ćwiczenie do użytkownika i siłowni';
  }

  @override
  String get addUserAndGym_selectUser => 'Wybierz użytkownika';

  @override
  String get addUserAndGym_selectGym => 'Wybierz siłownię';

  @override
  String get addUserAndGym_confirmSelection => 'Potwierdź wybór';

  @override
  String get addUserAndGym_workoutExists =>
      'To ćwiczenie już istnieje dla wybranego użytkownika i siłowni.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Dodaj ogólną notatkę dla danego uzytkownika i siłowni – np. ustawienie maszyny, typ uchwytu, zalecenia techniczne, itp.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Ostatnia notatka: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Ustaw szybką wartość';

  @override
  String get resultsExpansion_quickValueSet =>
      'np. cel treningu lub najlepsza seria';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      'Czy na pewno chcesz usunąć tę sekcję wraz ze wszystkimi jej wynikami?';

  @override
  String get notes_title => 'Treningi';

  @override
  String get notes_addNote => '+ Dodaj notatkę';

  @override
  String get notes_cancel => 'Anuluj';

  @override
  String get notes_hint => 'Wpisz swoją notatkę...';

  @override
  String get notes_saveNote => 'Zapisz notatkę';

  @override
  String get notes_updateNote => 'Zaktualizuj notatkę';

  @override
  String get notes_empty => 'Brak dostępnych notatek';

  @override
  String get notes_emptyNote => 'Brak notatki';

  @override
  String get notes_deleteNoteTitle => 'Usuń notatkę';

  @override
  String get notes_deleteNoteConfirm =>
      'Czy na pewno chcesz usunąć tę notatkę?';

  @override
  String get notes_copy => 'Skopiuj notatkę';

  @override
  String get notes_copied => 'Notatka skopiowana do schowka';

  @override
  String get globalNote_title => 'Notatka globalna';

  @override
  String get globalNote_empty => 'Brak notatki';

  @override
  String get globalNote_hint => 'Ustaw notatkę globalną dla tego ćwiczenia';

  @override
  String get notificationScreen_title => 'Powiadomienia';

  @override
  String get notificationScreen_permissionTooltip =>
      'Kliknij, aby włączyć możliwość edytowania powiadomień';

  @override
  String get notificationList_title => 'Zapisane powiadomienia:';

  @override
  String get notificationList_empty => 'Brak zapisanych powiadomień.';

  @override
  String notificationList_hour(Object time) {
    return 'Godzina: $time';
  }

  @override
  String get notificationList_daily => 'Codziennie';

  @override
  String notificationList_interval(Object days) {
    return 'Co $days dni';
  }

  @override
  String get notificationList_weekly_none => 'Brak wybranych dni';

  @override
  String get notificationList_type_training => 'Trening';

  @override
  String get notificationList_type_weight => 'Waga';

  @override
  String get notificationList_type_measurement => 'Pomiar';

  @override
  String get notificationList_type_custom => 'Własne';

  @override
  String get notificationList_confirm_title => 'Potwierdzenie';

  @override
  String get notificationList_confirm_content =>
      'Czy na pewno chcesz usunąć to powiadomienie?';

  @override
  String get notificationList_deleteAll => 'Usuń wszystkie';

  @override
  String get notificationList_confirmAll_title =>
      'Usunąć wszystkie powiadomienia?';

  @override
  String get notificationList_confirmAll_content =>
      'Czy na pewno chcesz usunąć wszystkie zapisane powiadomienia?';

  @override
  String get notificationForm_titleLabel => 'Tytuł powiadomienia:';

  @override
  String get notificationForm_titleHint => 'Wpisz tytuł powiadomienia...';

  @override
  String get notificationForm_messageLabel => 'Treść powiadomienia:';

  @override
  String get notificationForm_messageHint =>
      'Wpisz własną treść powiadomienia...';

  @override
  String get notificationForm_addNotification => 'Dodaj powiadomienie';

  @override
  String get notificationForm_added => 'Powiadomienie zostało dodane!';

  @override
  String get notificationForm_typeLabel => 'Przypomnienie:';

  @override
  String get notificationForm_typeTraining => 'O treningu';

  @override
  String get notificationForm_typeWeight => 'O ważeniu';

  @override
  String get notificationForm_typeMeasurement => 'O pomiarach';

  @override
  String get notificationForm_typeCustom => 'Własne';

  @override
  String get notificationForm_modeLabel => 'Częstotliwość:';

  @override
  String get notificationForm_modeDaily => 'Codziennie';

  @override
  String get notificationForm_modeInterval => 'Co X dni';

  @override
  String get notificationForm_modeWeekly => 'Wybrane dni tygodnia';

  @override
  String get notificationForm_intervalPrefix => 'Co';

  @override
  String get notificationForm_intervalSuffix => 'd.';

  @override
  String get notificationForm_weekdayMon => 'Pn';

  @override
  String get notificationForm_weekdayTue => 'Wt';

  @override
  String get notificationForm_weekdayWed => 'Śr';

  @override
  String get notificationForm_weekdayThu => 'Cz';

  @override
  String get notificationForm_weekdayFri => 'Pt';

  @override
  String get notificationForm_weekdaySat => 'Sb';

  @override
  String get notificationForm_weekdaySun => 'Nd';

  @override
  String get notificationForm_defaultTitleTraining => 'Czas na trening!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'Nie zapomnij o swojej aktywności fizycznej.';

  @override
  String get notificationForm_defaultTitleWeight => 'Sprawdź swoją wagę';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Przypomnienie o ważeniu. Zapisz wynik w aplikacji.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Zrób pomiary';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Czas na pomiar ciała. Śledź swoje postępy!';

  @override
  String get notificationForm_testNotification => 'Przetestuj powiadomienie';

  @override
  String get timePicker_label => 'Godzina';

  @override
  String get watchAds_title => 'Obejrzyj reklamy, aby nas wesprzeć';

  @override
  String get watchAds_description =>
      'Obejrzyj krótką reklamę wideo i wesprzyj nas bez wydawania pieniędzy';

  @override
  String get watchAds_button => 'Obejrzyj reklamę';

  @override
  String get watchAds_counter => 'Obejrzane reklamy:';

  @override
  String get watchAds_error =>
      'Dziękujemy za wsparcie! Niestety nie udało się załadować reklamy.';

  @override
  String get watchAds_done =>
      'Gratulacje! Dotarłeś do dzisiejszego limitu. Limit odnowi się jutro.';

  @override
  String get watchAds_hide => 'Pokaż przycisk reklamy w sekcji treningowej';

  @override
  String get shareApp_title => 'Poleć GoGymSimple';

  @override
  String get shareApp_inviteTitle =>
      'Udostępnij aplikację znajomym i rodzinie!';

  @override
  String get shareApp_inviteSubtitle =>
      'Pomóż nam rozwinąć społeczność – podziel się aplikacją z osobami, którym może się przydać.';

  @override
  String get shareApp_shareButton => 'Udostępnij przez...';

  @override
  String get shareApp_linkCopied => 'Link został skopiowany do schowka';

  @override
  String get shareApp_shareText => 'Sprawdź tę aplikację:';

  @override
  String get shareApp_ratingTitle => 'Podoba Ci się GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      'Oceń nas! Twoja opinia pomoże innym odkryć aplikację.';

  @override
  String get shareApp_ratingYes => 'Jasne!';

  @override
  String get donate_title => 'Wesprzyj Nas';

  @override
  String get donateSections_whyTitle => 'Dlaczego warto nas wspierać?';

  @override
  String get donateSections_whyDesc =>
      'Twoje darowizny pomagają nam rozwijać ten projekt. Wszystkie wpłaty są dobrowolne i nie odblokowują żadnych dodatkowych funkcji.';

  @override
  String get donateSections_monthlyTitle => 'Wsparcie miesięczne';

  @override
  String get donateSections_monthlyDesc =>
      'Wspieraj nas co miesiąc, przekazując darowiznę';

  @override
  String get donateSections_monthlyButton => 'Wspieraj co miesiąc';

  @override
  String get donateSections_oneTimeTitle => 'Jednorazowa wpłata';

  @override
  String get donateSections_oneTimeDesc =>
      'Przekaż jednorazową wpłatę w wybranej kwocie';

  @override
  String get donateSections_oneTimeButton => 'Wpłać jednorazowo';

  @override
  String get donateSections_voluntaryTitle => '100% dobrowolnie';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Sklep jest niedostępny. Sprawdź połączenie internetowe.';

  @override
  String get donateSections_voluntaryDesc =>
      'Pamiętaj, że wszystkie darowizny są całkowicie dobrowolne. Nie otrzymasz żadnych dodatkowych funkcji – tylko naszą szczerą wdzięczność.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Ulubione ćwiczenia';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Wybierz kilka ćwiczeń, żeby zacząć';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Dodaj swoje ćwiczenie';

  @override
  String get welcomeExerciseStep_exampleExercise => 'np. bułgarskie przysiady';

  @override
  String get welcomeExerciseStep_addButton => 'Dodaj';

  @override
  String get welcomeExerciseStep_nextButton => 'Dalej';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferencje treningowe';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Gdzie najczęściej trenujesz?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'W domu';

  @override
  String get welcomeGymLocationStep_gym => 'Na siłowni';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Nazwa siłowni $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Dalej';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Witamy w GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Ustaw swój profil i zacznij przygodę z aplikacją';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Zaczynamy';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Twoje dane';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Imię';

  @override
  String get welcomeIntroSteps_nextButton => 'Dalej';

  @override
  String get welcomeSettingStep_appSettings => 'Ustawienia aplikacji';

  @override
  String get welcomeSettingStep_measurementSystem => 'System miar';

  @override
  String get welcomeSettingStep_metric => 'Metryczny';

  @override
  String get welcomeSettingStep_imperial => 'Imperialny';

  @override
  String get welcomeSettingStep_appTheme => 'Motyw aplikacji';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Przejdź do GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Wybierz język';

  @override
  String get welcomeScreen_english => 'Angielski';

  @override
  String get welcomeScreen_polish => 'Polski';

  @override
  String get welcomeScreen_languageTooltip => 'Zmień język';

  @override
  String get welcomeScreen_exercise_benchPress => 'Wyciskanie na ławce';

  @override
  String get welcomeScreen_exercise_squats => 'Przysiady';

  @override
  String get welcomeScreen_exercise_deadlift => 'Martwy ciąg';

  @override
  String get welcomeScreen_exercise_pullUps => 'Podciąganie';

  @override
  String get welcomeScreen_exercise_pushUps => 'Pompki';

  @override
  String get welcomeScreen_exercise_lunges => 'Wykroki';

  @override
  String get welcomeEnd_welcome => 'Witaj w GoGymSimple';

  @override
  String get stopwatch_title => 'Stoper';

  @override
  String get workoutScreen_title => 'Trening';

  @override
  String get workoutScreen_gym => 'Wybierz siłownię';

  @override
  String get workoutScreen_gymAndDate => 'Wybierz siłownię i datę';

  @override
  String get workoutScreen_selectGymFirst => 'Najpierw wybierz siłownię';

  @override
  String get workoutScreen_noGymSelected => 'Nie wybrano siłowni';

  @override
  String get workoutScreen_saved => 'Trening zapisany!';

  @override
  String get workoutScreen_participants => 'Uczestnicy';

  @override
  String get workoutScreen_plans => 'Plany';

  @override
  String get workoutScreen_exercises => 'Ćwiczenia';

  @override
  String get workoutScreen_addExercise => 'Dodaj ćwiczenie';

  @override
  String get workoutScreen_addNote => 'Dodaj notatkę';

  @override
  String get workoutScreen_saveNote => 'Zapisz notatkę';

  @override
  String get workoutScreen_savedNote => 'Notatka zapisana';

  @override
  String get workoutScreen_showMoreInfo => 'Pokaż więcej';

  @override
  String get workoutScreen_firstTime => 'Po raz pierwszy';

  @override
  String get workoutScreen_cancelWorkout => 'Przerwij trening';

  @override
  String get workoutScreen_workoutCancelled => 'Trening został przerwany';

  @override
  String get workoutScreen_addGeneralNote => 'Notatka treningowa';

  @override
  String get restoreSession_title => 'Trening przerwany';

  @override
  String get restoreSession_info => 'Twój poprzedni trening został przerwany.';

  @override
  String get restoreSession_content => 'Chcesz przywrócić postępy?';

  @override
  String get restoreSession_confirm => 'Tak, przywróć';

  @override
  String get restoreSession_deny => 'Zacznij od nowa';

  @override
  String get saveWorkoutDialog_save_workout_title => 'Zapisać trening?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Zapisz ten trening, aby móc do niego wrócić później';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Zapisz trening';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Nie teraz';

  @override
  String get saveWorkoutDialog_support_us_title => 'Wesprzyj nas';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      'Obejrzyj krótką reklamę, aby pomóc nam rozwijać aplikację!';

  @override
  String get editDeleteBottomSheet_edit => 'Edytuj';

  @override
  String get editDeleteBottomSheet_delete => 'Usuń';

  @override
  String get noTrainingSection_noSaved =>
      'Brak zapisanych treningów dla tego ćwiczenia';

  @override
  String get noTrainingSection_noSavedGlobal => 'Brak zapisanych treningów';

  @override
  String get noTrainingSection_startNewFirst =>
      'Kliknij przycisk \'Start\' w prawej górnej części ekranu, aby rozpocząć trening i zacząć zapisywać wyniki.';

  @override
  String get noTrainingSection_startNewSecond =>
      'Po uruchomieniu możesz go wznawiać i kontynuować kiedy tylko chcesz.';

  @override
  String get noTrainingSection_addPrevious =>
      'Możesz też dodać poprzednie treningi za pomocą tego przycisku, zmieniając tylko datę treningu.';

  @override
  String get shareApp_feedbackTitle => 'Masz pomysł?';

  @override
  String get shareApp_feedbackSubtitle =>
      'Jeśli masz pomysł, co mogłoby się pojawić w aplikacji – napisz wiadomość na moim prywatnym Instagramie! To przywilej dostępny tylko dla użytkowników pierwszej oficjalnej wersji GoGymSimple';

  @override
  String get shareApp_feedbackButton => 'Napisz na Instagramie (@wisnia.55)';

  @override
  String get goalAndBest_goal_title => 'Cel treningowy';

  @override
  String get goalAndBest_goal_hint => 'Wpisz cel treningu';

  @override
  String get goalAndBest_bestSet_title => 'Najlepsza seria';

  @override
  String get goalAndBest_bestSet_hint => 'Wpisz najlepszą serię';

  @override
  String get example_prefix => 'np.';

  @override
  String get exerciseStats_title => 'Statystyki';

  @override
  String get exerciseStats_timeStats => 'Statystyki czasowe:';

  @override
  String get exerciseStats_noteStats => 'Statystyki notatek:';

  @override
  String get exerciseStats_totalNotes => 'Notatki (całość)';

  @override
  String get exerciseStats_lastWeek => 'Notatki (ostatni tydzień)';

  @override
  String get exerciseStats_lastMonth => 'Notatki (ostatni miesiąc)';

  @override
  String get exerciseStats_lastYear => 'Notatki (ostatni rok)';

  @override
  String get exerciseStats_avgLines => 'Śr. liczba linijek';

  @override
  String get exerciseStats_avgChars => 'Śr. liczba znaków';

  @override
  String get exerciseStats_totalLines => 'Łączna liczba linijek';

  @override
  String get exerciseStats_totalChars => 'Łączna liczba znaków';

  @override
  String get exerciseStats_none => 'Brak';

  @override
  String get exerciseNoteTile_suggestedLength => 'Sugerowana długość: ';

  @override
  String get exerciseNoteTile_infoTitle => 'Informacja o długości notatki';

  @override
  String get exerciseNoteTile_infoContent =>
      'Możesz bez problemu przekroczyć 200 znaków, jednak zalecana jest krótsza notatka. Dłuższe treści mogą wpływać na szybkość przesyłania danych oraz zajmować więcej miejsca w pamięci aplikacji.';

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
  String get multiSelect_title => 'Wybierz wiele ćwiczeń';

  @override
  String get multiSelect_subtitle => 'Wybierz spośród popularnych ćwiczeń';

  @override
  String get multiSelect_added => 'dodano';
}
