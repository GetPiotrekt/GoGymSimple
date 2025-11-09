// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get unknownExercise => 'Ejercicio desconocido';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_elementVisibility =>
      'Mostrar cronómetro en la pantalla principal';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_english => 'Inglés';

  @override
  String get settings_polish => 'Polaco';

  @override
  String get settings_spanish_spain => 'Español – España';

  @override
  String get settings_spanish_colombia => 'Español – Colombia';

  @override
  String get settings_german => 'Alemán';

  @override
  String get settings_dutch => 'Neerlandés';

  @override
  String get settings_portuguese => 'Portugués';

  @override
  String get settings_italian => 'Italiano';

  @override
  String get settings_otherLanguages => 'Otros idiomas (próximamente)';

  @override
  String get settings_availableLanguages => 'Idiomas disponibles';

  @override
  String get settings_units => 'Unidades';

  @override
  String get settings_metric => 'Metro/Kilogramo';

  @override
  String get settings_imperial => 'Pulgada/Libra';

  @override
  String get daysAgo_noData => 'Sin datos';

  @override
  String get daysAgo_lessThanOneHour => 'Hace menos de 1 hora';

  @override
  String get daysAgo_oneHourAgo => 'Hace 1 hora';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count horas',
      many: 'Hace $count horas',
      few: 'Hace $count horas',
      one: 'Hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => 'Hace 1 día';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count días',
      many: 'Hace $count días',
      few: 'Hace $count días',
      one: 'Hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => 'Hace 1 semana';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count semanas',
      many: 'Hace $count semanas',
      few: 'Hace $count semanas',
      one: 'Hace 1 semana',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Hace mucho tiempo';

  @override
  String get confirmationDialog_title => 'Confirmación';

  @override
  String get deleteConfirmationDialog_title => 'Confirmación de eliminación';

  @override
  String get dialog_content => '¿Estás seguro de que quieres continuar?';

  @override
  String get dialog_cancel => 'Cancelar';

  @override
  String get dialog_confirm => 'Confirmar';

  @override
  String get dialog_save => 'Guardar';

  @override
  String get inputFormField_labelText => 'Introduce un valor';

  @override
  String get inputFormField_invalidValue =>
      'Valor inválido. Introduce un número.';

  @override
  String get addPattern_title => 'Añadir nueva paleta de colores';

  @override
  String get addPattern_iconsText =>
      'Así se verán los iconos y el texto en este color';

  @override
  String get addPattern_textExample =>
      'Así se verá este texto con un tono diferente';

  @override
  String get addPattern_backgroundColor => 'Color de fondo';

  @override
  String get addPattern_sectionColor => 'Color de sección';

  @override
  String get addPattern_textIconsColor => 'Color del texto y los iconos';

  @override
  String get addPattern_save => 'Guardar';

  @override
  String get customizeApp_availableColorPalettes => 'Temas disponibles';

  @override
  String get customizeApp_currentTheme => 'Tema actual';

  @override
  String get customizeApp_setTheme => 'Establecer tema';

  @override
  String get customizeApp_deleteTheme => 'Eliminar tema';

  @override
  String get customizeApp_confirmDelete =>
      '¿Seguro que quieres eliminar este tema?';

  @override
  String get customizeApp_applyTheme => 'Aplicar tema';

  @override
  String get savePalette_saveTheme => 'Guardar tema';

  @override
  String savePalette_themeSaved(Object name) {
    return 'El tema \"$name\" ha sido guardado. Vuelve a la ventana anterior para aplicarlo';
  }

  @override
  String get savePalette_themeName => 'Nombre del tema';

  @override
  String get addPattern_moreColors => 'Más colores';

  @override
  String get fullColorPicker_chooseColor => 'Elegir color';

  @override
  String get fullColorPicker_save => 'Guardar';

  @override
  String get applyNewTheme => 'Nuevo tema aplicado';

  @override
  String get calculator1RM_title => 'Calculadora 1RM';

  @override
  String get calculator1RM_infoText =>
      'Rellena todos los campos abajo para ver el resultado del 1RM';

  @override
  String get calculator1RM_weightLabelKg => 'Weight (kg)';

  @override
  String get calculator1RM_weightLabelLbs => 'Weight (lbs)';

  @override
  String get calculator1RM_repsLabel => 'NÚMERO DE REPETICIONES';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Tu 1RM es: $value kg, lo que corresponde a:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Tu 1RM es: $value lbs, lo que corresponde a:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Porcentaje';

  @override
  String get calculator1RM_table_header_reps => 'Repeticiones';

  @override
  String get calculator1RM_table_header_weight => 'Peso';

  @override
  String get infoDialog1RM_title => 'Acerca de la Calculadora 1RM';

  @override
  String get infoDialog1RM_description =>
      'La calculadora 1RM estima el peso máximo que puedes levantar para una repetición basándose en el peso y el número de repeticiones realizadas en una serie. Se usa la fórmula popular de Brzycki.';

  @override
  String get infoDialog1RM_closeButton => 'Cerrar';

  @override
  String get bmrResults_title => 'Tu BMR según la actividad:';

  @override
  String get bmrResults_noData => 'Sin datos';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'aprox. $max – ${min}g de proteína al día';
  }

  @override
  String get basicActivity => 'Requerimiento básico';

  @override
  String get lowActivity => 'Actividad baja';

  @override
  String get moderateActivity => 'Actividad moderada';

  @override
  String get highActivity => 'Alta actividad';

  @override
  String get veryHighActivity => 'Actividad muy alta';

  @override
  String get calculatorBmr_title => 'Calculadora BMR';

  @override
  String get calculatorBmr_weight => 'Weight';

  @override
  String get calculatorBmr_height_label_metric => 'ALTURA (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ALTURA (pies)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'ALTURA (pulgadas)';

  @override
  String get calculatorBmr_age_label => 'EDAD';

  @override
  String get calculatorBmr_male => 'Hombre';

  @override
  String get calculatorBmr_female => 'Mujer';

  @override
  String get calculatorBmr_info =>
      'Rellena todos los campos abajo para ver el resultado del BMR';

  @override
  String get bmrInfo_title => 'Información sobre BMR y proteína:';

  @override
  String get bmrInfo_text1 =>
      'El BMR (Tasa Metabólica Basal) es un indicador que muestra cuántas calorías necesita tu cuerpo en reposo para mantener las funciones vitales básicas.';

  @override
  String get bmrInfo_text2 =>
      'El nivel de actividad influye en el valor del BMR. Un mayor nivel de actividad significa un mayor requerimiento calórico.';

  @override
  String get bmrInfo_recommended =>
      'La ingesta recomendada de PROTEÍNA depende del nivel de actividad física, y aquí tienes los rangos según el nivel de actividad:';

  @override
  String get bmrInfo_close => 'Cerrar';

  @override
  String get perKilogram => 'por kilogramo de peso corporal';

  @override
  String get perPound => 'por libra de peso corporal';

  @override
  String get plateCalculator_plateCalculator =>
      'Calculadora de discos por lado';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Haz clic para ver los discos propuestos';

  @override
  String get plateCalculator_fillOutData =>
      'Rellena los campos de abajo para ver el peso requerido por lado. EL PESO TOTAL debe ser mayor que EL PESO DE LA BARRA.';

  @override
  String get plateCalculator_selectPlates =>
      'Selecciona los discos disponibles:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'PESO DE LA BARRA (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'PESO DE LA BARRA (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'PESO TOTAL (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'PESO TOTAL (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Peso por lado: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Peso por lado: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Discos propuestos';

  @override
  String get plateDialog_forSide => 'POR LADO';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Opción $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Cerrar';

  @override
  String get plateDialog_invalidWeight =>
      'El peso debe ser mayor que el de la barra';

  @override
  String get plateDialog_invalidTargetWeight =>
      'El peso objetivo es demasiado bajo';

  @override
  String get plateDialog_noCombinationFound =>
      'No se encontró una combinación válida de discos para el peso seleccionado';

  @override
  String get measurementTile_noData =>
      'No hay datos. Pulsa el botón \'Medir\' para añadir un valor.';

  @override
  String get measurementTile_addData => 'Medir';

  @override
  String get measurementTile_baseline => 'Base';

  @override
  String get measurementTile_deleteCategory => 'Eliminar categoría';

  @override
  String get measurementTile_today => 'Hoy';

  @override
  String get measurementTile_yesterday => 'Ayer';

  @override
  String get measurementTracker_body_measurements => 'Mediciones corporales';

  @override
  String get measurementTracker_no_data_to_show => 'No hay datos para mostrar';

  @override
  String get measurementTracker_add_new_category => 'Añadir nueva categoría';

  @override
  String get measurementTracker_name_new_category => 'Nombre de la categoría';

  @override
  String get measurementTracker_name_new_measurement => 'Valor de la medición';

  @override
  String get measurementTracker_add_new_measurement => 'Añadir nueva medición';

  @override
  String get measurementTracker_update_category => 'Actualizar categoría';

  @override
  String get measurementTracker_delete_category_confirmation =>
      '¿Seguro que quieres eliminar esta categoría?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      '¿Seguro que quieres eliminar esta medición?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'La medición para \'$bodyPart\' ha sido eliminada.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'La categoría \'$category\' ha sido eliminada.';
  }

  @override
  String get measurementTracker_category_exists => '¡Esa categoría ya existe!';

  @override
  String get measurementTracker_invalid_value => '¡Valor no válido!';

  @override
  String get measurementTracker_invalid_category =>
      '¡Categoría seleccionada no válida!';

  @override
  String get measurementTracker_add_category_hint =>
      'Puedes añadir una nueva categoría con el botón de abajo.';

  @override
  String get measurementTracker_measurementDate => 'Fecha de medición';

  @override
  String get weightTracker_title => 'Seguimiento de peso';

  @override
  String get weightTracker_enterWeightKg => 'Introduce peso (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Introduce peso (lbs)';

  @override
  String get weightTracker_saveWeight => 'Guardar peso';

  @override
  String get weightTracker_updateWeight => 'Actualizar peso';

  @override
  String get weightTracker_yourWeight => 'Tu peso';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' hace $daysAgo días';
  }

  @override
  String get weightTracker_legendWeightSaved => 'Días con peso guardado';

  @override
  String get drawer_tools_section => 'Herramientas';

  @override
  String get drawer_calculators_section => 'Calculadoras';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Discos en barra';

  @override
  String get drawer_time_section => 'Tiempo';

  @override
  String get drawer_stopwatch => 'Cronómetro';

  @override
  String get drawer_trackers_section => 'Seguimiento';

  @override
  String get drawer_weightTracker => 'Seguimiento de peso';

  @override
  String get drawer_measurementTracker => 'Seguimiento de mediciones';

  @override
  String get drawer_settings_section => 'Ajustes';

  @override
  String get drawer_customizeApp => 'Personalizar tema';

  @override
  String get drawer_appLanguage => 'Idioma';

  @override
  String get drawer_notificationSettings => 'Notificaciones';

  @override
  String get drawer_appreciation_section => 'Apoyo';

  @override
  String get drawer_supportButton => 'Hacer donación';

  @override
  String get drawer_watchAd => 'Ver anuncio';

  @override
  String get drawer_shareApp => 'Compartir app';

  @override
  String get drawer_noteCount => 'Número de notas guardadas: ';

  @override
  String get drawer_guest => 'Invitado';

  @override
  String get drawer_privacyPolicy => 'Política de privacidad';

  @override
  String get drawer_termsOfUse => 'Términos de uso';

  @override
  String get searchDrawer_hint => 'Buscar...';

  @override
  String get searchDrawer_clear => 'Borrar búsqueda';

  @override
  String get addExerciseDialog_title => 'Añadir nuevo ejercicio';

  @override
  String get addExerciseDialog_label => 'Introduce el nombre del ejercicio';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Ejercicio \"$exerciseName\" añadido';
  }

  @override
  String get addExerciseDialog_anotherTitle => '¿Añadir otro ejercicio?';

  @override
  String get addExerciseDialog_anotherContent =>
      '¿Quieres añadir otro ejercicio?';

  @override
  String get addWorkoutPlan_title => 'Añadir plan de entrenamiento';

  @override
  String get addWorkoutPlan_planName => 'Nombre del plan de entrenamiento';

  @override
  String get addWorkoutPlan_selectedExercises => 'Ejercicios seleccionados:';

  @override
  String get addWorkoutPlan_noExercises =>
      'No se han seleccionado ejercicios aún.';

  @override
  String get addWorkoutPlan_availableExercises => 'Ejercicios disponibles:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Añadir nuevo ejercicio';

  @override
  String get addWorkoutPlan_save => 'Guardar plan de entrenamiento';

  @override
  String get addWorkoutPlan_missingName =>
      'Introduce un nombre para el plan de entrenamiento.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Selecciona al menos un ejercicio.';

  @override
  String get tabBottomDrawer_showOnly => 'Mostrar solo:';

  @override
  String get tabBottomDrawer_addNewGym => 'Añadir gimnasio';

  @override
  String get tabBottomDrawer_addNewUser => 'Añadir usuario';

  @override
  String get tabBottomDrawer_addNewExercise => 'Añadir ejercicio';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan =>
      'Añadir plan de entrenamiento';

  @override
  String get tabBottomDrawer_enterGymName => 'Introduce el nombre del gimnasio';

  @override
  String get tabBottomDrawer_enterUserName => 'Introduce el nombre del usuario';

  @override
  String get tabBottomDrawer_editTitle => 'Editar nombre';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Introduce el nombre del plan de entrenamiento';

  @override
  String get tabBottomDrawer_editExercise => 'Editar ejercicio';

  @override
  String get tabBottomDrawer_editLabel => 'Introduce un nuevo nombre';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Actualiza la pantalla para ver los cambios';

  @override
  String get tabBottomDrawer_reorderExercises => 'Reordenar ejercicios';

  @override
  String get tabSector_gym => 'Gimnasio';

  @override
  String get tabSector_user => 'Usuario';

  @override
  String get tabSector_exercise => 'Ejercicio';

  @override
  String get tabSector_workoutPlan => 'Plan de entrenamiento';

  @override
  String get tabSector_filter => 'Filtrar';

  @override
  String get tabSector_userGym => 'Usuario y Gimnasio';

  @override
  String get sortSector_newest => 'Más recientes';

  @override
  String get sortSector_oldest => 'Más antiguos';

  @override
  String get sortSector_exerciseView => 'Ejercicios';

  @override
  String get sortSector_historyView => 'Historial';

  @override
  String get historyView_noWorkouts => 'No hay entrenamientos disponibles';

  @override
  String get historyView_exerciseNotFound => 'Ejercicio no encontrado';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'En esta sección se mostrarán las notas de tus entrenamientos';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Ningún resultado coincide con tus filtros.';

  @override
  String get notes_justNow => 'Justo ahora';

  @override
  String notes_minutesAgo(Object count) {
    return 'Hace $count minutos';
  }

  @override
  String notes_hoursAgo(Object count) {
    return 'Hace $count horas';
  }

  @override
  String notes_daysAgo(Object count) {
    return 'Hace $count días';
  }

  @override
  String get notes_invalidDate => 'Fecha no válida';

  @override
  String get notes_showMore => 'Mostrar más';

  @override
  String get notes_showLess => 'Mostrar menos';

  @override
  String get exerciseView_filteredOutExercises =>
      'Ejercicios que no coinciden con los filtros:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Entra en la sección \'Ejercicio\' para añadir tu primer ejercicio.';

  @override
  String get iconSelection_chooseIcon => 'Elige un icono para el ejercicio';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Añadir usuario y gimnasio al ejercicio';

  @override
  String get exerciseExpansion_deleteExercise => 'Eliminar ejercicio';

  @override
  String get exerciseExpansion_confirmDelete =>
      '¿Seguro que quieres eliminar este ejercicio? Esto también eliminará todos los datos relacionados con él.';

  @override
  String get exerciseExpansion_addIcon => 'Añadir icono al ejercicio';

  @override
  String get exerciseExpansion_unknownExercise => 'Ejercicio desconocido';

  @override
  String get exerciseExpansion_unknownUser => 'Usuario desconocido';

  @override
  String get exerciseExpansion_unknownGym => 'Gimnasio desconocido';

  @override
  String get exerciseExpansion_noWorkouts =>
      'No hay entrenamientos disponibles';

  @override
  String get exerciseExpansion_changeNameTitle =>
      'Cambiar nombre del ejercicio';

  @override
  String get exerciseExpansion_enterNewName => 'Nuevo nombre del ejercicio';

  @override
  String get exerciseExpansion_exerciseNoteLabel => 'Exercise note';

  @override
  String get exerciseExpansion_exerciseNoteHint =>
      'Add general info about the exercise—like a link to proper form or a helpful site—so it\'s always right at your fingertips.';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Asignar ejercicio a usuario y gimnasio';
  }

  @override
  String get addUserAndGym_selectUser => 'Selecciona usuario';

  @override
  String get addUserAndGym_selectGym => 'Selecciona gimnasio';

  @override
  String get addUserAndGym_confirmSelection => 'Confirmar selección';

  @override
  String get addUserAndGym_workoutExists =>
      'Este entrenamiento ya existe para el usuario y gimnasio seleccionados.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Agrega una nota general para el ejercicio, por ejemplo: configuración de la máquina, tipo de agarre, consejos técnicos, etc.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Última nota: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Establecer valor rápido';

  @override
  String get resultsExpansion_quickValueSet =>
      'p. ej. objetivo del entrenamiento o la mejor serie';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      '¿Seguro que quieres eliminar esta sección junto con todos sus resultados?';

  @override
  String get notes_title => 'Notas de Entrenamiento';

  @override
  String get notes_addNote => '+ Añadir nota';

  @override
  String get notes_cancel => 'Cancelar';

  @override
  String get notes_hint => 'Escribe tu nota...';

  @override
  String get notes_saveNote => 'Guardar nota';

  @override
  String get notes_updateNote => 'Actualizar nota';

  @override
  String get notes_empty => 'No hay notas disponibles';

  @override
  String get notes_emptyNote => 'Sin nota';

  @override
  String get notes_deleteNoteTitle => 'Eliminar nota';

  @override
  String get notes_deleteNoteConfirm =>
      '¿Seguro que quieres eliminar esta nota?';

  @override
  String get notes_copy => 'Copiar nota';

  @override
  String get notes_copied => 'Nota copiada al portapapeles';

  @override
  String get globalNote_title => 'Nota global';

  @override
  String get globalNote_empty => 'Sin nota...';

  @override
  String get globalNote_hint => 'Introduce una nota';

  @override
  String get notificationScreen_title => 'Notificaciones';

  @override
  String get notificationScreen_permissionTooltip =>
      'Haz clic aquí para habilitar las notificaciones editables';

  @override
  String get notificationList_title => 'Notificaciones guardadas:';

  @override
  String get notificationList_empty => 'No hay notificaciones guardadas.';

  @override
  String notificationList_hour(Object time) {
    return 'Hora: $time';
  }

  @override
  String get notificationList_daily => 'Diariamente';

  @override
  String notificationList_interval(Object days) {
    return 'Cada $days días';
  }

  @override
  String get notificationList_weekly_none => 'Sin días';

  @override
  String get notificationList_type_training => 'Entrenamiento';

  @override
  String get notificationList_type_weight => 'Peso';

  @override
  String get notificationList_type_measurement => 'Medición';

  @override
  String get notificationList_type_custom => 'Personalizado';

  @override
  String get notificationList_confirm_title => 'Confirmación';

  @override
  String get notificationList_confirm_content =>
      '¿Seguro que quieres eliminar esta notificación?';

  @override
  String get notificationList_deleteAll => 'Eliminar todas';

  @override
  String get notificationList_confirmAll_title =>
      '¿Eliminar todas las notificaciones?';

  @override
  String get notificationList_confirmAll_content =>
      '¿Estás seguro de que deseas eliminar todas las notificaciones guardadas?';

  @override
  String get notificationForm_titleLabel => 'Título de la notificación:';

  @override
  String get notificationForm_titleHint =>
      'Escribe un título personalizado para la notificación...';

  @override
  String get notificationForm_messageLabel => 'Contenido de la notificación:';

  @override
  String get notificationForm_messageHint =>
      'Escribe el contenido personalizado de la notificación...';

  @override
  String get notificationForm_addNotification => 'Añadir notificación';

  @override
  String get notificationForm_added => '¡Notificación añadida!';

  @override
  String get notificationForm_typeLabel => 'Recordatorio:';

  @override
  String get notificationForm_typeTraining => 'Sobre el entrenamiento';

  @override
  String get notificationForm_typeWeight => 'Sobre la medición de peso';

  @override
  String get notificationForm_typeMeasurement => 'Sobre la medición corporal';

  @override
  String get notificationForm_typeCustom => 'Personalizado';

  @override
  String get notificationForm_modeLabel => 'Horario:';

  @override
  String get notificationForm_modeDaily => 'Diariamente';

  @override
  String get notificationForm_modeInterval => 'Cada X días';

  @override
  String get notificationForm_modeWeekly => 'Días seleccionados de la semana';

  @override
  String get notificationForm_intervalPrefix => 'Cada';

  @override
  String get notificationForm_intervalSuffix => 'd.';

  @override
  String get notificationForm_weekdayMon => 'Lun';

  @override
  String get notificationForm_weekdayTue => 'Mar';

  @override
  String get notificationForm_weekdayWed => 'Mié';

  @override
  String get notificationForm_weekdayThu => 'Jue';

  @override
  String get notificationForm_weekdayFri => 'Vie';

  @override
  String get notificationForm_weekdaySat => 'Sáb';

  @override
  String get notificationForm_weekdaySun => 'Dom';

  @override
  String get notificationForm_defaultTitleTraining => '¡Hora de entrenar!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'No olvides tu actividad física.';

  @override
  String get notificationForm_defaultTitleWeight => 'Revisa tu peso';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Recordatorio para pesarte. Registra tu resultado en la aplicación.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Haz tus mediciones';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Es hora de medir tu cuerpo. ¡Sigue tus progresos!';

  @override
  String get notificationForm_testNotification => 'Probar notificación';

  @override
  String get timePicker_label => 'Hora';

  @override
  String get watchAds_title => 'Mira anuncios para apoyarnos';

  @override
  String get watchAds_description =>
      'Mira un breve anuncio en vídeo para apoyarnos sin gastar dinero';

  @override
  String get watchAds_button => 'Ver anuncio';

  @override
  String get watchAds_counter => 'Anuncios vistos:';

  @override
  String get watchAds_error =>
      '¡Gracias por tu apoyo! Desafortunadamente, no se pudo cargar el anuncio';

  @override
  String get watchAds_done =>
      'Congratulations! You’ve reached today’s limit. It will reset tomorrow.';

  @override
  String get watchAds_hide => 'Show ad button in training section';

  @override
  String get shareApp_title => 'Comparte la aplicación';

  @override
  String get shareApp_inviteTitle =>
      '¡Comparte la aplicación con amigos y familia!';

  @override
  String get shareApp_inviteSubtitle =>
      'Ayúdanos a crecer la comunidad compartiendo la aplicación con personas que puedan encontrarla útil.';

  @override
  String get shareApp_shareButton => 'Compartir vía...';

  @override
  String get shareApp_linkCopied => 'Enlace copiado al portapapeles';

  @override
  String get shareApp_shareText => 'Mira esta aplicación:';

  @override
  String get shareApp_ratingTitle => '¿Te gusta GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      '¿Te gustaría calificar GoGymSimple? Tu opinión ayuda a otros a descubrir la app.';

  @override
  String get shareApp_ratingYes => '¡Claro!';

  @override
  String get donate_title => 'Apóyanos';

  @override
  String get donateSections_whyTitle => '¿Por qué apoyarnos?';

  @override
  String get donateSections_whyDesc =>
      'Tus donaciones nos ayudan a mantener y desarrollar este proyecto. Todos los pagos son voluntarios y no desbloquean funciones o contenidos especiales.';

  @override
  String get donateSections_monthlyTitle => 'Suscripción mensual';

  @override
  String get donateSections_monthlyDesc => 'Apóyanos con una donación mensual';

  @override
  String get donateSections_monthlyButton => 'Suscribirse mensualmente';

  @override
  String get donateSections_oneTimeTitle => 'Donación única';

  @override
  String get donateSections_oneTimeDesc =>
      'Realiza un pago único por la cantidad que elijas';

  @override
  String get donateSections_oneTimeButton => 'Pagar ahora';

  @override
  String get donateSections_voluntaryTitle => '100% Voluntario';

  @override
  String get donateSections_storeUnavailableMessage =>
      'Tienda no disponible. Verifica tu conexión a internet';

  @override
  String get donateSections_voluntaryDesc =>
      'Recuerda que todas las donaciones son completamente voluntarias. No recibirás funciones ni contenidos especiales, solo nuestro sincero agradecimiento por apoyar el proyecto.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Ejercicios favoritos';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Selecciona algunos ejercicios para empezar';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Añade tu propio ejercicio';

  @override
  String get welcomeExerciseStep_exampleExercise => 'ej. Sentadillas búlgaras';

  @override
  String get welcomeExerciseStep_addButton => 'Añadir';

  @override
  String get welcomeExerciseStep_nextButton => 'Siguiente';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferencias de entrenamiento';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      '¿Dónde sueles entrenar?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Entreno en casa';

  @override
  String get welcomeGymLocationStep_gym => 'Gimnasio';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Nombre del gimnasio $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Siguiente';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Bienvenido a GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Configura tu perfil para comenzar tu aventura con la aplicación';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Comenzar';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Datos personales';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Tu nombre';

  @override
  String get welcomeIntroSteps_nextButton => 'Siguiente';

  @override
  String get welcomeSettingStep_appSettings => 'Configuración de la aplicación';

  @override
  String get welcomeSettingStep_measurementSystem => 'Sistema de medidas';

  @override
  String get welcomeSettingStep_metric => 'Métrico';

  @override
  String get welcomeSettingStep_imperial => 'Imperial';

  @override
  String get welcomeSettingStep_appTheme => 'Tema de la aplicación';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Entrar a GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Elige idioma';

  @override
  String get welcomeScreen_english => 'Inglés';

  @override
  String get welcomeScreen_polish => 'Polaco';

  @override
  String get welcomeScreen_languageTooltip => 'Cambiar idioma';

  @override
  String get welcomeScreen_exercise_benchPress => 'Press de banca';

  @override
  String get welcomeScreen_exercise_squats => 'Sentadillas';

  @override
  String get welcomeScreen_exercise_deadlift => 'Peso muerto';

  @override
  String get welcomeScreen_exercise_pullUps => 'Dominadas';

  @override
  String get welcomeScreen_exercise_pushUps => 'Flexiones';

  @override
  String get welcomeScreen_exercise_lunges => 'Zancadas';

  @override
  String get welcomeEnd_welcome => 'Bienvenido a GoGymSimple';

  @override
  String get stopwatch_title => 'Cronómetro';

  @override
  String get workoutScreen_title => 'Entrenamiento';

  @override
  String get workoutScreen_gym => 'Selecciona gimnasio';

  @override
  String get workoutScreen_gymAndDate => 'Selecciona gimnasio y fecha';

  @override
  String get workoutScreen_selectGymFirst => 'Primero selecciona un gimnasio';

  @override
  String get workoutScreen_noGymSelected => 'Ningún gimnasio seleccionado';

  @override
  String get workoutScreen_saved => '¡Entrenamiento guardado!';

  @override
  String get workoutScreen_participants => 'Participantes';

  @override
  String get workoutScreen_plans => 'Planes';

  @override
  String get workoutScreen_exercises => 'Ejercicios';

  @override
  String get workoutScreen_addExercise => 'Agregar ejercicio';

  @override
  String get workoutScreen_addNote => 'Agregar nota';

  @override
  String get workoutScreen_saveNote => 'Guardar nota';

  @override
  String get workoutScreen_savedNote => 'Guardado';

  @override
  String get workoutScreen_showMoreInfo => 'Mostrar más información';

  @override
  String get workoutScreen_firstTime => 'Primera vez';

  @override
  String get workoutScreen_cancelWorkout => 'Cancel workout';

  @override
  String get workoutScreen_workoutCancelled => 'Workout cancelled';

  @override
  String get workoutScreen_addGeneralNote => 'Workout note';

  @override
  String get restoreSession_title => 'Entrenamiento interrumpido';

  @override
  String get restoreSession_info =>
      'Tu sesión de entrenamiento anterior fue interrumpida.';

  @override
  String get restoreSession_content => '¿Quieres restaurar tu progreso?';

  @override
  String get restoreSession_confirm => 'Sí, restaurar';

  @override
  String get restoreSession_deny => 'Empezar de nuevo';

  @override
  String get saveWorkoutDialog_save_workout_title =>
      '¿Quieres guardar el entrenamiento?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Guarda este entrenamiento para volver más tarde';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Guardar entrenamiento';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Ahora no';

  @override
  String get saveWorkoutDialog_support_us_title => 'Apóyanos';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      '¡Mira un anuncio corto para apoyar la aplicación!';

  @override
  String get editDeleteBottomSheet_edit => 'Editar';

  @override
  String get editDeleteBottomSheet_delete => 'Eliminar';

  @override
  String get noTrainingSection_noSaved =>
      'No hay entrenamientos guardados para este ejercicio';

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
      'También puedes usar este botón para agregar entrenamientos anteriores';

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

