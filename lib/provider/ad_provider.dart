import 'dart:async';
import 'package:flutter/material.dart';
import '../data/config_db.dart';

class AdProvider extends ChangeNotifier {
  static const Duration cooldownDuration = Duration(minutes: 10);

  DateTime? _nextAdTime;
  int _adWatchCount = 0;
  int _adsWatchedToday = 0;
  bool _isHidden = false;

  Duration remainingTime = Duration.zero;
  Timer? _cooldownTimer;

  // Gettery
  int get adWatchCount => _adWatchCount;
  int get adsWatchedToday => _adsWatchedToday;
  bool get unlockedConfetti => _adsWatchedToday >= 5;
  bool get isOnCooldown => cooldownRemaining > Duration.zero && _adsWatchedToday > 0;
  bool get isHidden => _isHidden;

  /// Inicjalizacja danych z pamięci
  Future<void> initialize() async {
    await _loadAdWatchCount();
    await _loadAdsWatchedToday();
    await _loadNextAdTime();
    await _loadAdVisibility();
  }

  Future<void> _loadAdWatchCount() async {
    final adsValue = ConfigBox.getConfig('ads');
    _adWatchCount = int.tryParse(adsValue ?? '0') ?? 0;
    print('Loaded ads watched total: $adsValue');
  }

  Future<void> _loadAdsWatchedToday() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastDate = ConfigBox.getConfig('last_ad_date') ?? '';

    print('Loading ads today: lastDate=$lastDate, today=$today');

    if (lastDate == today) {
      final todayCount = ConfigBox.getConfig('ads_today');
      _adsWatchedToday = int.tryParse(todayCount ?? '0') ?? 0;
      print('Loaded ads watched today: $_adsWatchedToday');
    } else {
      _adsWatchedToday = 0;
      print('New day detected - resetting ads watched today to 0');
      await ConfigBox.updateConfig('ads_today', '0');
      await ConfigBox.updateConfig('last_ad_date', today);
    }
  }


  Future<void> _loadNextAdTime() async {
    final savedTimeStr = ConfigBox.getConfig('next_ad_time');
    if (savedTimeStr != null) {
      _nextAdTime = DateTime.tryParse(savedTimeStr)?.toLocal();
      if (_nextAdTime != null) {
        final diff = cooldownRemaining;
        if (diff > Duration.zero) {
          _startCooldownTimer(diff);
        }
      }
    }
  }

  Duration get cooldownRemaining {
    if (_nextAdTime == null) return Duration.zero;
    final remaining = _nextAdTime!.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  void _startCooldownTimer(Duration duration) {
    _cooldownTimer?.cancel();
    remainingTime = duration;

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = cooldownRemaining;
      if (remaining <= const Duration(seconds: 1)) {
        timer.cancel();
        remainingTime = Duration.zero;
        notifyListeners();
      } else {
        remainingTime = remaining;
        notifyListeners();
      }
    });
  }

  /// Wywołaj po obejrzeniu reklamy
  Future<void> handleAdWatched() async {
    final now = DateTime.now();
    final nextTime = now.add(cooldownDuration);
    final today = now.toIso8601String().split('T')[0];

    _nextAdTime = nextTime;
    _adWatchCount++;
    _adsWatchedToday++;

    await ConfigBox.updateConfig('ads', _adWatchCount.toString());
    await ConfigBox.updateConfig('ads_today', _adsWatchedToday.toString());
    await ConfigBox.updateConfig('last_ad_date', today);
    await ConfigBox.updateConfig('next_ad_time', nextTime.toIso8601String());

    _startCooldownTimer(cooldownDuration);
    notifyListeners();
  }

  Future<void> _loadAdVisibility() async {
    final value = ConfigBox.getConfig('ad_visible');
    _isHidden = value == 'true'; // domyślnie false, jeśli null
  }

  Future<void> setAdHidden(bool hidden) async {
    _isHidden = hidden;
    notifyListeners();
    await ConfigBox.updateConfig('ad_visible', hidden.toString());
  }
}
