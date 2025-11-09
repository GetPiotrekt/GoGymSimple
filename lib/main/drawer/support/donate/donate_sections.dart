import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
import 'donate_monthly_section.dart';
import 'donate_one_time_section.dart';
import 'donate.dart';

class DonateTopSections extends StatelessWidget {
  const DonateTopSections({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<ColorProvider>();

    return Column(
      children: [
        _buildWhy(context, cp),
        const SizedBox(height: 16),
        const DonateMonthlySection(),
        const SizedBox(height: 16),
        const DonateOneTimeSection(),
        const SizedBox(height: 16),
        _buildVoluntary(context, cp),
      ],
    );
  }

  Widget _buildWhy(BuildContext context, ColorProvider cp) => DonateShared(
    icon: Icons.favorite,
    title: AppLocalizations.of(context)!.donateSections_whyTitle,
    colorProvider: cp,
    child: Text(
      AppLocalizations.of(context)!.donateSections_whyDesc,
      style: TextStyle(color: cp.accent.withOpacity(0.7)),
    ),
  );


  Widget _buildVoluntary(BuildContext context, ColorProvider cp) =>
      DonateShared(
        icon: Icons.info_outline,
        title: AppLocalizations.of(context)!.donateSections_voluntaryTitle,
        colorProvider: cp,
        child: Text(
          AppLocalizations.of(context)!.donateSections_voluntaryDesc,
          style: TextStyle(color: cp.accent.withOpacity(0.7)),
        ),
      );
}