/// The translations for Spanish Castilian, as used in Colombia (`es_CO`).
class AppLocalizationsEsCo extends AppLocalizationsEs {
  AppLocalizationsEsCo() : super('es_CO');

  @override
  String get unknownExercise => 'Ejercicio desconocido';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_elementVisibility =>
      'Mostrar cronómetro en la pantalla principal';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_english => 'Inglés';

  @override
  String get settings_polish => 'Polaco';

  @override
  String get settings_spanish_spain => 'Español – España';

  @override
  String get settings_spanish_colombia => 'Español – Colombia';

  @override
  String get settings_german => 'Alemán';

  @override
  String get settings_dutch => 'Neerlandés';

  @override
  String get settings_portuguese => 'Portugués';

  @override
  String get settings_italian => 'Italiano';

  @override
  String get settings_otherLanguages => 'Otros idiomas (próximamente)';

  @override
  String get settings_availableLanguages => 'Idiomas disponibles';

  @override
  String get settings_units => 'Unidades';

  @override
  String get settings_metric => 'Metro/Kilogramo';

  @override
  String get settings_imperial => 'Pulgada/Libra';

  @override
  String get daysAgo_noData => 'Sin datos';

  @override
  String get daysAgo_lessThanOneHour => 'Hace menos de 1 hora';

