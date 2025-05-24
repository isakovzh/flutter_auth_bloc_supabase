import 'package:app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      secondary: AppPalette.chartBarLight,
      surface: AppPalette.chartBackgroundLight,
      onSurface: AppPalette.chartTextLight,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.brown.shade700, fontSize: 12),
      titleMedium: const TextStyle(
          color: AppPalette.primary, fontWeight: FontWeight.bold),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppPalette.background,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPalette.progressIndicatorLight,
      linearTrackColor: AppPalette.progressBackgroundLight,
    ),
    cardTheme: CardTheme(
      color: AppPalette.lessonCardDefaultLight,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    extensions: const [
      CustomColors(
        lessonCardCompleted: AppPalette.lessonCardCompletedLight,
        lessonCardText: AppPalette.lessonCardTextLight,
        errorCard: AppPalette.errorCardLight,
        errorText: AppPalette.errorTextLight,
      ),
      ChartColors(
        background: AppPalette.chartBackgroundLight,
        bar: AppPalette.chartBarLight,
        border: AppPalette.chartBorderLight,
        text: AppPalette.chartTextLight,
        progressBackground: AppPalette.progressBackgroundLight,
        progressBar: AppPalette.progressIndicatorLight,
      ),
    ],
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
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      brightness: Brightness.dark,
      secondary: AppPalette.chartBarDark,
      surface: AppPalette.chartBackgroundDark,
      onSurface: AppPalette.chartTextDark,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white70, fontSize: 12),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppPalette.progressIndicatorDark,
      linearTrackColor: AppPalette.progressBackgroundDark,
    ),
    cardTheme: CardTheme(
      color: AppPalette.lessonCardDefaultDark,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    extensions: const [
      CustomColors(
        lessonCardCompleted: AppPalette.lessonCardCompletedDark,
        lessonCardText: AppPalette.lessonCardTextDark,
        errorCard: AppPalette.errorCardDark,
        errorText: AppPalette.errorTextDark,
      ),
      ChartColors(
        background: AppPalette.chartBackgroundDark,
        bar: AppPalette.chartBarDark,
        border: AppPalette.chartBorderDark,
        text: AppPalette.chartTextDark,
        progressBackground: AppPalette.progressBackgroundDark,
        progressBar: AppPalette.progressIndicatorDark,
      ),
    ],
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800,
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
        borderSide: const BorderSide(color: AppPalette.accent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: AppPalette.error, width: 2),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: AppPalette.accent,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.accent,
        foregroundColor: Colors.black,
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

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.lessonCardCompleted,
    required this.lessonCardText,
    required this.errorCard,
    required this.errorText,
  });

  final Color lessonCardCompleted;
  final Color lessonCardText;
  final Color errorCard;
  final Color errorText;

  @override
  CustomColors copyWith({
    Color? lessonCardCompleted,
    Color? lessonCardText,
    Color? errorCard,
    Color? errorText,
  }) {
    return CustomColors(
      lessonCardCompleted: lessonCardCompleted ?? this.lessonCardCompleted,
      lessonCardText: lessonCardText ?? this.lessonCardText,
      errorCard: errorCard ?? this.errorCard,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      lessonCardCompleted:
          Color.lerp(lessonCardCompleted, other.lessonCardCompleted, t)!,
      lessonCardText: Color.lerp(lessonCardText, other.lessonCardText, t)!,
      errorCard: Color.lerp(errorCard, other.errorCard, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
    );
  }
}

@immutable
class ChartColors extends ThemeExtension<ChartColors> {
  const ChartColors({
    required this.background,
    required this.bar,
    required this.border,
    required this.text,
    required this.progressBackground,
    required this.progressBar,
  });

  final Color background;
  final Color bar;
  final Color border;
  final Color text;
  final Color progressBackground;
  final Color progressBar;

  @override
  ChartColors copyWith({
    Color? background,
    Color? bar,
    Color? border,
    Color? text,
    Color? progressBackground,
    Color? progressBar,
  }) {
    return ChartColors(
      background: background ?? this.background,
      bar: bar ?? this.bar,
      border: border ?? this.border,
      text: text ?? this.text,
      progressBackground: progressBackground ?? this.progressBackground,
      progressBar: progressBar ?? this.progressBar,
    );
  }

  @override
  ChartColors lerp(ChartColors? other, double t) {
    if (other is! ChartColors) {
      return this;
    }
    return ChartColors(
      background: Color.lerp(background, other.background, t)!,
      bar: Color.lerp(bar, other.bar, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      progressBackground:
          Color.lerp(progressBackground, other.progressBackground, t)!,
      progressBar: Color.lerp(progressBar, other.progressBar, t)!,
    );
  }
}
