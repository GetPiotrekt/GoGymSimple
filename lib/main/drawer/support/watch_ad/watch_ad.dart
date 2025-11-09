import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/color_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/ad_provider.dart';
import '../../../../util/bottom_sheet/bottom_sheet.dart';
import '../../../../util/custom_confetti.dart';
import '../../../../util/dialog/confirmation_dialog.dart';
import 'ad_manager.dart';

class WatchAd extends StatefulWidget {
  const WatchAd({super.key});

  @override
  State<WatchAd> createState() => _WatchAdState();

  void showWatchAdsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BottomSheetTemplate(
        child: WatchAd(),
      ),
    );
    FocusScope.of(context).unfocus();
  }
}

class _WatchAdState extends State<WatchAd> {
  late ConfettiController _confettiController;
  Timer? _cooldownTimer;
  Duration _remainingTime = Duration.zero;
  bool _isLoadingAd = false;
  bool _isHidden = false;
  bool _isInitialized = false; // <-- nowa flaga

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    // Wywołaj inicjalizację z providera
    Future.microtask(() async {
      final adProvider = context.read<AdProvider>();
      await adProvider.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _startCooldownTimer(adProvider);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adProvider = context.read<AdProvider>();
    _startCooldownTimer(adProvider);
  }

  void _startCooldownTimer(AdProvider adProvider) {
    _cooldownTimer?.cancel();

    final cooldown = adProvider.cooldownRemaining;

    if (cooldown > Duration.zero) {
      setState(() => _remainingTime = cooldown);

      _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final newCooldown = adProvider.cooldownRemaining;
        if (newCooldown <= Duration.zero) {
          timer.cancel();
          setState(() => _remainingTime = Duration.zero);
        } else {
          setState(() => _remainingTime = newCooldown);
        }
      });
    } else {
      setState(() => _remainingTime = Duration.zero);
    }
  }


  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;
    final adProvider = context.watch<AdProvider>();

    final adWatchCount = adProvider.adWatchCount;
    final adsWatchedToday = adProvider.adsWatchedToday;
    final unlockedConfetti = adProvider.unlockedConfetti;
    final isOnCooldown = _remainingTime > Duration.zero && adsWatchedToday > 0;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 18, top: 6),
              decoration: BoxDecoration(
                color: cp.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cp.accent.withOpacity(0.1), width: 1.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Row(
                      children: [
                        Icon(Icons.ondemand_video, color: cp.accent),
                        const SizedBox(width: 8),
                        Text(
                          t.watchAds_title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: cp.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.watchAds_description,
                    style: TextStyle(color: cp.accent.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: (isOnCooldown) ? 0.7 : 1,
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: cp.accent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        if (isOnCooldown || adsWatchedToday >= 5) return;

                                        if (adProvider.unlockedConfetti) {
                                          _confettiController.play();
                                        } else {
                                          setState(() => _isLoadingAd = true);
                                          AdManager.loadRewardedAd(
                                            _confettiController,
                                                () async {
                                              await adProvider.handleAdWatched();
                                              _startCooldownTimer(adProvider); // <--- DODAJ TO
                                              setState(() => _isLoadingAd = false);
                                              if (adProvider.unlockedConfetti) {
                                                _confettiController.play();
                                              }
                                            },
                                            onAdFailedToLoad: () {
                                              setState(() => _isLoadingAd = false);
                                              ConfirmationDialog.show(
                                                context: context,
                                                title: ":)",
                                                content: t.watchAds_error,
                                                onConfirmed: () {},
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            adsWatchedToday >= 5
                                                ? Icons.celebration
                                                : Icons.play_circle_outline,
                                            color: cp.secondary,
                                            size: 32,
                                          ),
                                          const SizedBox(height: 4),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: isOnCooldown
                                                ? Text(
                                              _formatDuration(_remainingTime),
                                              style: TextStyle(color: cp.secondary),
                                            )
                                                : (adsWatchedToday >= 5
                                                ? const SizedBox.shrink()
                                                : Text(
                                              t.watchAds_button,
                                              style: TextStyle(color: cp.secondary),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (_isLoadingAd)
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(cp.accent),
                                      ),
                                    ),
                                  ),
                                if (adsWatchedToday > 0)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      child: Text(
                                        '$adsWatchedToday/5',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: cp.secondary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.visibility, color: cp.accent),
                                    const SizedBox(width: 8),
                                    Text(t.watchAds_counter,
                                        style: TextStyle(color: cp.accent)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: cp.accent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$adWatchCount',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: cp.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (unlockedConfetti)
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: cp.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: cp.accent.withOpacity(0.1), width: 1.5),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            t.watchAds_done,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: cp.accent),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: cp.accent.withAlpha(25), // ≈ 0.1
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cp.accent.withOpacity(0.1), width: 1.5),
              ),
              child: ListTile(
                onTap: () {
                  adProvider.setAdHidden(!adProvider.isHidden);
                },
                leading: Icon(
                  adProvider.isHidden
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: cp.accent,
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    t.watchAds_hide,
                    style: TextStyle(color: cp.accent),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CustomConfetti(confettiController: _confettiController),
        ),
      ],
    );
  }
}