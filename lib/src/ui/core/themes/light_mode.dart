import 'package:estatehub_app/src/ui/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

ThemeData get lightMode {
  const surface = Color(0xFFF5F5F7);
  const card = Color(0xFFFFFFFF);
  const textPrimary = Color(0xFF1D1D1F);
  const textSecondary = Color(0xFF86868B);
  const divider = Color(0xFFE5E5EA);
  const greenDark = Color(0xFF6B8E23);
  final greenDarkBackground = Color(0xFF6B8E23).withValues(alpha: 0.125);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: surface,
    colorScheme: ColorScheme.light(
      surface: surface,
      primary: textSecondary,
      onPrimary: Color(0xFF3A3A3C),
      secondary: card,
      onSecondary: Colors.black,
      tertiary: greenDark,
      inversePrimary: textPrimary,
      outline: divider,
      shadow: Color(0x1A000000),
      error: Colors.red.shade700,
    ),
    splashFactory: InkSparkle.splashFactory,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: card,
      foregroundColor: textPrimary,
      centerTitle: false,
    ),
    dividerColor: divider,
    cardTheme: CardThemeData(
      elevation: 0,
      color: card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: greenDarkBackground,
      foregroundColor: greenDark,
      elevation: 2,
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
      selectedItemColor: Color(0xFF3A3A3C),
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
