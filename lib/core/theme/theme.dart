import 'package:app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
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
  );
}
