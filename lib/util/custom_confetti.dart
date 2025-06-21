import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CustomConfetti extends StatelessWidget {
  final ConfettiController confettiController;

  const CustomConfetti({super.key, required this.confettiController});

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      shouldLoop: false,
      blastDirectionality: BlastDirectionality.explosive,
      numberOfParticles: 20,
      emissionFrequency: 0.05,
      maxBlastForce: 30,
      minBlastForce: 10,
      gravity: 0.2,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.orange,
        Colors.purple,
        Colors.pink,
        Colors.yellow,
        Colors.red,
      ],
    );
  }
}
