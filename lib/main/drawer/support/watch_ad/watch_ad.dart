import 'package:GoGymSimple/util/snackbar_helper.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/color_provider.dart';
import '../../../../data/config_db.dart';
import '../../../../l10n/app_localizations.dart';
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
  int adWatchCount = 0;
  late ConfettiController _confettiController;
  bool _isLoadingAd = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _loadAdWatchCount();
  }

  Future<void> _loadAdWatchCount() async {
    // Odczytujemy wartość z Hive, jeśli jest, to parsujemy na int, jeśli nie, to 0
    final adsValue = ConfigBox.getConfig('ads');
    setState(() {
      adWatchCount = int.tryParse(adsValue ?? '0') ?? 0;
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleAdWatched() async {
    setState(() {
      adWatchCount++;
      _isLoadingAd = false;
    });

    // Aktualizujemy w bazie
    await ConfigBox.updateConfig('ads', adWatchCount.toString());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dziękujemy za wsparcie!')),
    );
  }

  void _loadAd() {
    setState(() {
      _isLoadingAd = true;
    });

    AdManager.loadRewardedAd(
      _confettiController,
          () {
        _handleAdWatched();
      },
      onAdFailedToLoad: () {
        setState(() {
          _isLoadingAd = false;
        });

        // Zamiana snackbar na dialog
        showConfirmationDialog(
          context: context,
          title: ":)",
          content: AppLocalizations.of(context)!.watchAds_error,
          onConfirmed: () {
            // Opcjonalna akcja po potwierdzeniu, np. zamknięcie dialogu - ale to jest już w dialogu
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: cp.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cp.accent.withOpacity(0.3), width: 1.2),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: cp.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _isLoadingAd ? null : _loadAd,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_circle_outline,
                                    color: cp.secondary, size: 32),
                                const SizedBox(height: 4),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(t.watchAds_button,
                                      style: TextStyle(color: cp.secondary)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Tutaj pokazujemy loader na przycisku jeśli ładuje
                        if (_isLoadingAd)
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(cp.accent),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
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
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CustomConfetti(confettiController: _confettiController)
        ),
      ],
    );
  }
}
