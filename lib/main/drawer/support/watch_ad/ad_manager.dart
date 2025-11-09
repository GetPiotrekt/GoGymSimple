import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:confetti/confetti.dart';

import '../../../../data/config_db.dart';

class AdManager {
  static RewardedAd? _rewardedAd;

  static Future<void> loadRewardedAd(
      ConfettiController konfettiController,
      VoidCallback onReward, {
        VoidCallback? onAdFailedToLoad,
      }) async {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-5706836528130524/9891946626',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) => ad.dispose(),
            onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose(),
          );

          _rewardedAd!.show(
            onUserEarnedReward: (ad, reward) async {
              await _incrementWatchedAds();
              konfettiController.play(); // ✅ konfetti
              onReward(); // ✅ callback z WatchAd
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('❌ Nie udało się załadować reklamy: $error');
          if (onAdFailedToLoad != null) {
            onAdFailedToLoad();
          }
        },
      ),
    );
  }


  static Future<void> _incrementWatchedAds() async {
    final adsStr = ConfigBox.getConfig('ads') ?? '0';
    final currentAds = int.tryParse(adsStr) ?? 0;
    final updatedAds = currentAds + 1;

    await ConfigBox.updateConfig('ads', updatedAds.toString());
    print('Zaktualizowano liczbę obejrzanych reklam: $updatedAds');
  }
}