  @override
  String get daysAgo_oneHourAgo => 'Hace 1 hora';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count horas',
      many: 'Hace $count horas',
      few: 'Hace $count horas',
      one: 'Hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => 'Hace 1 día';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count días',
      many: 'Hace $count días',
      few: 'Hace $count días',
      one: 'Hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => 'Hace 1 semana';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count semanas',
      many: 'Hace $count semanas',
      few: 'Hace $count semanas',
      one: 'Hace 1 semana',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Hace mucho tiempo';

  @override
  String get confirmationDialog_title => 'Confirmación';

  @override
  String get deleteConfirmationDialog_title => 'Confirmación de eliminación';

  @override
  String get dialog_content => '¿Estás seguro de que quieres continuar?';

  @override
  String get dialog_cancel => 'Cancelar';

  @override
  String get dialog_confirm => 'Confirmar';

  @override
  String get dialog_save => 'Guardar';

  @override
  String get inputFormField_labelText => 'Introduce un valor';

  @override
  String get inputFormField_invalidValue =>
      'Valor inválido. Introduce un número.';

  @override
  String get addPattern_title => 'Añadir nueva paleta de colores';

  @override
  String get addPattern_iconsText =>
      'Así se verán los iconos y el texto en este color';

  @override
  String get addPattern_textExample =>
      'Así se verá este texto con un tono diferente';

  @override
  String get addPattern_backgroundColor => 'Color de fondo';

  @override
  String get addPattern_sectionColor => 'Color de sección';

  @override
  String get addPattern_textIconsColor => 'Color del texto y los iconos';

  @override
  String get addPattern_save => 'Guardar';

  @override
  String get customizeApp_availableColorPalettes => 'Temas disponibles';

  @override
  String get customizeApp_currentTheme => 'Tema actual';

  @override
  String get customizeApp_setTheme => 'Establecer tema';

  @override
  String get customizeApp_deleteTheme => 'Eliminar tema';

  @override
  String get customizeApp_confirmDelete =>
      '¿Seguro que quieres eliminar este tema?';

  @override
  String get customizeApp_applyTheme => 'Aplicar tema';

  @override
  String get savePalette_saveTheme => 'Guardar tema';

  @override
  String savePalette_themeSaved(Object name) {
    return 'El tema \"$name\" ha sido guardado. Vuelve a la ventana anterior para aplicarlo';
  }

