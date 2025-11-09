import 'package:GoGymSimple/util/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../provider/color_provider.dart';
import '../../../l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final t = AppLocalizations.of(context)!;
    final colorProvider = Provider.of<ColorProvider>(context);
    final currentLang = settingsProvider.getAppLocaleCode;

    return Scaffold(
      backgroundColor: colorProvider.primary,
      appBar: CustomAppBar(
        title: t.settings_language,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorProvider.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  t.settings_availableLanguages,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorProvider.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _languageTile(
                context,
                languageCode: 'pl',
                originalLabel: 'Polski',
                translatedLabel: t.settings_polish,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('pl'),
              ),
              _languageTile(
                context,
                languageCode: 'en',
                originalLabel: 'English',
                translatedLabel: t.settings_english,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('en'),
              ),
              /*_languageTile(
                context,
                languageCode: 'es-ES',
                originalLabel: 'Español (España)',
                translatedLabel: t.settings_spanish_spain,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('es-ES'),
              ),
              _languageTile(
                context,
                languageCode: 'es-CO',
                originalLabel: 'Español (Colombia)',
                translatedLabel: t.settings_spanish_colombia,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('es-CO'),
              ),*/
              _languageTile(
                context,
                languageCode: 'nl',
                originalLabel: 'Nederlands',
                translatedLabel: t.settings_dutch,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('nl'),
              ),
              /*_languageTile(
                context,
                languageCode: 'it',
                originalLabel: 'Italiano',
                translatedLabel: t.settings_italian,
                currentLang: currentLang,
                colorProvider: colorProvider,
                onTap: () => settingsProvider.changeLanguage('it'),
              ),*/
              Divider(color: colorProvider.accent.withOpacity(0.3)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorProvider.secondary.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  t.settings_otherLanguages,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorProvider.accent.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _disabledLanguageTile(t.settings_spanish_colombia, colorProvider),
              _disabledLanguageTile(t.settings_spanish_spain, colorProvider),
              _disabledLanguageTile(t.settings_italian, colorProvider),
              _disabledLanguageTile(t.settings_german, colorProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageTile(
    BuildContext context, {
    required String languageCode,
    required String originalLabel,
    required String translatedLabel,
    required String currentLang,
    required ColorProvider colorProvider,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorProvider.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorProvider.secondary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                originalLabel,
                style: TextStyle(
                  color: colorProvider.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '($translatedLabel)',
                style: TextStyle(
                  color: colorProvider.accent.withOpacity(0.7),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        trailing: Radio<String>(
          value: languageCode,
          groupValue: currentLang,
          activeColor: colorProvider.accent,
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return colorProvider.accent;
            }
            return colorProvider.accent.withOpacity(0.7);
          }),
          onChanged: (_) => onTap(),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _disabledLanguageTile(String label, ColorProvider colorProvider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colorProvider.secondary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        value: '',
        groupValue: '',
        onChanged: null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          label,
          style: TextStyle(
            color: colorProvider.accent.withOpacity(0.4),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
