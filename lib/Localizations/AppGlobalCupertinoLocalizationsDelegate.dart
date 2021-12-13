import 'package:fixtures/Localizations/AppCupertinoLocalizations.dart';
import 'package:flutter/cupertino.dart';

class AppGlobalCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) =>
      DefaultCupertinoLocalizations.delegate.isSupported(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    var localization =
        await DefaultCupertinoLocalizations.delegate.load(locale);
    return AppCupertinoLocalizations(localization);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<CupertinoLocalizations> old) =>
      DefaultCupertinoLocalizations.delegate.shouldReload(old);
}
