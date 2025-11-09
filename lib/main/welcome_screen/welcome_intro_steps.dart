import 'package:flutter/material.dart';

import '../../data/data_tab_sector/user_data/user_db.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/color_provider.dart';
import '../../util/button_icon.dart';
import '../../util/input_form_field/input_form_field.dart';

class WelcomeIntroSteps {
  static Widget stepLogoIntro({
    required BuildContext context,
    required ColorProvider cp,
    required VoidCallback onNext,
    required String selectedLanguage,
    required void Function(String) onLanguageChanged,
  }) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cp.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8), // miejsce po ikonie
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: cp.accent.withOpacity(0.1),
                    child: ClipOval(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(cp.accent, BlendMode.srcATop),
                        child: Image.asset(
                          'assets/icons/logo_bl.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                    child: Text(
                      t.welcomeIntroSteps_welcomeTitle,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: cp.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.welcomeIntroSteps_welcomeSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cp.accent.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.maxFinite,
                    child: ButtonIcon(
                      onPressed: onNext,
                      iconData: Icons.arrow_forward,
                      labelText: t.welcomeIntroSteps_getStartedButton,
                      backgroundColor: cp.accent.withOpacity(0.1),
                      textColor: cp.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget stepUsername({
    required BuildContext context,
    required ColorProvider cp,
    required TextEditingController usernameController,
    required String enteredUsername,
    required Function(String) onChanged,
    required VoidCallback onNext,
  }) {
    final t = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: cp.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.welcomeIntroSteps_personalInfoTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22,
                  color: cp.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              InputFormField(
                labelText: t.welcomeIntroSteps_yourNameLabel,
                controller: usernameController,
                keyboardType: TextInputType.text,
                fontSize: 18,
                enabled: true,
                onChanged: (val) => onChanged(val as String),
              ),
              if (enteredUsername.trim().isNotEmpty)
                const SizedBox(height: 20),
              if (enteredUsername.trim().isNotEmpty)
                SizedBox(
                  width: double.maxFinite,
                  child: ButtonIcon(
                    onPressed: () async {
                      final trimmedUsername = enteredUsername.trim();
                      if (trimmedUsername.isNotEmpty) {
                        await UserBox.addUser(trimmedUsername);
                        onNext();
                      }
                    },
                    iconData: Icons.arrow_forward,
                    labelText: t.welcomeIntroSteps_nextButton,
                    backgroundColor: cp.accent.withOpacity(0.1),
                    textColor: cp.accent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}