  @override
  String get savePalette_themeName => 'Nombre del tema';

  @override
  String get addPattern_moreColors => 'Más colores';

  @override
  String get fullColorPicker_chooseColor => 'Elegir color';

  @override
  String get fullColorPicker_save => 'Guardar';

  @override
  String get applyNewTheme => 'Nuevo tema aplicado';

  @override
  String get calculator1RM_title => 'Calculadora 1RM';

  @override
  String get calculator1RM_infoText =>
      'Rellena todos los campos abajo para ver el resultado del 1RM';

  @override
  String get calculator1RM_repsLabel => 'NÚMERO DE REPETICIONES';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Tu 1RM es: $value kg, lo que corresponde a:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Tu 1RM es: $value lbs, lo que corresponde a:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Porcentaje';

  @override
  String get calculator1RM_table_header_reps => 'Repeticiones';

  @override
  String get calculator1RM_table_header_weight => 'Peso';

  @override
  String get infoDialog1RM_title => 'Acerca de la Calculadora 1RM';

  @override
  String get infoDialog1RM_description =>
      'La calculadora 1RM estima el peso máximo que puedes levantar para una repetición basándose en el peso y el número de repeticiones realizadas en una serie. Se usa la fórmula popular de Brzycki.';

  @override
  String get infoDialog1RM_closeButton => 'Cerrar';

  @override
  String get bmrResults_title => 'Tu BMR según la actividad:';

