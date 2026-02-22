import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';
import 'package:estatehub_app/src/config/l10n/lucid_localization_delegate.dart';
import 'package:estatehub_app/src/routing/router.dart';
import 'package:estatehub_app/src/ui/core/themes/dark_mode.dart';
import 'package:estatehub_app/src/ui/core/themes/light_mode.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class EstateHubApp extends StatefulWidget {
  const EstateHubApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _EstateHubAppState? state = context
        .findAncestorStateOfType<_EstateHubAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<EstateHubApp> createState() => _EstateHubAppState();
}

class _EstateHubAppState extends State<EstateHubApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: [
        LucidLocalizationDelegate.delegate,
        ...AppLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      localeResolutionCallback:
          (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale?.languageCode &&
                  locale.countryCode == deviceLocale?.countryCode) {
                return locale;
              }
            }

            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale?.languageCode) {
                return locale;
              }
            }

            return const Locale('en');
          },

      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      onGenerateTitle: (ctx) => 'EstateHub',
      builder: BotToastInit(),
      routerConfig: router,
    );
  }
}
