import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../provider/color_provider.dart';
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
        _buildSub(context, cp),
        const SizedBox(height: 16),
        _buildOneTime(context, cp),
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

  Widget _buildSub(BuildContext context, ColorProvider c) {
    int? selectedAmount;

    return StatefulBuilder(
      builder: (context, setState) {
        return DonateShared(
          icon: Icons.calendar_today,
          title: AppLocalizations.of(context)!.donateSections_monthlyTitle,
          colorProvider: c,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.donateSections_monthlyDesc,
                style: TextStyle(color: c.accent.withOpacity(0.7)),
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.8,
                children: [1, 2, 5, 10, 25, 50].map((amount) {
                  return _amountChip(
                    context,
                    amount,
                    selected: selectedAmount == amount,
                    onSelected: () {
                      setState(() {
                        selectedAmount = selectedAmount == amount ? null : amount;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: selectedAmount != null ? 1.0 : 0.5,
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Obsługa płatności
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.accent,
                      foregroundColor: c.secondary,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.donateSections_monthlyButton,
                      style: TextStyle(color: c.secondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildOneTime(BuildContext context, ColorProvider c) {
    int? selectedAmount;

    return StatefulBuilder(
      builder: (context, setState) {
        return DonateShared(
          icon: Icons.attach_money,
          title: AppLocalizations.of(context)!.donateSections_oneTimeTitle,
          colorProvider: c,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.donateSections_oneTimeDesc,
                style: TextStyle(color: c.accent.withOpacity(0.7)),
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.8,
                children: [1, 2, 5, 10, 25, 50].map((amount) {
                  return _amountChip(
                    context,
                    amount,
                    selected: selectedAmount == amount,
                    onSelected: () {
                      setState(() {
                        selectedAmount = selectedAmount == amount ? null : amount;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.maxFinite,
                child: Opacity(
                  opacity: selectedAmount != null ? 1.0 : 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Obsługa płatności
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.accent,
                      foregroundColor: c.secondary,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.donateSections_oneTimeButton,
                      style: TextStyle(color: c.secondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _amountChip(
      BuildContext context,
      int amount, {
        required bool selected,
        required VoidCallback onSelected,
      }) {
    final cp = context.read<ColorProvider>();

    return SizedBox(
      width: 95,
      height: 36,
      child: FilterChip(
        label: Center(child: Text('\$$amount')),
        selected: selected,
        onSelected: (_) => onSelected(),
        checkmarkColor: cp.secondary,
        selectedColor: cp.accent,
        backgroundColor: cp.secondary,
        side: BorderSide(color: cp.accent.withOpacity(0.5), width: 1.5),
        labelStyle: TextStyle(
          color: selected ? cp.secondary : cp.accent.withOpacity(0.5),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
      ),
    );
  }


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
