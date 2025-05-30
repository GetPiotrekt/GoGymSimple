import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import 'donate_sections.dart';

class Donate extends StatelessWidget {
  const Donate({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cp.primary,
      appBar: CustomAppBar(
        title: t.donate_title
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          DonateTopSections(),
        ],
      ),
    );
  }
}

class DonateShared extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const DonateShared({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    required this.colorProvider,
  });

  final ColorProvider colorProvider;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    color: colorProvider.secondary,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: colorProvider.accent),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorProvider.accent,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    ),
  );
}
