import 'dart:async';

import 'package:estatehub_app/src/config/providers/app_providers.dart';
import 'package:estatehub_app/src/core/app/estatehub_app.dart';
import 'package:estatehub_app/src/utils/validators/lucid_custom_language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lucid_validation/lucid_validation.dart';
import 'package:provider/provider.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env");

    LucidValidation.global.languageManager = CustomLanguageManager();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(
      MultiProvider(providers: buildAppProviders(), child: EstateHubApp()),
    );
  }, (error, stack) async {});
}
