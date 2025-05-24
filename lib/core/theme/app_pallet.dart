import 'package:flutter/material.dart';

class AppPalette {
  // Основные цвета приложения
  static const Color primary =
      Color(0xFF6B1D1D); // Тёмно-красный (кнопка, заголовки)
  static const Color background = Colors.white;
  static const Color accent = Color(0xFFFFD700);

  static const Color chartBar = Color(0xFF8B5E3C); // Коричневый для графика
  static const Color chartBackground =
      Color(0xFFF5F2F0); // Светлый фон// Золотой (для выделения)

  // Цвета текста
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF666666);
  static const Color hintText = Color(0xFF9E9E9E);

  // Цвета ошибок
  static const Color error = Colors.red;

  // Цвета иконок
  static const Color iconColor = Color(0xFF6B1D1D);

  // Навигационное меню
  static const Color navBarBackground = Colors.white;
  static const Color navBarSelected = Color(0xFF6B1D1D);
  static const Color navBarUnselected = Color(0xFFBDBDBD);

  // Цвет карточек/элементов в Home/Characters
  static const Color cardBackground = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFE0E0E0);

  // Профиль / Статистика
  static const Color chartLine = Color(0xFFEF5350);
  static const Color achievement = Color(0xFF4CAF50);

  // Цвета для полей ввода
  static const Color inputFill = Color(0xFFF1F1F1);
  static const Color inputFocusedBorder = primary;
  static const Color inputErrorBorder = error;

  // Lesson card colors - Light mode
  static const Color lessonCardCompletedLight =
      Color(0xFFE3F2FD); // Light blue background
  static const Color lessonCardTextLight =
      Color(0xFF1565C0); // Darker blue for text
  static const Color lessonCardDefaultLight = Colors.white;

  // Lesson card colors - Dark mode
  static const Color lessonCardCompletedDark = Color(0xFF0D47A1); // Deep blue
  static const Color lessonCardTextDark = Color(0xFF90CAF9); // Light blue text
  static const Color lessonCardDefaultDark = Color(0xFF2D2D2D);

  // Error quiz card colors - Light mode
  static const Color errorCardLight =
      Color(0xFFFFF3E0); // Light orange background
  static const Color errorTextLight = Color(0xFFE65100); // Deep orange text

  // Error quiz card colors - Dark mode
  static const Color errorCardDark = Color(0xFF3E2723); // Deep brown
  static const Color errorTextDark = Color(0xFFFFB74D); // Light orange text

  // Chart colors - Light mode
  static const Color chartBackgroundLight = Color(0xFFF5F5F5);
  static const Color chartBarLight = Color(0xFF8B5E3C);
  static const Color chartBorderLight = Color(0xFFE0E0E0);
  static const Color chartTextLight = Color(0xFF424242);

  // Chart colors - Dark mode
  static const Color chartBackgroundDark = Color(0xFF2D2D2D);
  static const Color chartBarDark =
      Color(0xFFFFB74D); // Warm orange for better visibility
  static const Color chartBorderDark = Color(0xFF424242);
  static const Color chartTextDark = Color(0xFFE0E0E0);

  // Progress indicator colors - Light mode
  static const Color progressIndicatorLight =
      Color(0xFF6B1D1D); // Keep current primary color
  static const Color progressBackgroundLight =
      Color(0xFFE0E0E0); // Light gray background
  static const Color progressTextLight =
      Color(0xFF424242); // Dark text for contrast

  // Progress indicator colors - Dark mode
  static const Color progressIndicatorDark =
      Color(0xFFFFD700); // Yellow accent color
  static const Color progressBackgroundDark =
      Color(0xFF424242); // Dark gray background
  static const Color progressTextDark =
      Color(0xFFE0E0E0); // Light text for contrast
}
