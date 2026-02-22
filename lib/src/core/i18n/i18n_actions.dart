import 'package:estatehub_app/src/core/app/estatehub_app.dart';
import 'package:flutter/material.dart';

const kSupportedLocales = <Locale>[
  Locale('pt', 'BR'),
  Locale('pt'),
  Locale('es'),
  Locale('en'),
];

String localeLabel(Locale l) {
  if (l.languageCode == 'pt' && l.countryCode == 'BR') {
    return 'Português (Brasil)';
  }
  if (l.languageCode == 'pt') return 'Português';
  if (l.languageCode == 'es') return 'Español';
  return 'English';
}

void setAppLocale(BuildContext context, Locale locale) {
  EstateHubApp.setLocale(context, locale);
}

void cycleLocale(BuildContext context) {
  final current = Localizations.localeOf(context);
  int idx = kSupportedLocales.indexWhere(
    (l) =>
        l.languageCode == current.languageCode &&
        (l.countryCode ?? '') == (current.countryCode ?? ''),
  );
  if (idx == -1) {
    idx = kSupportedLocales.indexWhere(
      (l) => l.languageCode == current.languageCode,
    );
  }
  final next = kSupportedLocales[(idx + 1) % kSupportedLocales.length];
  setAppLocale(context, next);
}

extension I18nContextX on BuildContext {
  void setLocale(Locale locale) => setAppLocale(this, locale);
}
