import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class ButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String labelText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool showBorder;
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
    this.isEnabled = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    // Style adjustments when the button is disabled
    final disabledColor = colorProvider.secondary.withOpacity(0.5);
    final disabledTextColor = colorProvider.accent.withOpacity(0.5);

    return ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      // Disable the button when isEnabled is false
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
        backgroundColor: isEnabled
            ? (backgroundColor ?? colorProvider.accent.withOpacity(0.1))
            : disabledColor,
        shape: RoundedRectangleBorder(
          side: showBorder
              ? BorderSide(
                  width: 1.5,
                  color: borderColor ?? colorProvider.accent.withOpacity(0.7))
              : BorderSide.none,
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      icon: Icon(
        iconData,
        color: isEnabled
            ? (textColor ?? colorProvider.accent)
            : disabledTextColor, // Change icon color when disabled
      ),
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          labelText,
          style: TextStyle(
              fontSize: 14,
              color: isEnabled
                  ? (textColor ?? colorProvider.accent)
                  : disabledTextColor), // Change text color when disabled
        ),
      ),
    );
  }
}
