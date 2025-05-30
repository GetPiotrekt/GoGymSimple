import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

enum CornerStyle { ALL, TOP_ONLY, BOTTOM_ONLY, LEFT_ONLY, RIGHT_ONLY, NONE }

class ButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String labelText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool showBorder;
  final CornerStyle cornerStyle;
  final bool isEnabled; // Make isEnabled optional with default value of true

  const ButtonIcon({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.labelText,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.showBorder = false,
    this.cornerStyle = CornerStyle.ALL,
    this.isEnabled = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    BorderRadius getBorderRadius() {
      switch (cornerStyle) {
        case CornerStyle.ALL:
          return BorderRadius.circular(8.0);
        case CornerStyle.TOP_ONLY:
          return const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0));
        case CornerStyle.LEFT_ONLY:
          return const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0));
        case CornerStyle.RIGHT_ONLY:
          return const BorderRadius.only(
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0));
        case CornerStyle.BOTTOM_ONLY:
          return const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0));
        case CornerStyle.NONE:
          return BorderRadius.zero;
      }
    }

    // Style adjustments when the button is disabled
    final disabledColor = colorProvider.secondary.withOpacity(0.5);
    final disabledTextColor = colorProvider.accent.withOpacity(0.5);

    return ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null, // Disable the button when isEnabled is false
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnabled ? (backgroundColor ?? colorProvider.accent.withOpacity(0.1)) : disabledColor,
        shape: RoundedRectangleBorder(
          side: showBorder
              ? BorderSide(width: 1.5, color: borderColor ?? colorProvider.accent.withOpacity(0.7))
              : BorderSide.none,
          borderRadius: getBorderRadius(),
        ),
      ),
      icon: Icon(
        iconData,
        color: isEnabled ? (textColor ?? colorProvider.accent) : disabledTextColor, // Change icon color when disabled
      ),
      label: FittedBox(
        child: Text(
          labelText,
          style: TextStyle(color: isEnabled ? (textColor ?? colorProvider.accent) : disabledTextColor), // Change text color when disabled
        ),
      ),
    );
  }
}
