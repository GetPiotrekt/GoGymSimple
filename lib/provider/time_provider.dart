import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  bool isRunning = false;
  bool isExpanded = true;

  DateTime? _startTime;
  Duration elapsed = Duration.zero;

  String get formattedElapsed {
    final totalElapsed = _getElapsedTime();
    final hours = totalElapsed.inHours;
    final minutes = (totalElapsed.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (totalElapsed.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds = (totalElapsed.inMilliseconds % 1000)
        .toString().padLeft(3, '0').substring(0, 2);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')} : $minutes : $seconds . $milliseconds';
    } else {
      return '$minutes : $seconds . $milliseconds';
    }
  }

  void start() {
    if (!isRunning) {
      _startTime = DateTime.now().subtract(elapsed);
      isRunning = true;
      _updateTime();
      notifyListeners();
    }
  }

  void stop() {
    if (isRunning) {
      elapsed = _getElapsedTime();
      isRunning = false;
      notifyListeners();
    }
  }

  void reset() {
    if (isRunning) {
      _startTime = DateTime.now();
      elapsed = Duration.zero;
    } else {
      _startTime = null;
      elapsed = Duration.zero;
    }
    notifyListeners();
  }

  void toggleExpanded() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  void _updateTime() {
    if (isRunning) {
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 30), _updateTime);
    }
  }

  Duration _getElapsedTime() {
    if (!isRunning || _startTime == null) return elapsed;
    return DateTime.now().difference(_startTime!);
  }
}
