import 'package:flutter/material.dart';

class AppPalette {
  // Основные цвета приложения
  static const Color primary = Color(0xFF6B1D1D); // Тёмно-красный (кнопка, заголовки)
  static const Color background = Colors.white;
  static const Color accent = Color(0xFFFFD700); // Золотой (для выделения)

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
}
