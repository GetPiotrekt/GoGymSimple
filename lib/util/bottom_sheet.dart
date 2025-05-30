import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class BottomSheetTemplate extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const BottomSheetTemplate({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom; // Pobieramy wysokość klawiatury

    return AnimatedPadding(
      duration: const Duration(milliseconds: 100), // Animacja podnoszenia
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: colorProvider.secondary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              child,
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
