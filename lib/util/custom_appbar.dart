import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/color_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
  });

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();

    return AppBar(
      backgroundColor: cp.secondary,
      foregroundColor: cp.accent,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shadowColor: cp.accent.withOpacity(0.1),
      centerTitle: true,
      leading: leading,
      actions: actions,
      bottom: bottom,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontFamily: 'BarlowSemiCondensed',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
