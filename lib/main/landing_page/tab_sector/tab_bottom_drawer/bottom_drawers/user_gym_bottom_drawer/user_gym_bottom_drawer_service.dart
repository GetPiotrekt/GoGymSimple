import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../provider/color_provider.dart';

class SelectableIconCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;

  const SelectableIconCard({
    required this.name,
    required this.icon,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<ColorProvider>();

    final backgroundColor = isSelected
        ? colorProvider.accent.withOpacity(0.3)
        : colorProvider.accent.withOpacity(0.1);

    final iconColor = colorProvider.accent; // zawsze accent
    final textColor = colorProvider.accent; // zawsze accent

    return AnimatedScale(
      scale: isSelected ? 1.00 : 0.9,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor),
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: CircleAvatar(
                key: ValueKey<bool>(isSelected),
                radius: 22,
                backgroundColor: backgroundColor,
                child: Icon(
                  isSelected ? Icons.check : icon,  // zmiana ikony jeśli wybrane
                  color: iconColor,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


class UserAvatar extends StatelessWidget {
  final String name;
  final bool isSelected;

  const UserAvatar({
    required this.name,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableIconCard(
      name: name,
      icon: Icons.person,
      isSelected: isSelected,
    );
  }
}

class GymCard extends StatelessWidget {
  final String name;
  final bool isSelected;

  const GymCard({
    required this.name,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableIconCard(
      name: name,
      icon: Icons.fitness_center,
      isSelected: isSelected,
    );
  }
}
