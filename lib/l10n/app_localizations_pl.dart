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
  String get settings_elementVisibility => 'Pokaż stoper na ekranie głównym';

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
  String get settings_metric => 'Metr/Kilogram';

  @override
  String get settings_imperial => 'Cal/Funt';

  @override
  String get daysAgo_noData => 'Brak danych';

  @override
  String get daysAgo_lessThanOneHour => '<1 godzinę temu';

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
  String get dialog_content => 'Czy na pewno chcesz kontynuować?';

  @override
  String get dialog_cancel => 'Anuluj';

  @override
  String get dialog_confirm => 'Potwierdź';

  @override
  String get dialog_save => 'Zapisz';

  @override
  String get inputFormField_labelText => 'Wprowadź wartość';

  @override
  String get inputFormField_invalidValue =>
      'Nieprawidłowa wartość. Wprowadź liczbę.';

  @override
  String get addPattern_title => 'Dodaj nową paletę kolorów';

  @override
  String get addPattern_iconsText =>
      'Tak będą wyglądać ikony oraz tekst na tym kolorze';

  @override
  String get addPattern_textExample =>
      'A tak będzie wyglądał ten tekst z innym odcieniem';

  @override
  String get addPattern_backgroundColor => 'Kolor tła';

  @override
  String get addPattern_sectionColor => 'Kolor sekcji';

  @override
  String get addPattern_textIconsColor => 'Kolor tekstu i ikon';

  @override
  String get addPattern_save => 'Zapisz';

  @override
  String get addPattern_moreColors => 'Wiecej kolorów';

  @override
  String get customizeApp_availableColorPalettes => 'Dostępne motywy';

  @override
  String get customizeApp_currentTheme => 'Aktualnie ustawiony motyw';

  @override
  String get customizeApp_setTheme => 'Ustaw motyw';

  @override
  String get customizeApp_deleteTheme => 'Usuń motyw';

  @override
  String get customizeApp_confirmDelete =>
      'Czy na pewno chcesz usunąć ten motyw?';

  @override
  String get customizeApp_applyTheme => 'Zastosuj motyw';

  @override
  String get savePalette_saveTheme => 'Zapisz motyw';

  @override
  String savePalette_themeSaved(Object name) {
    return 'Motyw \"$name\" został zapisany. Przejdź do poprzedniego okna, aby go zastosować';
  }

  @override
  String get savePalette_themeName => 'Nazwa motywu';

  @override
  String get fullColorPicker_chooseColor => 'Wybierz kolor';

  @override
  String get fullColorPicker_save => 'Zapis';

  @override
  String get applyNewTheme => 'Zastosowano nowy motyw';

  @override
  String get calculator1RM_title => 'Kalkulator 1RM';

  @override
  String get calculator1RM_infoText =>
      'Uzupełnij wszystkie dane w polach poniżej, aby zobaczyć wynik 1RM';

  @override
  String get calculator1RM_weightLabel => 'Waga';

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
  String get calculator1RM_table_header_weight => 'Waga';

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
    return 'ok. $max – ${min}g białka dziennie';
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
  String get calculatorBmr_weight_label_metric => 'WAGA (kg)';

  @override
  String get calculatorBmr_height_label_metric => 'WZROST (cm)';

  @override
  String get calculatorBmr_weight_label_imperial => 'WAGA (lbs)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ft';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'in';

  @override
  String get calculatorBmr_age_label => 'WIEK';

  @override
  String get calculatorBmr_male => 'Mężczyzna';

  @override
  String get calculatorBmr_female => 'Kobieta';

  @override
  String get calculatorBmr_info =>
      'Uzupełnij wszystkie dane w polach poniżej, aby zobaczyć wynik BMR';

  @override
  String get bmrInfo_title => 'Informacje o BMR i białku:';

  @override
  String get bmrInfo_text1 =>
      'BMR (Basal Metabolic Rate) to wskaźnik, który mówi, ile kalorii Twoje ciało potrzebuje w spoczynku, aby utrzymać podstawowe funkcje życiowe.';

  @override
  String get bmrInfo_text2 =>
      'Poziom aktywności wpływa na wartość BMR. Wyższy poziom aktywności oznacza większe zapotrzebowanie na kalorie.';

  @override
  String get bmrInfo_recommended =>
      'Zalecane spożycie BIAŁKA zależy od poziomu aktywności fizycznej, a oto jego zakresy w zależności od poziomu aktywności:';

  @override
  String get bmrInfo_close => 'Zamknij';

  @override
  String get perKilogram => 'na kilogram masy ciała';

  @override
  String get perPound => 'na funt masy ciała';

  @override
  String get plateCalculator_plateCalculator => 'Kalkulator talerzy na strone';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Kliknij, aby zobaczyć proponowane talerze';

  @override
  String get plateCalculator_fillOutData =>
      'Wypełnij pola poniżej, aby zobaczyć wymagany ciężar na stronę. CAŁKOWITA WAGA musi być większa niż WAGA SZTANGI.';

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
  String get plateDialog_invalidWeight => 'Waga musi przekraczać wagę sztangi';

  @override
  String get plateDialog_invalidTargetWeight => 'Docelowa waga zbyt mała';

  @override
  String get plateDialog_noCombinationFound =>
      'Nie można ułożyć poprawnej kombinacji talerzy dla wybranej wagi';

  @override
  String get measurementTile_noData =>
      'Brak danych. Wciśnij przycisk \'Pomiar\', aby dodać wartość.';

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
  String get measurementTracker_body_measurements => 'Pomiar ciała';

  @override
  String get measurementTracker_no_data_to_show =>
      'Brak danych do wyświetlenia';

  @override
  String get measurementTracker_add_new_category => 'Dodaj nową kategorię';

  @override
  String get measurementTracker_name_new_category => 'Nazwa kategorii';

  @override
  String get measurementTracker_name_new_measurement => 'Wartość pomiaru';

  @override
  String get measurementTracker_add_new_measurement => 'Dodaj nowy pomiar';

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
      'Możesz dodać nową kategorię za pomocą przycisku poniżej.';

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
  String get drawer_privacyPolicy => 'Polityka Prywatności';

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
      'Nie wybrano jeszcze żadnych ćwiczeń.';

  @override
  String get addWorkoutPlan_availableExercises => 'Dostępne ćwiczenia:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Dodaj nowe ćwiczenie';

  @override
  String get addWorkoutPlan_save => 'Zapisz plan treningowy';

  @override
  String get addWorkoutPlan_missingName => 'Podaj nazwę planu treningowego.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Wybierz przynajmniej jedno ćwiczenie.';

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
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Wprowadź nazwę planu treningowego';

  @override
  String get tabBottomDrawer_editTitle => 'Edytij nazwę';

  @override
  String get tabBottomDrawer_editExercise => 'Edytuj ćwiczenie';

  @override
  String get tabBottomDrawer_editLabel => 'Wpisz nową nazwę';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Odśwież ekran, aby wyswietlić zmiany';

  @override
  String get tabSector_gym => 'Siłownia';

  @override
  String get tabSector_user => 'Użytkownik';

  @override
  String get tabSector_exercise => 'Ćwiczenie';

  @override
  String get tabSector_workoutPlan => 'Plan treningowy';

  @override
  String get tabSector_userGym => 'Użytkownik i Siłownia';

  @override
  String get tabSector_filter => 'Filtruj';

  @override
  String get sortSector_aToZ => 'A ... Z';

  @override
  String get sortSector_zToA => 'Z ... A';

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
  String get historyView_exerciseNotFound => 'Ćwiczenie nie znalezione';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'W tej sekcji będą wyświetlane notatki z Twoich treningów';

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
  String get notes_deleteNoteTitle => 'Usuń notatkę';

  @override
  String get notes_deleteNoteConfirm =>
      'Czy na pewno chcesz usunąć tę notatkę?';

  @override
  String get notes_copy => 'Skopiuj notatkę';

  @override
  String get notes_copied => 'Notatka skopiowana do schowka';

  @override
  String get exerciseView_sortDesc => 'Z ... A';

  @override
  String get exerciseView_sortAsc => 'A ... Z';

  @override
  String get exerciseView_filteredOutExercises =>
      'Ćwiczenia niepasujące do filtrów:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Nie masz jeszcze żadnych ćwiczeń. Przejdź do sekcji \'Ćwiczenie\', aby dodać pierwsze.';

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
      'Czy na pewno chcesz usunąć to ćwiczenie? Spowoduje to również usunięcie wszystkich danych powiązanych z tym ćwiczeniem.';

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
      'Ten trening już istnieje dla wybranego użytkownika i siłowni.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Dodaj ogólną notatkę dla ćwiczenia – np. ustawienie maszyny, typ uchwytu, zalecenia techniczne, itp.';
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
      'np. cel treningu lub najlepszą serie';

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
  String get notes_updateNote => 'Aktualizuj notatkę';

  @override
  String get notes_empty => 'Brak dostępnych notatek';

  @override
  String get notes_emptyNote => 'Brak notatki';

  @override
  String get globalNote_title => 'Notatka globalna';

  @override
  String get globalNote_empty => 'Brak notatki...';

  @override
  String get globalNote_hint => 'Wprowadź notatkę';

  @override
  String get notificationScreen_title => 'Powiadomienia';

  @override
  String get notificationScreen_permissionTooltip =>
      'Kliknij tutaj, aby włączyć edytowalne powiadomienia';

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
  String get notificationList_weekly_none => 'Brak dni';

  @override
  String get notificationList_type_training => 'Trening';

  @override
  String get notificationList_type_weight => 'Waga';

  @override
  String get notificationList_type_measurement => 'Pomiar';

  @override
  String get notificationList_type_custom => 'Niestandardowe';

  @override
  String get notificationList_confirm_title => 'Potwierdzenie';

  @override
  String get notificationList_confirm_content =>
      'Czy na pewno chcesz usunąć to powiadomienie?';

  @override
  String get notificationList_deleteAll => 'Usuń wszystkie';

  @override
  String get notificationList_confirmAll_title =>
      'Usuń wszystkie powiadomienia?';

  @override
  String get notificationList_confirmAll_content =>
      'Czy na pewno chcesz usunąć wszystkie zapisane powiadomienia?';

  @override
  String get notificationForm_titleLabel => 'Tytuł powiadomienia:';

  @override
  String get notificationForm_titleHint =>
      'Wpisz własny tytuł powiadomienia...';

  @override
  String get notificationForm_messageLabel => 'Treść powiadomienia:';

  @override
  String get notificationForm_messageHint =>
      'Wpisz własną treść powiadomienia...';

  @override
  String get notificationForm_addNotification => 'Dodaj powiadomienie';

  @override
  String get notificationForm_added => 'Powiadomienie dodane!';

  @override
  String get notificationForm_typeLabel => 'Przypomnienie:';

  @override
  String get notificationForm_typeTraining => 'O treningu';

  @override
  String get notificationForm_typeWeight => 'O zmierzeniu wagi';

  @override
  String get notificationForm_typeMeasurement => 'O pomiarze ciała';

  @override
  String get notificationForm_typeCustom => 'Niestandardowe';

  @override
  String get notificationForm_modeLabel => 'Harmonogram:';

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
  String get notificationForm_defaultTitleWeight => 'Sprawdź wagę';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Przypomnienie o ważeniu. Zapisz wynik w aplikacji.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Zrób pomiary';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Czas na pomiar ciała. Śledź swoje postępy!';

  @override
  String get notificationForm_testNotification => 'Testuj powiadomienie';

  @override
  String get timePicker_label => 'Godzina';

  @override
  String get watchAds_title => 'Obejrzyj reklamy, aby nas wesprzeć';

  @override
  String get watchAds_description =>
      'Obejrzyj krótką reklame wideo, aby nas wesprzeć bez wydawania pieniędzy';

  @override
  String get watchAds_button => 'Obejrzyj reklamę';

  @override
  String get watchAds_counter => 'Obejrzane reklamy:';

  @override
  String get watchAds_error =>
      'Dziękujemy za wsparcie! Niestety reklama nie mogła zostać załadowana';

  @override
  String get shareApp_title => 'Poleć GoGymSimple';

  @override
  String get shareApp_inviteTitle =>
      'Udostępnij aplikację znajomym i rodzinie!';

  @override
  String get shareApp_inviteSubtitle =>
      'Pomóż nam rozwinąć społeczność, udostępniając aplikację osobom, które mogą ją uznać za przydatną.';

  @override
  String get shareApp_shareText => 'Sprawdź tę aplikację:';

  @override
  String get shareApp_shareButton => 'Udostępnij przez...';

  @override
  String get shareApp_linkCopied => 'Link skopiowany do schowka';

  @override
  String get shareApp_ratingTitle => 'Podoba Ci się GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      'Czy chciałbyś ocenić GoGymSimple? Twoja opinia pomaga innym odkryć tę aplikację.';

  @override
  String get shareApp_ratingYes => 'Jasne!';

  @override
  String get donate_title => 'Wesprzyj Nas';

  @override
  String get donateSections_whyTitle => 'Dlaczego nas wspierać?';

  @override
  String get donateSections_whyDesc =>
      'Twoje darowizny pomagają nam utrzymać i rozwijać ten projekt. Wszystkie wpłaty są dobrowolne i nie odblokowują żadnych specjalnych funkcji ani treści.';

  @override
  String get donateSections_monthlyTitle => 'Subskrypcja miesięczna';

  @override
  String get donateSections_monthlyDesc =>
      'Wspieraj nas comiesięczną darowizną';

  @override
  String get donateSections_monthlyButton => 'Subskrybuj miesięcznie';

  @override
  String get donateSections_oneTimeTitle => 'Jednorazowa darowizna';

  @override
  String get donateSections_oneTimeDesc =>
      'Wnieś jednorazową wpłatę w wybranej kwocie';

  @override
  String get donateSections_oneTimeButton => 'Wpłać teraz';

  @override
  String get donateSections_voluntaryTitle => '100% Dobrowolnie';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Sklep niedostępny. Sprawdź połączenie internetowe';

  @override
  String get donateSections_voluntaryDesc =>
      'Pamiętaj, że wszystkie darowizny są całkowicie dobrowolne. Nie otrzymasz żadnych specjalnych funkcji ani treści – jedynie naszą szczerą wdzięczność za wsparcie projektu.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Ulubione ćwiczenia';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Wybierz kilka ćwiczeń, aby zacząć';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Dodaj własne ćwiczenie';

  @override
  String get welcomeExerciseStep_exampleExercise => 'np. Bułgarskie przysiady';

  @override
  String get welcomeExerciseStep_addButton => 'Dodaj';

  @override
  String get welcomeExerciseStep_nextButton => 'Dalej';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferencje treningowe';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      'Gdzie zwykle trenujesz?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Trening w domu';

  @override
  String get welcomeGymLocationStep_gym => 'Siłownia';

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
      'Ustaw swój profil, aby rozpocząć swoją przygodę z aplikacją';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Rozpocznij';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Dane osobowe';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Twoje imię';

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
  String get welcomeSettingStep_enterGoGymSimple => 'Wejdź do GoGymSimple';

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
  String get welcomeScreen_exercise_pullUps => 'Podciąganie na drążku';

  @override
  String get welcomeScreen_exercise_pushUps => 'Pompki';

  @override
  String get welcomeScreen_exercise_lunges => 'Wykroki';

  @override
  String get welcomeEnd_welcome => 'Witaj w GoGym';

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
  String get workoutScreen_savedNote => 'Zapisano';

  @override
  String get workoutScreen_showMoreInfo => 'Pokaż więcej informacji';

  @override
  String get workoutScreen_firstTime => 'Pierwszy raz';

  @override
  String get restoreSession_title => 'Trening przerwany';

  @override
  String get restoreSession_info => 'Twój poprzedni trening został przerwany.';

  @override
  String get restoreSession_content => 'Czy chcesz przywrócić postępy?';

  @override
  String get restoreSession_confirm => 'Tak, przywróć';

  @override
  String get restoreSession_deny => 'Zacznij od nowa';

  @override
  String get saveWorkoutDialog_save_workout_title => 'Chcesz zapisać trening?';

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
      'Obejrzyj krótką reklamę, aby wesprzeć aplikację!';

  @override
  String get editDeleteBottomSheet_edit => 'Edytuj';

  @override
  String get editDeleteBottomSheet_delete => 'Usuń';

  @override
  String get noTrainingSection_noSaved =>
      'Brak zapisanych treningów dla tego ćwiczenia';

  @override
  String get noTrainingSection_startNew =>
      'Aby rozpocząć nowy trening i zapisywać wyniki, kliknij przycisk:';

  @override
  String get noTrainingSection_addPrevious =>
      'Możesz również użyć tego przycisku, aby dodawać poprzednie treningi';
}
