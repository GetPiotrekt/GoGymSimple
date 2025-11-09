import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/color_provider.dart';
import '../../provider/ad_provider.dart';
import '../drawer/support/watch_ad/watch_ad.dart';

class AdIconOrTimer extends StatelessWidget {
  const AdIconOrTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final adProvider = Provider.of<AdProvider>(context);

    final remaining = adProvider.cooldownRemaining;

    // Jeśli limit 5 reklam dziennie osiągnięty
    if (adProvider.unlockedConfetti) {
      return IconButton(
        icon: Icon(
          Icons.celebration,
          color: colorProvider.accent.withOpacity(0.7),
        ),
        onPressed: () {
          const WatchAd().showWatchAdsBottomSheet(context);
        },
      );
    }

    // Jeśli nie ma cooldownu — pokazujemy ikonę reklamy
    if (remaining == Duration.zero) {
      return IconButton(
        icon: Icon(
          Icons.ondemand_video,
          color: colorProvider.accent.withOpacity(0.7),
        ),
        onPressed: () {
          const WatchAd().showWatchAdsBottomSheet(context);
        },
      );
    }

    // W trakcie cooldownu pokazujemy timer
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(remaining.inMinutes.remainder(60));
    final seconds = twoDigits(remaining.inSeconds.remainder(60));

    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              const WatchAd().showWatchAdsBottomSheet(context);
            },
            child: SizedBox(
              width: 50,
              height: 36,
              child: Center(
                child: Text(
                  '$minutes:$seconds',
                  style: TextStyle(
                    color: colorProvider.accent.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