  @override
  String get bmrResults_noData => 'Sin datos';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'aprox. $max – ${min}g de proteína al día';
  }

  @override
  String get basicActivity => 'Requerimiento básico';

  @override
  String get lowActivity => 'Actividad baja';

  @override
  String get moderateActivity => 'Actividad moderada';

  @override
  String get highActivity => 'Alta actividad';

  @override
  String get veryHighActivity => 'Actividad muy alta';

  @override
  String get calculatorBmr_title => 'Calculadora BMR';

  @override
  String get calculatorBmr_height_label_metric => 'ALTURA (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ALTURA (pies)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'ALTURA (pulgadas)';

  @override
  String get calculatorBmr_age_label => 'EDAD';

  @override
  String get calculatorBmr_male => 'Hombre';

  @override
  String get calculatorBmr_female => 'Mujer';

  @override
  String get calculatorBmr_info =>
      'Rellena todos los campos abajo para ver el resultado del BMR';

  @override
  String get bmrInfo_title => 'Información sobre BMR y proteína:';

  @override
  String get bmrInfo_text1 =>
      'El BMR (Tasa Metabólica Basal) es un indicador que muestra cuántas calorías necesita tu cuerpo en reposo para mantener las funciones vitales básicas.';

  @override
  String get bmrInfo_text2 =>
      'El nivel de actividad influye en el valor del BMR. Un mayor nivel de actividad significa un mayor requerimiento calórico.';

  @override
  String get bmrInfo_recommended =>
      'La ingesta recomendada de PROTEÍNA depende del nivel de actividad física, y aquí tienes los rangos según el nivel de actividad:';

  @override
  String get bmrInfo_close => 'Cerrar';

  @override
  String get perKilogram => 'por kilogramo de peso corporal';

  @override
  String get perPound => 'por libra de peso corporal';

  @override
  String get plateCalculator_plateCalculator =>
      'Calculadora de discos por lado';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Haz clic para ver los discos propuestos';

  @override
  String get plateCalculator_fillOutData =>
      'Rellena los campos de abajo para ver el peso requerido por lado. EL PESO TOTAL debe ser mayor que EL PESO DE LA BARRA.';

  @override
  String get plateCalculator_selectPlates =>
      'Selecciona los discos disponibles:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'PESO DE LA BARRA (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'PESO DE LA BARRA (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'PESO TOTAL (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'PESO TOTAL (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Peso por lado: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Peso por lado: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Discos propuestos';

  @override
  String get plateDialog_forSide => 'POR LADO';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Opción $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Cerrar';

  @override
  String get plateDialog_invalidWeight =>
      'El peso debe ser mayor que el de la barra';

  @override
  String get plateDialog_invalidTargetWeight =>
      'El peso objetivo es demasiado bajo';

  @override
  String get plateDialog_noCombinationFound =>
      'No se encontró una combinación válida de discos para el peso seleccionado';

  @override
  String get measurementTile_noData =>
      'No hay datos. Pulsa el botón \'Medir\' para añadir un valor.';

  @override
  String get measurementTile_addData => 'Medir';

  @override
  String get measurementTile_baseline => 'Base';

  @override
  String get measurementTile_deleteCategory => 'Eliminar categoría';

  @override
  String get measurementTile_today => 'Hoy';

  @override
  String get measurementTile_yesterday => 'Ayer';

  @override
  String get measurementTracker_body_measurements => 'Mediciones corporales';

  @override
  String get measurementTracker_no_data_to_show => 'No hay datos para mostrar';

  @override
  String get measurementTracker_add_new_category => 'Añadir nueva categoría';

  @override
  String get measurementTracker_name_new_category => 'Nombre de la categoría';

  @override
  String get measurementTracker_name_new_measurement => 'Valor de la medición';

  @override
  String get measurementTracker_add_new_measurement => 'Añadir nueva medición';

  @override
  String get measurementTracker_update_category => 'Actualizar categoría';

  @override
  String get measurementTracker_delete_category_confirmation =>
      '¿Seguro que quieres eliminar esta categoría?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      '¿Seguro que quieres eliminar esta medición?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'La medición para \'$bodyPart\' ha sido eliminada.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'La categoría \'$category\' ha sido eliminada.';
  }

  @override
  String get measurementTracker_category_exists => '¡Esa categoría ya existe!';

  @override
  String get measurementTracker_invalid_value => '¡Valor no válido!';

  @override
  String get measurementTracker_invalid_category =>
      '¡Categoría seleccionada no válida!';

  @override
  String get measurementTracker_add_category_hint =>
      'Puedes añadir una nueva categoría con el botón de abajo.';

  @override
  String get weightTracker_title => 'Seguimiento de peso';

  @override
  String get weightTracker_enterWeightKg => 'Introduce peso (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Introduce peso (lbs)';

  @override
  String get weightTracker_saveWeight => 'Guardar peso';

  @override
  String get weightTracker_updateWeight => 'Actualizar peso';

  @override
  String get weightTracker_yourWeight => 'Tu peso';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' hace $daysAgo días';
  }

  @override
  String get drawer_tools_section => 'Herramientas';

  @override
  String get drawer_calculators_section => 'Calculadoras';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Discos en barra';

  @override
  String get drawer_time_section => 'Tiempo';

  @override
  String get drawer_stopwatch => 'Cronómetro';

  @override
  String get drawer_trackers_section => 'Seguimiento';

  @override
  String get drawer_weightTracker => 'Seguimiento de peso';

  @override
  String get drawer_measurementTracker => 'Seguimiento de mediciones';

  @override
  String get drawer_settings_section => 'Ajustes';

  @override
  String get drawer_customizeApp => 'Personalizar tema';

  @override
  String get drawer_appLanguage => 'Idioma';

  @override
  String get drawer_notificationSettings => 'Notificaciones';

  @override
  String get drawer_appreciation_section => 'Apoyo';

  @override
  String get drawer_supportButton => 'Hacer donación';

  @override
  String get drawer_watchAd => 'Ver anuncio';

  @override
  String get drawer_shareApp => 'Compartir app';

  @override
  String get drawer_noteCount => 'Número de notas guardadas: ';

  @override
  String get drawer_guest => 'Invitado';

  @override
  String get drawer_privacyPolicy => 'Política de privacidad';

  @override
  String get drawer_termsOfUse => 'Términos de uso';

  @override
  String get searchDrawer_hint => 'Buscar...';

  @override
  String get searchDrawer_clear => 'Borrar búsqueda';

  @override
  String get addExerciseDialog_title => 'Añadir nuevo ejercicio';

  @override
  String get addExerciseDialog_label => 'Introduce el nombre del ejercicio';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Ejercicio \"$exerciseName\" añadido';
  }

  @override
  String get addExerciseDialog_anotherTitle => '¿Añadir otro ejercicio?';

  @override
  String get addExerciseDialog_anotherContent =>
      '¿Quieres añadir otro ejercicio?';

  @override
  String get addWorkoutPlan_title => 'Añadir plan de entrenamiento';

  @override
  String get addWorkoutPlan_planName => 'Nombre del plan de entrenamiento';

  @override
  String get addWorkoutPlan_selectedExercises => 'Ejercicios seleccionados:';

  @override
  String get addWorkoutPlan_noExercises =>
      'No se han seleccionado ejercicios aún.';

  @override
  String get addWorkoutPlan_availableExercises => 'Ejercicios disponibles:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Añadir nuevo ejercicio';

  @override
  String get addWorkoutPlan_save => 'Guardar plan de entrenamiento';

  @override
  String get addWorkoutPlan_missingName =>
      'Introduce un nombre para el plan de entrenamiento.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Selecciona al menos un ejercicio.';

  @override
  String get tabBottomDrawer_showOnly => 'Mostrar solo:';

  @override
  String get tabBottomDrawer_addNewGym => 'Añadir gimnasio';

  @override
  String get tabBottomDrawer_addNewUser => 'Añadir usuario';

  @override
  String get tabBottomDrawer_addNewExercise => 'Añadir ejercicio';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan =>
      'Añadir plan de entrenamiento';

  @override
  String get tabBottomDrawer_enterGymName => 'Introduce el nombre del gimnasio';

  @override
  String get tabBottomDrawer_enterUserName => 'Introduce el nombre del usuario';

  @override
  String get tabBottomDrawer_editTitle => 'Editar nombre';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Introduce el nombre del plan de entrenamiento';

  @override
  String get tabBottomDrawer_editLabel => 'Introduce un nuevo nombre';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Actualiza la pantalla para ver los cambios';

  @override
  String get tabSector_gym => 'Gimnasio';

  @override
  String get tabSector_user => 'Usuario';

  @override
  String get tabSector_exercise => 'Ejercicio';

  @override
  String get tabSector_workoutPlan => 'Plan de entrenamiento';

  @override
  String get sortSector_newest => 'Más recientes';

  @override
  String get sortSector_oldest => 'Más antiguos';

  @override
  String get sortSector_exerciseView => 'Ejercicios';

  @override
  String get sortSector_historyView => 'Historial';

  @override
  String get historyView_noWorkouts => 'No hay entrenamientos disponibles';

  @override
  String get historyView_exerciseNotFound => 'Ejercicio no encontrado';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'En esta sección se mostrarán las notas de tus entrenamientos';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Ningún resultado coincide con tus filtros.';

  @override
  String get notes_justNow => 'Justo ahora';

  @override
  String notes_minutesAgo(Object count) {
    return 'Hace $count minutos';
  }

  @override
  String notes_hoursAgo(Object count) {
    return 'Hace $count horas';
  }

  @override
  String notes_daysAgo(Object count) {
    return 'Hace $count días';
  }

  @override
  String get notes_invalidDate => 'Fecha no válida';

  @override
  String get notes_showMore => 'Mostrar más';

  @override
  String get notes_showLess => 'Mostrar menos';

  @override
  String get exerciseView_filteredOutExercises =>
      'Ejercicios que no coinciden con los filtros:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Entra en la sección \'Ejercicio\' para añadir tu primer ejercicio.';

  @override
  String get iconSelection_chooseIcon => 'Elige un icono para el ejercicio';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Añadir usuario y gimnasio al ejercicio';

  @override
  String get exerciseExpansion_deleteExercise => 'Eliminar ejercicio';

  @override
  String get exerciseExpansion_confirmDelete =>
      '¿Seguro que quieres eliminar este ejercicio? Esto también eliminará todos los datos relacionados con él.';

  @override
  String get exerciseExpansion_addIcon => 'Añadir icono al ejercicio';

  @override
  String get exerciseExpansion_unknownExercise => 'Ejercicio desconocido';

  @override
  String get exerciseExpansion_unknownUser => 'Usuario desconocido';

  @override
  String get exerciseExpansion_unknownGym => 'Gimnasio desconocido';

  @override
  String get exerciseExpansion_noWorkouts =>
      'No hay entrenamientos disponibles';

  @override
  String get exerciseExpansion_changeNameTitle =>
      'Cambiar nombre del ejercicio';

  @override
  String get exerciseExpansion_enterNewName => 'Nuevo nombre del ejercicio';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Asignar $exercise a usuario y gimnasio';
  }

  @override
  String get addUserAndGym_selectUser => 'Selecciona usuario';

  @override
  String get addUserAndGym_selectGym => 'Selecciona gimnasio';

  @override
  String get addUserAndGym_confirmSelection => 'Confirmar selección';

  @override
  String get addUserAndGym_workoutExists =>
      'Este entrenamiento ya existe para el usuario y gimnasio seleccionados.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Agrega una nota general para el ejercicio $exerciseName, por ejemplo: configuración de la máquina, tipo de agarre, consejos técnicos, etc.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Última nota: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Establecer valor rápido';

  @override
  String get resultsExpansion_quickValueSet => 'Introduce texto o número';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      '¿Seguro que quieres eliminar esta sección junto con todos sus resultados?';

  @override
  String get notes_title => 'Notas de Entrenamiento';

  @override
  String get notes_addNote => '+ Añadir nota';

  @override
  String get notes_cancel => 'Cancelar';

  @override
  String get notes_hint => 'Escribe tu nota...';

  @override
  String get notes_saveNote => 'Guardar nota';

  @override
  String get notes_updateNote => 'Actualizar nota';

  @override
  String get notes_empty => 'No hay notas disponibles';

  @override
  String get notes_emptyNote => 'Sin nota';

  @override
  String get notes_deleteNoteTitle => 'Eliminar nota';

  @override
  String get notes_deleteNoteConfirm =>
      '¿Seguro que quieres eliminar esta nota?';

  @override
  String get notes_copy => 'Copiar nota';

  @override
  String get notes_copied => 'Nota copiada al portapapeles';

  @override
  String get globalNote_title => 'Nota global';

  @override
  String get globalNote_empty => 'Sin nota...';

  @override
  String get globalNote_hint => 'Introduce una nota';

  @override
  String get notificationScreen_title => 'Notificaciones';

  @override
  String get notificationScreen_permissionTooltip =>
      'Solicitar permisos para notificaciones';

  @override
  String get notificationList_title => 'Notificaciones guardadas:';

  @override
  String get notificationList_empty => 'No hay notificaciones guardadas.';

  @override
  String notificationList_hour(Object time) {
    return 'Hora: $time';
  }

  @override
  String get notificationList_daily => 'Diariamente';

  @override
  String notificationList_interval(Object days) {
    return 'Cada $days días';
  }

  @override
  String get notificationList_weekly_none => 'Sin días';

  @override
  String get notificationList_type_training => 'Entrenamiento';

  @override
  String get notificationList_type_weight => 'Peso';

  @override
  String get notificationList_type_measurement => 'Medición';

  @override
  String get notificationList_type_custom => 'Personalizado';

  @override
  String get notificationList_confirm_title => 'Confirmación';

  @override
  String get notificationList_confirm_content =>
      '¿Seguro que quieres eliminar esta notificación?';

  @override
  String get notificationForm_titleLabel => 'Título de la notificación:';

  @override
  String get notificationForm_titleHint =>
      'Escribe un título personalizado para la notificación...';

  @override
  String get notificationForm_messageLabel => 'Contenido de la notificación:';

  @override
  String get notificationForm_messageHint =>
      'Escribe el contenido personalizado de la notificación...';

  @override
  String get notificationForm_addNotification => 'Añadir notificación';

  @override
  String get notificationForm_added => '¡Notificación añadida!';

  @override
  String get notificationForm_typeLabel => 'Tipo de recordatorio:';

  @override
  String get notificationForm_typeTraining => 'Sobre el entrenamiento';

  @override
  String get notificationForm_typeWeight => 'Sobre la medición de peso';

  @override
  String get notificationForm_typeMeasurement => 'Sobre la medición corporal';

  @override
  String get notificationForm_typeCustom => 'Personalizado';

  @override
  String get notificationForm_modeLabel => 'Modo de notificación:';

  @override
  String get notificationForm_modeDaily => 'Diariamente';

  @override
  String get notificationForm_modeInterval => 'Cada X días';

  @override
  String get notificationForm_modeWeekly => 'Días seleccionados de la semana';

  @override
  String get notificationForm_intervalPrefix => 'Cada';

  @override
  String get notificationForm_intervalSuffix => 'd.';

  @override
  String get notificationForm_weekdayMon => 'Lun';

  @override
  String get notificationForm_weekdayTue => 'Mar';

  @override
  String get notificationForm_weekdayWed => 'Mié';

  @override
  String get notificationForm_weekdayThu => 'Jue';

  @override
  String get notificationForm_weekdayFri => 'Vie';

  @override
  String get notificationForm_weekdaySat => 'Sáb';

  @override
  String get notificationForm_weekdaySun => 'Dom';

  @override
  String get notificationForm_defaultTitleTraining => '¡Hora de entrenar!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'No olvides tu actividad física.';

  @override
  String get notificationForm_defaultTitleWeight => 'Revisa tu peso';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Recordatorio para pesarte. Registra tu resultado en la aplicación.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Haz tus mediciones';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Es hora de medir tu cuerpo. ¡Sigue tus progresos!';

  @override
  String get timePicker_label => 'Hora';

  @override
  String get watchAds_title => 'Mira anuncios para apoyarnos';

  @override
  String get watchAds_description =>
      'Mira un breve anuncio en vídeo para apoyarnos sin gastar dinero';

  @override
  String get watchAds_button => 'Ver anuncio';

  @override
  String get watchAds_counter => 'Anuncios vistos:';

  @override
  String get shareApp_title => 'Comparte la aplicación';

  @override
  String get shareApp_inviteTitle =>
      '¡Comparte la aplicación con amigos y familia!';

  @override
  String get shareApp_inviteSubtitle =>
      'Ayúdanos a crecer la comunidad compartiendo la aplicación con personas que puedan encontrarla útil.';

  @override
  String get shareApp_shareButton => 'Compartir vía...';

  @override
  String get shareApp_linkCopied => 'Enlace copiado al portapapeles';

  @override
  String get shareApp_shareText => 'Mira esta aplicación:';

  @override
  String get shareApp_ratingTitle => '¿Te gusta GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      '¿Te gustaría calificar GoGymSimple? Tu opinión ayuda a otros a descubrir la app.';

  @override
  String get shareApp_ratingYes => '¡Claro!';

  @override
  String get donate_title => 'Apóyanos';

  @override
  String get donateSections_whyTitle => '¿Por qué apoyarnos?';

  @override
  String get donateSections_whyDesc =>
      'Tus donaciones nos ayudan a mantener y desarrollar este proyecto. Todos los pagos son voluntarios y no desbloquean funciones o contenidos especiales.';

  @override
  String get donateSections_monthlyTitle => 'Suscripción mensual';

  @override
  String get donateSections_monthlyDesc => 'Apóyanos con una donación mensual';

  @override
  String get donateSections_monthlyButton => 'Suscribirse mensualmente';

  @override
  String get donateSections_oneTimeTitle => 'Donación única';

  @override
  String get donateSections_oneTimeDesc =>
      'Realiza un pago único por la cantidad que elijas';

  @override
  String get donateSections_oneTimeButton => 'Pagar ahora';

  @override
  String get donateSections_voluntaryTitle => '100% Voluntario';

  @override
  String get donateSections_voluntaryDesc =>
      'Recuerda que todas las donaciones son completamente voluntarias. No recibirás funciones ni contenidos especiales, solo nuestro sincero agradecimiento por apoyar el proyecto.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Ejercicios favoritos';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Selecciona algunos ejercicios para empezar';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Añade tu propio ejercicio';

  @override
  String get welcomeExerciseStep_exampleExercise => 'ej. Sentadillas búlgaras';

  @override
  String get welcomeExerciseStep_addButton => 'Añadir';

  @override
  String get welcomeExerciseStep_nextButton => 'Siguiente';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferencias de entrenamiento';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      '¿Dónde sueles entrenar?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Entreno en casa';

  @override
  String get welcomeGymLocationStep_gym => 'Gimnasio';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Nombre del gimnasio $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Siguiente';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Bienvenido a GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Configura tu perfil para comenzar tu aventura con la aplicación';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Comenzar';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Datos personales';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Tu nombre';

  @override
  String get welcomeIntroSteps_nextButton => 'Siguiente';

  @override
  String get welcomeSettingStep_appSettings => 'Configuración de la aplicación';

  @override
  String get welcomeSettingStep_measurementSystem => 'Sistema de medidas';

  @override
  String get welcomeSettingStep_metric => 'Métrico';

  @override
  String get welcomeSettingStep_imperial => 'Imperial';

  @override
  String get welcomeSettingStep_appTheme => 'Tema de la aplicación';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Entrar a GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Elige idioma';

  @override
  String get welcomeScreen_english => 'Inglés';

  @override
  String get welcomeScreen_polish => 'Polaco';

  @override
  String get welcomeScreen_languageTooltip => 'Cambiar idioma';

  @override
  String get welcomeScreen_exercise_benchPress => 'Press de banca';

  @override
  String get welcomeScreen_exercise_squats => 'Sentadillas';

  @override
  String get welcomeScreen_exercise_deadlift => 'Peso muerto';

  @override
  String get welcomeScreen_exercise_pullUps => 'Dominadas';

  @override
  String get welcomeScreen_exercise_pushUps => 'Flexiones';

  @override
  String get welcomeScreen_exercise_lunges => 'Zancadas';

  @override
  String get welcomeEnd_welcome => 'Bienvenido a GoGymSimple';

  @override
  String get stopwatch_title => 'Cronómetro';

  @override
  String get workoutScreen_title => 'Entrenamiento';

  @override
  String get workoutScreen_gym => 'Selecciona gimnasio';

  @override
  String get workoutScreen_gymAndDate => 'Selecciona gimnasio y fecha';

  @override
  String get workoutScreen_selectGymFirst => 'Primero selecciona un gimnasio';

  @override
  String get workoutScreen_noGymSelected => 'Ningún gimnasio seleccionado';

  @override
  String get workoutScreen_saved => '¡Entrenamiento guardado!';

  @override
  String get workoutScreen_participants => 'Participantes';

  @override
  String get workoutScreen_plans => 'Planes';

  @override
  String get workoutScreen_exercises => 'Ejercicios';

  @override
  String get workoutScreen_addExercise => 'Agregar ejercicio';

  @override
  String get workoutScreen_addNote => 'Agregar nota';

  @override
  String get workoutScreen_saveNote => 'Guardar nota';

  @override
  String get workoutScreen_savedNote => 'Guardado';

  @override
  String get workoutScreen_showMoreInfo => 'Mostrar más información';

  @override
  String get saveWorkoutDialog_save_workout_title =>
      '¿Quieres guardar el entrenamiento?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Guarda este entrenamiento para volver más tarde';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Guardar entrenamiento';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Ahora no';

  @override
  String get saveWorkoutDialog_support_us_title => 'Apóyanos';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      '¡Mira un anuncio corto para apoyar la aplicación!';
}

