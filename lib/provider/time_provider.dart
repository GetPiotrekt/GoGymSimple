import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  bool isRunning = false;
  Duration elapsed = Duration.zero;
  Duration totalTime = Duration.zero;
  final Stopwatch _stopwatch = Stopwatch();

  String get formattedElapsed {
    final minutes = (elapsed.inSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds = (elapsed.inMilliseconds % 1000)
        .toString().padLeft(3, '0').substring(0, 2); // Pokazujemy tylko 2 cyfry milisekund
    return '$minutes : $seconds . $milliseconds';
  }

  void start() {
    _stopwatch.start();
    isRunning = true;
    _updateTime();
    notifyListeners();
  }

  void stop() {
    _stopwatch.stop();
    isRunning = false;
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    elapsed = Duration.zero;
    totalTime = Duration.zero;
    notifyListeners();
  }

  void _updateTime() {
    if (_stopwatch.isRunning) {
      elapsed = _stopwatch.elapsed;
      Future.delayed(const Duration(milliseconds: 30), _updateTime);
      notifyListeners();
    }
  }
}
