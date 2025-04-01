import 'package:app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      secondary: AppPalette.chartBar,
      surface: AppPalette.chartBackground,
      onSurface: Colors.brown.shade700,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.brown.shade700, fontSize: 12),
      titleMedium:
          const TextStyle(color: AppPalette.primary, fontWeight: FontWeight.bold),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.inputFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
            const BorderSide(color: AppPalette.inputFocusedBorder, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
            const BorderSide(color: AppPalette.inputErrorBorder, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide:
            const BorderSide(color: AppPalette.inputErrorBorder, width: 2),
      ),
      hintStyle: const TextStyle(color: AppPalette.hintText),
      labelStyle: const TextStyle(color: AppPalette.textPrimary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.inputFocusedBorder,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      toolbarTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPalette.background, // или AppPalette.background
      selectedItemColor: AppPalette.inputFocusedBorder,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.inputFocusedBorder,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
