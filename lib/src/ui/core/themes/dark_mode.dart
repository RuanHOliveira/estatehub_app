import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

ThemeData get darkMode {
  const surface = Color(0xFF121212);
  const card = Color(0xFF1A1A1A);
  const textPrimary = Color(0xFFE6E6E6);
  const textSecondary = Color(0xFF9A9A9A);
  const divider = Color(0xFF2E2E2E);
  const greenDark = Color(0xFF6B8E23);
  final greenDarkBackground = Color(0xFF6B8E23).withValues(alpha: 0.125);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: surface,
    colorScheme: ColorScheme.dark(
      surface: surface,
      primary: textSecondary,
      onPrimary: Color(0xFFE0E0E0),
      secondary: card,
      onSecondary: Colors.white,
      tertiary: greenDark,
      inversePrimary: textPrimary,
      outline: divider,
      shadow: Color(0x33000000),
      surfaceTint: Colors.transparent,
      error: Colors.red.shade700,
    ),
    splashFactory: InkSparkle.splashFactory,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: card,
      foregroundColor: textPrimary,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
    dividerColor: divider,
    cardTheme: CardThemeData(
      elevation: 0,
      color: card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      surfaceTintColor: Colors.transparent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: greenDarkBackground,
      foregroundColor: greenDark,
      elevation: 2,
    ),
    iconTheme: const IconThemeData(color: textSecondary),
    dialogTheme: const DialogThemeData(
      backgroundColor: card,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: card,
      modalBackgroundColor: card,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: textSecondary,
      textColor: textPrimary,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: const TextStyle(color: card),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFFE0E0E0),
      unselectedLabelStyle: AppTextStyles.text12.copyWith(letterSpacing: -0.5),
      selectedLabelStyle: AppTextStyles.textBold12.copyWith(
        letterSpacing: -0.5,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}
