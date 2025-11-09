import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/color_provider.dart';

class BottomSheetTemplate extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed; // teraz nullable

  const BottomSheetTemplate({
    super.key,
    required this.child,
    this.onPressed, // teraz opcjonalny
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: SafeArea(
          top: true,
          bottom: false, // padding od dołu obsługuje AnimatedPadding
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            decoration: BoxDecoration(
              color: colorProvider.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                Flexible(
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
                if (onPressed != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: colorProvider.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(Icons.keyboard_arrow_down_outlined, color: colorProvider.accent),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