/// The translations for Spanish Castilian, as used in Spain (`es_ES`).
class AppLocalizationsEsEs extends AppLocalizationsEs {
  AppLocalizationsEsEs() : super('es_ES');

  @override
  String get unknownExercise => 'Ejercicio desconocido';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_elementVisibility =>
      'Mostrar cronómetro en la pantalla principal';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_english => 'Inglés';

  @override
  String get settings_polish => 'Polaco';

  @override
  String get settings_spanish_spain => 'Español – España';

  @override
  String get settings_spanish_colombia => 'Español – Colombia';

  @override
  String get settings_german => 'Alemán';

  @override
  String get settings_dutch => 'Neerlandés';

  @override
  String get settings_portuguese => 'Portugués';

  @override
  String get settings_italian => 'Italiano';

  @override
  String get settings_otherLanguages => 'Otros idiomas (próximamente)';

  @override
  String get settings_availableLanguages => 'Idiomas disponibles';

  @override
  String get settings_units => 'Unidades';

  @override
  String get settings_metric => 'Metro/Kilogramo';

  @override
  String get settings_imperial => 'Pulgada/Libra';

  @override
  String get daysAgo_noData => 'Sin datos';

  @override
  String get daysAgo_lessThanOneHour => 'Hace menos de 1 hora';

  @override
  String get daysAgo_oneHourAgo => 'Hace 1 hora';

  @override
  String daysAgo_hoursAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count horas',
      many: 'Hace $count horas',
      few: 'Hace $count horas',
      one: 'Hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneDayAgo => 'Hace 1 día';

  @override
  String daysAgo_daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count días',
      many: 'Hace $count días',
      few: 'Hace $count días',
      one: 'Hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_oneWeekAgo => 'Hace 1 semana';

