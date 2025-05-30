import 'dart:async';

class CustomTimer {
  final Duration duration;
  final void Function(Duration remaining) onTick;
  final void Function()? onComplete;

  late Timer _timer;
  late DateTime _endTime;

  CustomTimer({
    required this.duration,
    required this.onTick,
    this.onComplete,
  });

  void start() {
    _endTime = DateTime.now().add(duration);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = _endTime.difference(DateTime.now());

      if (remaining <= Duration.zero) {
        _timer.cancel();
        onTick(Duration.zero);
        onComplete?.call();
      } else {
        onTick(remaining);
      }
    });
  }

  void stop() {
    _timer.cancel();
  }
}
