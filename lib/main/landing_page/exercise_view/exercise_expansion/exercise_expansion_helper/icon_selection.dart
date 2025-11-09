/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../provider/color_provider.dart';
import '../../../../../util/bottom_sheet/bottom_sheet.dart';

class IconSelection extends StatelessWidget {
  final void Function(IconData) onIconSelected;

  IconSelection({
    super.key,
    required this.onIconSelected,
  });

  // Lista ikon łącząca sportowe i symboliczne
  final List<IconData> iconList = [
    // 🔰 Uniwersalne i symboliczne
    Icons.star_border_outlined,
    Icons.align_vertical_bottom_rounded,
    Icons.local_play_outlined,
    Icons.gamepad_outlined,
    Icons.offline_bolt_outlined,

    // ❤️ Emocje, stan i wartości
    Icons.star_border_outlined,
    Icons.favorite_border_outlined,
    Icons.sentiment_very_dissatisfied, // zamiast czaszki
    Icons.whatshot_outlined,
    Icons.no_adult_content_outlined,
    Icons.sign_language_outlined,

    // 🧭 Funkcjonalne i systemowe
    Icons.notifications_outlined,
    Icons.push_pin_outlined,
    Icons.access_time_outlined,
    Icons.warning_amber,
    Icons.lock_outlined,
    Icons.flag_outlined,
    Icons.security_outlined,

    // 📚 Informacyjne i edukacyjne
    Icons.book_outlined,
    Icons.help_center_outlined,

    // 🛠️ Techniczne i narzędziowe
    Icons.handyman_outlined,
    Icons.adjust_outlined,
    Icons.cable_outlined,
    Icons.device_hub_outlined,
    Icons.build_outlined,
    Icons.lightbulb_outlined,
    Icons.analytics_outlined,

    // 🏃‍♂️ Sportowe i ruchowe
    Icons.directions_run_outlined,
    Icons.directions_walk_outlined,
    Icons.sports_gymnastics_outlined,
    Icons.accessibility_new_outlined,
    Icons.self_improvement_outlined,
    Icons.sports_martial_arts_outlined,
    Icons.sports_kabaddi_outlined,
    Icons.sports_baseball_outlined,
    Icons.sports_basketball_outlined,
    Icons.sports_volleyball_outlined,
    Icons.sports_soccer_outlined,
    Icons.sports_mma_outlined,
    Icons.roller_skating_outlined,
  ];


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);

    return BottomSheetTemplate(
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.iconSelection_chooseIcon,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorProvider.accent,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: iconList.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _buildIconBox(
                context,
                iconList[index],
                colorProvider,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconBox(BuildContext context, IconData icon, ColorProvider colorProvider) {
    return GestureDetector(
      onTap: () {
        onIconSelected(icon);
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorProvider.accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 36,
            color: colorProvider.accent,
          ),
        ),
      ),
    );
  }
}*/

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
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);

    return BottomSheetTemplate(
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.iconSelection_chooseIcon,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorProvider.accent,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: iconData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // dwa wiersze
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5, // szerokość do wysokości kontenera
            ),
            itemBuilder: (context, index) {
              final icon = iconData[index];
              return _buildIconOption(context, icon, colorProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconOption(
      BuildContext context, Map<String, String> icon, ColorProvider colorProvider) {
    return GestureDetector(
      onTap: () {
        onIconSelected(icon['icon']!);
        Navigator.pop(context);
      },
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
    );
  }
}