import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data/config_db.dart';

class SettingsProvider with ChangeNotifier {
  bool _elementVisibility = true;
  Locale _appLocale = const Locale('en');  // Default language
  String _units = 'metric';

  bool get getElementVisibility => _elementVisibility;
  Locale get getAppLocale => _appLocale;
  String get getUnits => _units;

  Future<void> loadSettings() async {

    final timeShow = ConfigBox.getConfig('timeShow') ?? 'true';
    final lang = ConfigBox.getConfig('language') ?? 'en';
    if (lang.contains('-')) {
      final parts = lang.split('-');
      _appLocale = Locale(parts[0], parts[1]);
    } else {
      _appLocale = Locale(lang);
    }
    final units = ConfigBox.getConfig('units') ?? 'metric';

    _elementVisibility = timeShow == 'true';
    _units = units;

    notifyListeners();
  }

  void toggleElementVisibility() {
    _elementVisibility = !_elementVisibility;
    ConfigBox.updateConfig('timeShow', _elementVisibility.toString());
    notifyListeners();
  }

  void changeLanguage(String languageCode) {
    if (languageCode.contains('-')) {
      final parts = languageCode.split('-');
      _appLocale = Locale(parts[0], parts[1]);
    } else {
      _appLocale = Locale(languageCode);
    }
    ConfigBox.updateConfig('language', languageCode);
    notifyListeners();
  }

  void changeUnits(String units) {
    _units = units;
    ConfigBox.updateConfig('units', units);
    notifyListeners();
  }

  // Metoda do ustawiania lokalizacji z bazy danych
  Future<void> setAppLocaleFromDatabase() async {
    // Pobierz ustawienie języka z bazy danych (np. ConfigBox)
    final localeCode = await ConfigBox.getLocaleCode();  // Zastąp odpowiednią metodą pobierania z bazy
    if (localeCode != null) {
      if (localeCode.contains('-')) {
        final parts = localeCode.split('-');
        _appLocale = Locale(parts[0], parts[1]);
      } else {
        _appLocale = Locale(localeCode);
      }
    } else {
      _appLocale = const Locale('en');
    }

    notifyListeners();
  }

  // Metoda do zmiany języka w aplikacji
  void setAppLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }

  String get getAppLocaleCode {
    if (_appLocale.countryCode != null && _appLocale.countryCode!.isNotEmpty) {
      return '${_appLocale.languageCode}-${_appLocale.countryCode}';
    } else {
      return _appLocale.languageCode;
    }
  }
}
