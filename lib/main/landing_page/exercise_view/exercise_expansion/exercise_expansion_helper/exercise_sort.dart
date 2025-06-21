import '../../../../../data/data_tab_sector/exercise_db.dart';
import '../../../../../l10n/app_localizations.dart';

bool isNumeric(String s) => double.tryParse(s) != null;

int sortByName(int a, int b, String sortOrder, AppLocalizations t) {
  final exerciseA = ExerciseBox.getExercisebyID(a);
  final exerciseB = ExerciseBox.getExercisebyID(b);

  final nameA = exerciseA?.exerciseName.toLowerCase() ?? t.unknownExercise.toLowerCase();
  final nameB = exerciseB?.exerciseName.toLowerCase() ?? t.unknownExercise.toLowerCase();

  final nameAIsNum = isNumeric(nameA);
  final nameBIsNum = isNumeric(nameB);


  int result;
  if (sortOrder == "zToA") {
    if (nameAIsNum && nameBIsNum) {
      // porównanie liczbowe malejąco
      result = double.parse(nameB).compareTo(double.parse(nameA));
    } else if (nameAIsNum) {
      // liczby traktujemy jako większe od tekstu (na końcu)
      result = 1;
    } else if (nameBIsNum) {
      result = -1;
    } else {
      result = nameB.compareTo(nameA);
    }
  } else {
    if (nameAIsNum && nameBIsNum) {
      // porównanie liczbowe rosnąco
      result = double.parse(nameA).compareTo(double.parse(nameB));
    } else if (nameAIsNum) {
      // liczby na początku listy
      result = -1;
    } else if (nameBIsNum) {
      result = 1;
    } else {
      result = nameA.compareTo(nameB);
    }
  }

  return result;
}
