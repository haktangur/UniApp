import 'package:flutter/material.dart';

class PixelTheme {
  // Renkler
  static const Color background = Color(0xFF0D0D0D);
  static const Color primary = Color(0xFF00FF94);
  static const Color secondary = Color(0xFF00BFFF);
  static const Color accent = Color(0xFFFFD700);
  static const Color danger = Color(0xFFFF4444);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFAAAAAA);
  static const Color cardBackground = Color(0xFF1A1A1A);
  static const Color border = Color(0xFF333333);

  // Tema
  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Courier',
    colorScheme: const ColorScheme.dark(primary: primary, secondary: secondary),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16, letterSpacing: 1),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 14,
        letterSpacing: 1,
      ),
    ),
  );
}
