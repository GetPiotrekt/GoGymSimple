import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../util/bottom_sheet/bottom_sheet.dart';

class IconSelection extends StatelessWidget {
  final void Function(String) onIconSelected;

  IconSelection({
    super.key,
    required this.onIconSelected,
  });

  final iconData = [
    {'icon': 'assets/icons/default.png'},
    {'icon': 'assets/icons/barbell.png'},
    {'icon': 'assets/icons/cardio.png'},
    {'icon': 'assets/icons/dumbbell.png'},
    {'icon': 'assets/icons/bodyweight.png'},
    {'icon': 'assets/icons/machine.png'},
    {'icon': 'assets/icons/plate.png'},
    {'icon': 'assets/icons/kettle.png'},
    {'icon': 'assets/icons/cable.png'}
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // Localized text
    final colorProvider = Provider.of<ColorProvider>(context);

    return BottomSheetTemplate(
      onPressed: () {
        Navigator.pop(context); // Zamknięcie dolnego arkusza po kliknięciu przycisku
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.iconSelection_chooseIcon, // Tłumaczenie dla tekstu
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorProvider.accent,
            ),
          ),
          const SizedBox(height: 12),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: iconData
                .map((icon) => _buildIconOption(context, icon, colorProvider))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIconOption(BuildContext context, Map<String, String> icon, ColorProvider colorProvider) {
    return GestureDetector(
      onTap: () {
        onIconSelected(icon['icon']!);
        Navigator.pop(context); // Zamknięcie bottom sheet po wyborze ikony
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: colorProvider.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon['icon']!,
                width: 50,
                height: 50,
                color: colorProvider.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
