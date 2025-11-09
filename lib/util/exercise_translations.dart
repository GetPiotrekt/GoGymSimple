import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ExerciseTranslationHelper {
  static Map<String, String> getTranslationMap(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return {
      'barbellSquat': loc.exercise_barbellSquat,
      'deadlift': loc.exercise_deadlift,
      'benchPress': loc.exercise_benchPress,
      'overheadPress': loc.exercise_overheadPress,
      'pullUp': loc.exercise_pullUp,
      'chinUp': loc.exercise_chinUp,
      'barbellRow': loc.exercise_barbellRow,
      'dumbbellCurl': loc.exercise_dumbbellCurl,
      'tricepsDip': loc.exercise_tricepsDip,
      'latPulldown': loc.exercise_latPulldown,
      'inclineBenchPress': loc.exercise_inclineBenchPress,
      'declineBenchPress': loc.exercise_declineBenchPress,
      'legPress': loc.exercise_legPress,
      'legCurl': loc.exercise_legCurl,
      'legExtension': loc.exercise_legExtension,
      'calfRaise': loc.exercise_calfRaise,
      'seatedRow': loc.exercise_seatedRow,
      'tBarRow': loc.exercise_tBarRow,
      'pushUp': loc.exercise_pushUp,
      'sitUp': loc.exercise_sitUp,
      'crunch': loc.exercise_crunch,
      'plank': loc.exercise_plank,
      'russianTwist': loc.exercise_russianTwist,
      'jumpRope': loc.exercise_jumpRope,
      'bicycleCrunch': loc.exercise_bicycleCrunch,
      'mountainClimbers': loc.exercise_mountainClimbers,
      'kettlebellSwing': loc.exercise_kettlebellSwing,
      'sumoDeadlift': loc.exercise_sumoDeadlift,
      'frontSquat': loc.exercise_frontSquat,
      'hackSquat': loc.exercise_hackSquat,
      'hipThrust': loc.exercise_hipThrust,
      'gluteBridge': loc.exercise_gluteBridge,
      'cableFly': loc.exercise_cableFly,
      'lateralRaise': loc.exercise_lateralRaise,
      'rearDeltFly': loc.exercise_rearDeltFly,
      'hammerCurl': loc.exercise_hammerCurl,
      'skullCrusher': loc.exercise_skullCrusher,
      'facePull': loc.exercise_facePull,
      'farmersWalk': loc.exercise_farmersWalk,
      'abWheelRollout': loc.exercise_abWheelRollout,
      'cableRow': loc.exercise_cableRow,
      'inclineDumbbellCurl': loc.exercise_inclineDumbbellCurl,
      'oneArmDumbbellRow': loc.exercise_oneArmDumbbellRow,
      'dumbbellLunges': loc.exercise_dumbbellLunges,
      'gobletSquat': loc.exercise_gobletSquat,
      'bulgarianSplitSquat': loc.exercise_bulgarianSplitSquat,
      'stepUp': loc.exercise_stepUp,
      'ezBarCurl': loc.exercise_ezBarCurl,
      'arnoldPress': loc.exercise_arnoldPress,
    };
  }

  static String getTranslatedName(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;

    switch (key) {
      case 'barbellSquat':
        return loc.exercise_barbellSquat;
      case 'deadlift':
        return loc.exercise_deadlift;
      case 'benchPress':
        return loc.exercise_benchPress;
      case 'overheadPress':
        return loc.exercise_overheadPress;
      case 'pullUp':
        return loc.exercise_pullUp;
      case 'chinUp':
        return loc.exercise_chinUp;
      case 'barbellRow':
        return loc.exercise_barbellRow;
      case 'dumbbellCurl':
        return loc.exercise_dumbbellCurl;
      case 'tricepsDip':
        return loc.exercise_tricepsDip;
      case 'latPulldown':
        return loc.exercise_latPulldown;
      case 'inclineBenchPress':
        return loc.exercise_inclineBenchPress;
      case 'declineBenchPress':
        return loc.exercise_declineBenchPress;
      case 'legPress':
        return loc.exercise_legPress;
      case 'legCurl':
        return loc.exercise_legCurl;
      case 'legExtension':
        return loc.exercise_legExtension;
      case 'calfRaise':
        return loc.exercise_calfRaise;
      case 'seatedRow':
        return loc.exercise_seatedRow;
      case 'tBarRow':
        return loc.exercise_tBarRow;
      case 'pushUp':
        return loc.exercise_pushUp;
      case 'sitUp':
        return loc.exercise_sitUp;
      case 'crunch':
        return loc.exercise_crunch;
      case 'plank':
        return loc.exercise_plank;
      case 'russianTwist':
        return loc.exercise_russianTwist;
      case 'jumpRope':
        return loc.exercise_jumpRope;
      case 'bicycleCrunch':
        return loc.exercise_bicycleCrunch;
      case 'mountainClimbers':
        return loc.exercise_mountainClimbers;
      case 'kettlebellSwing':
        return loc.exercise_kettlebellSwing;
      case 'sumoDeadlift':
        return loc.exercise_sumoDeadlift;
      case 'frontSquat':
        return loc.exercise_frontSquat;
      case 'hackSquat':
        return loc.exercise_hackSquat;
      case 'hipThrust':
        return loc.exercise_hipThrust;
      case 'gluteBridge':
        return loc.exercise_gluteBridge;
      case 'cableFly':
        return loc.exercise_cableFly;
      case 'lateralRaise':
        return loc.exercise_lateralRaise;
      case 'rearDeltFly':
        return loc.exercise_rearDeltFly;
      case 'hammerCurl':
        return loc.exercise_hammerCurl;
      case 'skullCrusher':
        return loc.exercise_skullCrusher;
      case 'facePull':
        return loc.exercise_facePull;
      case 'farmersWalk':
        return loc.exercise_farmersWalk;
      case 'abWheelRollout':
        return loc.exercise_abWheelRollout;
      case 'cableRow':
        return loc.exercise_cableRow;
      case 'inclineDumbbellCurl':
        return loc.exercise_inclineDumbbellCurl;
      case 'oneArmDumbbellRow':
        return loc.exercise_oneArmDumbbellRow;
      case 'dumbbellLunges':
        return loc.exercise_dumbbellLunges;
      case 'gobletSquat':
        return loc.exercise_gobletSquat;
      case 'bulgarianSplitSquat':
        return loc.exercise_bulgarianSplitSquat;
      case 'stepUp':
        return loc.exercise_stepUp;
      case 'ezBarCurl':
        return loc.exercise_ezBarCurl;
      case 'arnoldPress':
        return loc.exercise_arnoldPress;
      default:
        return key;
    }
  }
}
