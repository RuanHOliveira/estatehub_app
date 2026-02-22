import 'package:estatehub_app/src/routing/routes.dart';
import 'package:estatehub_app/src/ui/features/auth/login/ui/login_screen.dart';
import 'package:estatehub_app/src/ui/features/auth/login/ui/login_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/auth/register/ui/register_screen.dart';
import 'package:estatehub_app/src/ui/features/auth/register/ui/register_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/main/ui/main_navigation.dart';
import 'package:estatehub_app/src/ui/features/main/ui/main_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/property_ads/ui/create_property_ad_screen.dart';
import 'package:estatehub_app/src/ui/features/property_ads/ui/create_property_ad_viewmodel.dart';
import 'package:estatehub_app/src/ui/features/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen(loginViewModel: context.read<LoginViewModel>());
      },
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) {
        return RegisterScreen(
          registerViewModel: context.read<RegisterViewModel>(),
        );
      },
    ),
    GoRoute(
      path: Routes.mainNavigation,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final refreshHome = extra?['refreshHome'] as bool? ?? true;
        return MainNavigation(
          mainViewmodel: context.read<MainViewModel>(),
          refreshHomeOnInit: refreshHome,
        );
      },
    ),
    GoRoute(
      path: Routes.createPropertyAd,
      builder: (context, state) {
        return CreatePropertyAdScreen(
          createPropertyAdViewModel: context.read<CreatePropertyAdViewModel>(),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(body: Center(child: Text('Erro de rota: ${state.error}'))),
  ),
);