  @override
  String daysAgo_weeksAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count semanas',
      many: 'Hace $count semanas',
      few: 'Hace $count semanas',
      one: 'Hace 1 semana',
    );
    return '$_temp0';
  }

  @override
  String get daysAgo_longTimeAgo => 'Hace mucho tiempo';

  @override
  String get confirmationDialog_title => 'Confirmación';

  @override
  String get deleteConfirmationDialog_title => 'Confirmación de eliminación';

  @override
  String get dialog_content => '¿Estás seguro de que quieres continuar?';

  @override
  String get dialog_cancel => 'Cancelar';

  @override
  String get dialog_confirm => 'Confirmar';

  @override
  String get dialog_save => 'Guardar';

  @override
  String get inputFormField_labelText => 'Introduce un valor';

  @override
  String get inputFormField_invalidValue =>
      'Valor inválido. Introduce un número.';

  @override
  String get addPattern_title => 'Añadir nueva paleta de colores';

  @override
  String get addPattern_iconsText =>
      'Así se verán los iconos y el texto en este color';

  @override
  String get addPattern_textExample =>
      'Así se verá este texto con un tono diferente';

  @override
  String get addPattern_backgroundColor => 'Color de fondo';

  @override
  String get addPattern_sectionColor => 'Color de sección';

  @override
  String get addPattern_textIconsColor => 'Color del texto y los iconos';

  @override
  String get addPattern_save => 'Guardar';

  @override
  String get customizeApp_availableColorPalettes => 'Temas disponibles';

  @override
  String get customizeApp_currentTheme => 'Tema actual';

  @override
  String get customizeApp_setTheme => 'Establecer tema';

  @override
  String get customizeApp_deleteTheme => 'Eliminar tema';

  @override
  String get customizeApp_confirmDelete =>
      '¿Seguro que quieres eliminar este tema?';

  @override
  String get customizeApp_applyTheme => 'Aplicar tema';

  @override
  String get savePalette_saveTheme => 'Guardar tema';

  @override
  String savePalette_themeSaved(Object name) {
    return 'El tema \"$name\" ha sido guardado. Vuelve a la ventana anterior para aplicarlo';
  }

  @override
  String get savePalette_themeName => 'Nombre del tema';

  @override
  String get addPattern_moreColors => 'Más colores';

  @override
  String get fullColorPicker_chooseColor => 'Elegir color';

  @override
  String get fullColorPicker_save => 'Guardar';

  @override
  String get applyNewTheme => 'Nuevo tema aplicado';

  @override
  String get calculator1RM_title => 'Calculadora 1RM';

  @override
  String get calculator1RM_infoText =>
      'Rellena todos los campos abajo para ver el resultado del 1RM';

  @override
  String get calculator1RM_repsLabel => 'NÚMERO DE REPETICIONES';

  @override
  String calculator1RM_ResultKg(Object value) {
    return 'Tu 1RM es: $value kg, lo que corresponde a:';
  }

  @override
  String calculator1RM_ResultLbs(Object value) {
    return 'Tu 1RM es: $value lbs, lo que corresponde a:';
  }

  @override
  String get calculator1RM_table_header_percentage => 'Porcentaje';

  @override
  String get calculator1RM_table_header_reps => 'Repeticiones';

  @override
  String get calculator1RM_table_header_weight => 'Peso';

  @override
  String get infoDialog1RM_title => 'Acerca de la Calculadora 1RM';

  @override
  String get infoDialog1RM_description =>
      'La calculadora 1RM estima el peso máximo que puedes levantar para una repetición basándose en el peso y el número de repeticiones realizadas en una serie. Se usa la fórmula popular de Brzycki.';

  @override
  String get infoDialog1RM_closeButton => 'Cerrar';

  @override
  String get bmrResults_title => 'Tu BMR según la actividad:';

  @override
  String get bmrResults_noData => 'Sin datos';

  @override
  String bmrResults_proteinOnlyGrams(Object max, Object min) {
    return 'aprox. $max – ${min}g de proteína al día';
  }

  @override
  String get basicActivity => 'Requerimiento básico';

  @override
  String get lowActivity => 'Actividad baja';

  @override
  String get moderateActivity => 'Actividad moderada';

  @override
  String get highActivity => 'Alta actividad';

  @override
  String get veryHighActivity => 'Actividad muy alta';

  @override
  String get calculatorBmr_title => 'Calculadora BMR';

  @override
  String get calculatorBmr_height_label_metric => 'ALTURA (cm)';

  @override
  String get calculatorBmr_height_label_imperial_feet => 'ALTURA (pies)';

  @override
  String get calculatorBmr_height_label_imperial_inches => 'ALTURA (pulgadas)';

  @override
  String get calculatorBmr_age_label => 'EDAD';

  @override
  String get calculatorBmr_male => 'Hombre';

  @override
  String get calculatorBmr_female => 'Mujer';

  @override
  String get calculatorBmr_info =>
      'Rellena todos los campos abajo para ver el resultado del BMR';

  @override
  String get bmrInfo_title => 'Información sobre BMR y proteína:';

  @override
  String get bmrInfo_text1 =>
      'El BMR (Tasa Metabólica Basal) es un indicador que muestra cuántas calorías necesita tu cuerpo en reposo para mantener las funciones vitales básicas.';

  @override
  String get bmrInfo_text2 =>
      'El nivel de actividad influye en el valor del BMR. Un mayor nivel de actividad significa un mayor requerimiento calórico.';

  @override
  String get bmrInfo_recommended =>
      'La ingesta recomendada de PROTEÍNA depende del nivel de actividad física, y aquí tienes los rangos según el nivel de actividad:';

  @override
  String get bmrInfo_close => 'Cerrar';

  @override
  String get perKilogram => 'por kilogramo de peso corporal';

  @override
  String get perPound => 'por libra de peso corporal';

  @override
  String get plateCalculator_plateCalculator =>
      'Calculadora de discos por lado';

  @override
  String get plateCalculator_clickToSeePlates =>
      'Haz clic para ver los discos propuestos';

  @override
  String get plateCalculator_fillOutData =>
      'Rellena los campos de abajo para ver el peso requerido por lado. EL PESO TOTAL debe ser mayor que EL PESO DE LA BARRA.';

  @override
  String get plateCalculator_selectPlates =>
      'Selecciona los discos disponibles:';

  @override
  String get plateCalculator_barbellWeightLabelKg => 'PESO DE LA BARRA (kg)';

  @override
  String get plateCalculator_barbellWeightLabelLbs => 'PESO DE LA BARRA (lbs)';

  @override
  String get plateCalculator_totalWeightLabelKg => 'PESO TOTAL (kg)';

  @override
  String get plateCalculator_totalWeightLabelLbs => 'PESO TOTAL (lbs)';

  @override
  String plateCalculator_weightOnSideKg(Object weight) {
    return 'Peso por lado: $weight kg';
  }

  @override
  String plateCalculator_weightOnSideLbs(Object weight) {
    return 'Peso por lado: $weight lbs';
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
  String get plateDialog_proposedPlates => 'Discos propuestos';

  @override
  String get plateDialog_forSide => 'POR LADO';

  @override
  String plateDialog_option(Object optionNumber) {
    return 'Opción $optionNumber:';
  }

  @override
  String get plateDialog_close => 'Cerrar';

  @override
  String get plateDialog_invalidWeight =>
      'El peso debe ser mayor que el de la barra';

  @override
  String get plateDialog_invalidTargetWeight =>
      'El peso objetivo es demasiado bajo';

  @override
  String get plateDialog_noCombinationFound =>
      'No se encontró una combinación válida de discos para el peso seleccionado';

  @override
  String get measurementTile_noData =>
      'No hay datos. Pulsa el botón \'Medir\' para añadir un valor.';

  @override
  String get measurementTile_addData => 'Medir';

  @override
  String get measurementTile_baseline => 'Base';

  @override
  String get measurementTile_deleteCategory => 'Eliminar categoría';

  @override
  String get measurementTile_today => 'Hoy';

  @override
  String get measurementTile_yesterday => 'Ayer';

  @override
  String get measurementTracker_body_measurements => 'Mediciones corporales';

  @override
  String get measurementTracker_no_data_to_show => 'No hay datos para mostrar';

  @override
  String get measurementTracker_add_new_category => 'Añadir nueva categoría';

  @override
  String get measurementTracker_name_new_category => 'Nombre de la categoría';

  @override
  String get measurementTracker_name_new_measurement => 'Valor de la medición';

  @override
  String get measurementTracker_add_new_measurement => 'Añadir nueva medición';

  @override
  String get measurementTracker_update_category => 'Actualizar categoría';

  @override
  String get measurementTracker_delete_category_confirmation =>
      '¿Seguro que quieres eliminar esta categoría?';

  @override
  String get measurementTracker_delete_measurement_confirmation =>
      '¿Seguro que quieres eliminar esta medición?';

  @override
  String measurementTracker_measurement_deleted(Object bodyPart) {
    return 'La medición para \'$bodyPart\' ha sido eliminada.';
  }

  @override
  String measurementTracker_category_deleted(Object category) {
    return 'La categoría \'$category\' ha sido eliminada.';
  }

  @override
  String get measurementTracker_category_exists => '¡Esa categoría ya existe!';

  @override
  String get measurementTracker_invalid_value => '¡Valor no válido!';

  @override
  String get measurementTracker_invalid_category =>
      '¡Categoría seleccionada no válida!';

  @override
  String get measurementTracker_add_category_hint =>
      'Puedes añadir una nueva categoría con el botón de abajo.';

  @override
  String get weightTracker_title => 'Seguimiento de peso';

  @override
  String get weightTracker_enterWeightKg => 'Introduce peso (kg)';

  @override
  String get weightTracker_enterWeightLbs => 'Introduce peso (lbs)';

  @override
  String get weightTracker_saveWeight => 'Guardar peso';

  @override
  String get weightTracker_updateWeight => 'Actualizar peso';

  @override
  String get weightTracker_yourWeight => 'Tu peso';

  @override
  String weightTracker_daysAgo(Object daysAgo) {
    return ' hace $daysAgo días';
  }

  @override
  String get drawer_tools_section => 'Herramientas';

  @override
  String get drawer_calculators_section => 'Calculadoras';

  @override
  String get drawer_oneRepMax => '1RM';

  @override
  String get drawer_bmr => 'BMR';

  @override
  String get drawer_platesOnBarbell => 'Discos en barra';

  @override
  String get drawer_time_section => 'Tiempo';

  @override
  String get drawer_stopwatch => 'Cronómetro';

  @override
  String get drawer_trackers_section => 'Seguimiento';

  @override
  String get drawer_weightTracker => 'Seguimiento de peso';

  @override
  String get drawer_measurementTracker => 'Seguimiento de mediciones';

  @override
  String get drawer_settings_section => 'Ajustes';

  @override
  String get drawer_customizeApp => 'Personalizar tema';

  @override
  String get drawer_appLanguage => 'Idioma';

  @override
  String get drawer_notificationSettings => 'Notificaciones';

  @override
  String get drawer_appreciation_section => 'Apoyo';

  @override
  String get drawer_supportButton => 'Hacer donación';

  @override
  String get drawer_watchAd => 'Ver anuncio';

  @override
  String get drawer_shareApp => 'Compartir app';

  @override
  String get drawer_noteCount => 'Número de notas guardadas: ';

  @override
  String get drawer_guest => 'Invitado';

  @override
  String get drawer_privacyPolicy => 'Política de privacidad';

  @override
  String get drawer_termsOfUse => 'Términos de uso';

  @override
  String get searchDrawer_hint => 'Buscar...';

  @override
  String get searchDrawer_clear => 'Borrar búsqueda';

  @override
  String get addExerciseDialog_title => 'Añadir nuevo ejercicio';

  @override
  String get addExerciseDialog_label => 'Introduce el nombre del ejercicio';

  @override
  String addExerciseDialog_success(Object exerciseName) {
    return 'Ejercicio \"$exerciseName\" añadido';
  }

  @override
  String get addExerciseDialog_anotherTitle => '¿Añadir otro ejercicio?';

  @override
  String get addExerciseDialog_anotherContent =>
      '¿Quieres añadir otro ejercicio?';

  @override
  String get addWorkoutPlan_title => 'Añadir plan de entrenamiento';

  @override
  String get addWorkoutPlan_planName => 'Nombre del plan de entrenamiento';

  @override
  String get addWorkoutPlan_selectedExercises => 'Ejercicios seleccionados:';

  @override
  String get addWorkoutPlan_noExercises =>
      'No se han seleccionado ejercicios aún.';

  @override
  String get addWorkoutPlan_availableExercises => 'Ejercicios disponibles:';

  @override
  String get addWorkoutPlan_addNewExercise => 'Añadir nuevo ejercicio';

  @override
  String get addWorkoutPlan_save => 'Guardar plan de entrenamiento';

  @override
  String get addWorkoutPlan_missingName =>
      'Introduce un nombre para el plan de entrenamiento.';

  @override
  String get addWorkoutPlan_missingExercises =>
      'Selecciona al menos un ejercicio.';

  @override
  String get tabBottomDrawer_showOnly => 'Mostrar solo:';

  @override
  String get tabBottomDrawer_addNewGym => 'Añadir gimnasio';

  @override
  String get tabBottomDrawer_addNewUser => 'Añadir usuario';

  @override
  String get tabBottomDrawer_addNewExercise => 'Añadir ejercicio';

  @override
  String get tabBottomDrawer_addNewWorkoutPlan =>
      'Añadir plan de entrenamiento';

  @override
  String get tabBottomDrawer_enterGymName => 'Introduce el nombre del gimnasio';

  @override
  String get tabBottomDrawer_enterUserName => 'Introduce el nombre del usuario';

  @override
  String get tabBottomDrawer_editTitle => 'Editar nombre';

  @override
  String get tabBottomDrawer_enterWorkoutPlanName =>
      'Introduce el nombre del plan de entrenamiento';

  @override
  String get tabBottomDrawer_editLabel => 'Introduce un nuevo nombre';

  @override
  String get tabBottomDrawer_refreshScreen =>
      'Actualiza la pantalla para ver los cambios';

  @override
  String get tabSector_gym => 'Gimnasio';

  @override
  String get tabSector_user => 'Usuario';

  @override
  String get tabSector_exercise => 'Ejercicio';

  @override
  String get tabSector_workoutPlan => 'Plan de entrenamiento';

  @override
  String get sortSector_newest => 'Más recientes';

  @override
  String get sortSector_oldest => 'Más antiguos';

  @override
  String get sortSector_exerciseView => 'Ejercicios';

  @override
  String get sortSector_historyView => 'Historial';

  @override
  String get historyView_noWorkouts => 'No hay entrenamientos disponibles';

  @override
  String get historyView_exerciseNotFound => 'Ejercicio no encontrado';

  @override
  String get historyView_noWorkoutNotesMessage =>
      'En esta sección se mostrarán las notas de tus entrenamientos';

  @override
  String get historyView_noWorkoutNotesFilteredMessage =>
      'Ningún resultado coincide con tus filtros.';

  @override
  String get notes_justNow => 'Justo ahora';

  @override
  String notes_minutesAgo(Object count) {
    return 'Hace $count minutos';
  }

  @override
  String notes_hoursAgo(Object count) {
    return 'Hace $count horas';
  }

  @override
  String notes_daysAgo(Object count) {
    return 'Hace $count días';
  }

  @override
  String get notes_invalidDate => 'Fecha no válida';

  @override
  String get notes_showMore => 'Mostrar más';

  @override
  String get notes_showLess => 'Mostrar menos';

  @override
  String get exerciseView_filteredOutExercises =>
      'Ejercicios que no coinciden con los filtros:';

  @override
  String get exerciseView_noExercisesMessage =>
      'Entra en la sección \'Ejercicio\' para añadir tu primer ejercicio.';

  @override
  String get iconSelection_chooseIcon => 'Elige un icono para el ejercicio';

  @override
  String iconSelection_exerciseName(Object exerciseName) {
    return '$exerciseName';
  }

  @override
  String get exerciseExpansion_addUserGym =>
      'Añadir usuario y gimnasio al ejercicio';

  @override
  String get exerciseExpansion_deleteExercise => 'Eliminar ejercicio';

  @override
  String get exerciseExpansion_confirmDelete =>
      '¿Seguro que quieres eliminar este ejercicio? Esto también eliminará todos los datos relacionados con él.';

  @override
  String get exerciseExpansion_addIcon => 'Añadir icono al ejercicio';

  @override
  String get exerciseExpansion_unknownExercise => 'Ejercicio desconocido';

  @override
  String get exerciseExpansion_unknownUser => 'Usuario desconocido';

  @override
  String get exerciseExpansion_unknownGym => 'Gimnasio desconocido';

  @override
  String get exerciseExpansion_noWorkouts =>
      'No hay entrenamientos disponibles';

  @override
  String get exerciseExpansion_changeNameTitle =>
      'Cambiar nombre del ejercicio';

  @override
  String get exerciseExpansion_enterNewName => 'Nuevo nombre del ejercicio';

  @override
  String addUserAndGym_title(Object exercise) {
    return 'Asignar $exercise a usuario y gimnasio';
  }

  @override
  String get addUserAndGym_selectUser => 'Selecciona usuario';

  @override
  String get addUserAndGym_selectGym => 'Selecciona gimnasio';

  @override
  String get addUserAndGym_confirmSelection => 'Confirmar selección';

  @override
  String get addUserAndGym_workoutExists =>
      'Este entrenamiento ya existe para el usuario y gimnasio seleccionados.';

  @override
  String addUserAndGym_workoutGlobalNote(Object exerciseName) {
    return 'Agrega una nota general para el ejercicio $exerciseName, por ejemplo: configuración de la máquina, tipo de agarre, consejos técnicos, etc.';
  }

  @override
  String resultsExpansion_title(Object gymName, Object userName) {
    return '$userName • $gymName';
  }

  @override
  String resultsExpansion_lastNoteDate(Object date) {
    return 'Última nota: $date';
  }

  @override
  String get resultsExpansion_quickValue => 'Establecer valor rápido';

  @override
  String get resultsExpansion_quickValueSet => 'Introduce texto o número';

  @override
  String get resultsExpansion_deleteWorkoutConfirmation =>
      '¿Seguro que quieres eliminar esta sección junto con todos sus resultados?';

  @override
  String get notes_title => 'Notas de Entrenamiento';

  @override
  String get notes_addNote => '+ Añadir nota';

  @override
  String get notes_cancel => 'Cancelar';

  @override
  String get notes_hint => 'Escribe tu nota...';

  @override
  String get notes_saveNote => 'Guardar nota';

  @override
  String get notes_updateNote => 'Actualizar nota';

  @override
  String get notes_empty => 'No hay notas disponibles';

  @override
  String get notes_emptyNote => 'Sin nota';

  @override
  String get notes_deleteNoteTitle => 'Eliminar nota';

  @override
  String get notes_deleteNoteConfirm =>
      '¿Seguro que quieres eliminar esta nota?';

  @override
  String get notes_copy => 'Copiar nota';

  @override
  String get notes_copied => 'Nota copiada al portapapeles';

  @override
  String get globalNote_title => 'Nota global';

  @override
  String get globalNote_empty => 'Sin nota...';

  @override
  String get globalNote_hint => 'Introduce una nota';

  @override
  String get notificationScreen_title => 'Notificaciones';

  @override
  String get notificationScreen_permissionTooltip =>
      'Solicitar permisos para notificaciones';

  @override
  String get notificationList_title => 'Notificaciones guardadas:';

  @override
  String get notificationList_empty => 'No hay notificaciones guardadas.';

  @override
  String notificationList_hour(Object time) {
    return 'Hora: $time';
  }

  @override
  String get notificationList_daily => 'Diariamente';

  @override
  String notificationList_interval(Object days) {
    return 'Cada $days días';
  }

  @override
  String get notificationList_weekly_none => 'Sin días';

  @override
  String get notificationList_type_training => 'Entrenamiento';

  @override
  String get notificationList_type_weight => 'Peso';

  @override
  String get notificationList_type_measurement => 'Medición';

  @override
  String get notificationList_type_custom => 'Personalizado';

  @override
  String get notificationList_confirm_title => 'Confirmación';

  @override
  String get notificationList_confirm_content =>
      '¿Seguro que quieres eliminar esta notificación?';

  @override
  String get notificationForm_titleLabel => 'Título de la notificación:';

  @override
  String get notificationForm_titleHint =>
      'Escribe un título personalizado para la notificación...';

  @override
  String get notificationForm_messageLabel => 'Contenido de la notificación:';

  @override
  String get notificationForm_messageHint =>
      'Escribe el contenido personalizado de la notificación...';

  @override
  String get notificationForm_addNotification => 'Añadir notificación';

  @override
  String get notificationForm_added => '¡Notificación añadida!';

  @override
  String get notificationForm_typeLabel => 'Tipo de recordatorio:';

  @override
  String get notificationForm_typeTraining => 'Sobre el entrenamiento';

  @override
  String get notificationForm_typeWeight => 'Sobre la medición de peso';

  @override
  String get notificationForm_typeMeasurement => 'Sobre la medición corporal';

  @override
  String get notificationForm_typeCustom => 'Personalizado';

  @override
  String get notificationForm_modeLabel => 'Modo de notificación:';

  @override
  String get notificationForm_modeDaily => 'Diariamente';

  @override
  String get notificationForm_modeInterval => 'Cada X días';

  @override
  String get notificationForm_modeWeekly => 'Días seleccionados de la semana';

  @override
  String get notificationForm_intervalPrefix => 'Cada';

  @override
  String get notificationForm_intervalSuffix => 'd.';

  @override
  String get notificationForm_weekdayMon => 'Lun';

  @override
  String get notificationForm_weekdayTue => 'Mar';

  @override
  String get notificationForm_weekdayWed => 'Mié';

  @override
  String get notificationForm_weekdayThu => 'Jue';

  @override
  String get notificationForm_weekdayFri => 'Vie';

  @override
  String get notificationForm_weekdaySat => 'Sáb';

  @override
  String get notificationForm_weekdaySun => 'Dom';

  @override
  String get notificationForm_defaultTitleTraining => '¡Hora de entrenar!';

  @override
  String get notificationForm_defaultMessageTraining =>
      'No olvides tu actividad física.';

  @override
  String get notificationForm_defaultTitleWeight => 'Revisa tu peso';

  @override
  String get notificationForm_defaultMessageWeight =>
      'Recordatorio para pesarte. Registra tu resultado en la aplicación.';

  @override
  String get notificationForm_defaultTitleMeasurement => 'Haz tus mediciones';

  @override
  String get notificationForm_defaultMessageMeasurement =>
      'Es hora de medir tu cuerpo. ¡Sigue tus progresos!';

  @override
  String get timePicker_label => 'Hora';

  @override
  String get watchAds_title => 'Mira anuncios para apoyarnos';

  @override
  String get watchAds_description =>
      'Mira un breve anuncio en vídeo para apoyarnos sin gastar dinero';

  @override
  String get watchAds_button => 'Ver anuncio';

  @override
  String get watchAds_counter => 'Anuncios vistos:';

  @override
  String get shareApp_title => 'Comparte la aplicación';

  @override
  String get shareApp_inviteTitle =>
      '¡Comparte la aplicación con amigos y familia!';

  @override
  String get shareApp_inviteSubtitle =>
      'Ayúdanos a crecer la comunidad compartiendo la aplicación con personas que puedan encontrarla útil.';

  @override
  String get shareApp_shareButton => 'Compartir vía...';

  @override
  String get shareApp_linkCopied => 'Enlace copiado al portapapeles';

  @override
  String get shareApp_shareText => 'Mira esta aplicación:';

  @override
  String get shareApp_ratingTitle => '¿Te gusta GoGymSimple?';

  @override
  String get shareApp_ratingSubtitle =>
      '¿Te gustaría calificar GoGymSimple? Tu opinión ayuda a otros a descubrir la app.';

  @override
  String get shareApp_ratingYes => '¡Claro!';

  @override
  String get donate_title => 'Apóyanos';

  @override
  String get donateSections_whyTitle => '¿Por qué apoyarnos?';

  @override
  String get donateSections_whyDesc =>
      'Tus donaciones nos ayudan a mantener y desarrollar este proyecto. Todos los pagos son voluntarios y no desbloquean funciones o contenidos especiales.';

  @override
  String get donateSections_monthlyTitle => 'Suscripción mensual';

  @override
  String get donateSections_monthlyDesc => 'Apóyanos con una donación mensual';

  @override
  String get donateSections_monthlyButton => 'Suscribirse mensualmente';

  @override
  String get donateSections_oneTimeTitle => 'Donación única';

  @override
  String get donateSections_oneTimeDesc =>
      'Realiza un pago único por la cantidad que elijas';

  @override
  String get donateSections_oneTimeButton => 'Pagar ahora';

  @override
  String get donateSections_voluntaryTitle => '100% Voluntario';

  @override
  String get donateSections_voluntaryDesc =>
      'Recuerda que todas las donaciones son completamente voluntarias. No recibirás funciones ni contenidos especiales, solo nuestro sincero agradecimiento por apoyar el proyecto.';

  @override
  String get welcomeExerciseStep_favoriteExercises => 'Ejercicios favoritos';

  @override
  String get welcomeExerciseStep_selectFew =>
      'Selecciona algunos ejercicios para empezar';

  @override
  String get welcomeExerciseStep_addYourOwn => 'Añade tu propio ejercicio';

  @override
  String get welcomeExerciseStep_exampleExercise => 'ej. Sentadillas búlgaras';

  @override
  String get welcomeExerciseStep_addButton => 'Añadir';

  @override
  String get welcomeExerciseStep_nextButton => 'Siguiente';

  @override
  String get welcomeGymLocationStep_workoutPreferences =>
      'Preferencias de entrenamiento';

  @override
  String get welcomeGymLocationStep_whereDoYouTrain =>
      '¿Dónde sueles entrenar?';

  @override
  String get welcomeGymLocationStep_homeWorkout => 'Entreno en casa';

  @override
  String get welcomeGymLocationStep_gym => 'Gimnasio';

  @override
  String welcomeGymLocationStep_gymNameLabel(Object index) {
    return 'Nombre del gimnasio $index';
  }

  @override
  String get welcomeGymLocationStep_next => 'Siguiente';

  @override
  String get welcomeIntroSteps_welcomeTitle => 'Bienvenido a GoGymSimple';

  @override
  String get welcomeIntroSteps_welcomeSubtitle =>
      'Configura tu perfil para comenzar tu aventura con la aplicación';

  @override
  String get welcomeIntroSteps_getStartedButton => 'Comenzar';

  @override
  String get welcomeIntroSteps_personalInfoTitle => 'Datos personales';

  @override
  String get welcomeIntroSteps_yourNameLabel => 'Tu nombre';

  @override
  String get welcomeIntroSteps_nextButton => 'Siguiente';

  @override
  String get welcomeSettingStep_appSettings => 'Configuración de la aplicación';

  @override
  String get welcomeSettingStep_measurementSystem => 'Sistema de medidas';

  @override
  String get welcomeSettingStep_metric => 'Métrico';

  @override
  String get welcomeSettingStep_imperial => 'Imperial';

  @override
  String get welcomeSettingStep_appTheme => 'Tema de la aplicación';

  @override
  String get welcomeSettingStep_enterGoGymSimple => 'Entrar a GoGymSimple';

  @override
  String get welcomeScreen_chooseLanguage => 'Elige idioma';

  @override
  String get welcomeScreen_english => 'Inglés';

  @override
  String get welcomeScreen_polish => 'Polaco';

  @override
  String get welcomeScreen_languageTooltip => 'Cambiar idioma';

  @override
  String get welcomeScreen_exercise_benchPress => 'Press de banca';

  @override
  String get welcomeScreen_exercise_squats => 'Sentadillas';

  @override
  String get welcomeScreen_exercise_deadlift => 'Peso muerto';

  @override
  String get welcomeScreen_exercise_pullUps => 'Dominadas';

  @override
  String get welcomeScreen_exercise_pushUps => 'Flexiones';

  @override
  String get welcomeScreen_exercise_lunges => 'Zancadas';

  @override
  String get welcomeEnd_welcome => 'Bienvenido a GoGymSimple';

  @override
  String get stopwatch_title => 'Cronómetro';

  @override
  String get workoutScreen_title => 'Entrenamiento';

  @override
  String get workoutScreen_gym => 'Selecciona gimnasio';

  @override
  String get workoutScreen_gymAndDate => 'Selecciona gimnasio y fecha';

  @override
  String get workoutScreen_selectGymFirst => 'Primero selecciona un gimnasio';

  @override
  String get workoutScreen_noGymSelected => 'Ningún gimnasio seleccionado';

  @override
  String get workoutScreen_saved => '¡Entrenamiento guardado!';

  @override
  String get workoutScreen_participants => 'Participantes';

  @override
  String get workoutScreen_plans => 'Planes';

  @override
  String get workoutScreen_exercises => 'Ejercicios';

  @override
  String get workoutScreen_addExercise => 'Agregar ejercicio';

  @override
  String get workoutScreen_addNote => 'Agregar nota';

  @override
  String get workoutScreen_saveNote => 'Guardar nota';

  @override
  String get workoutScreen_savedNote => 'Guardado';

  @override
  String get workoutScreen_showMoreInfo => 'Mostrar más información';

  @override
  String get saveWorkoutDialog_save_workout_title =>
      '¿Quieres guardar el entrenamiento?';

  @override
  String get saveWorkoutDialog_save_workout_subtitle =>
      'Guarda este entrenamiento para volver más tarde';

  @override
  String get saveWorkoutDialog_save_workout_button => 'Guardar entrenamiento';

  @override
  String get saveWorkoutDialog_dont_save_workout_button => 'Ahora no';

  @override
  String get saveWorkoutDialog_support_us_title => 'Apóyanos';

  @override
  String get saveWorkoutDialog_support_us_subtitle =>
      '¡Mira un anuncio corto para apoyar la aplicación!';
}
