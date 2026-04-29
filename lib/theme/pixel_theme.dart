import 'package:flutter/material.dart';

class PixelTheme {
  static const Color background = Color(0xFF0D0D0D);
  static const Color primary = Color(0xFF00FF94);
  static const Color secondary = Color(0xFF00BFFF);
  static const Color accent = Color(0xFFFFD700);
  static const Color danger = Color(0xFFFF4444);
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFF888888);
  static const Color cardBackground = Color(0xFF141414);
  static const Color border = Color(0xFF2A2A2A);

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Courier',
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: cardBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Courier',
        color: primary,
        fontSize: 14,
        letterSpacing: 2,
      ),
      iconTheme: IconThemeData(color: primary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: background,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Courier',
        fontSize: 10,
        letterSpacing: 1,
      ),
      unselectedLabelStyle: TextStyle(fontFamily: 'Courier', fontSize: 10),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      bodyLarge: TextStyle(color: textPrimary, fontSize: 14, letterSpacing: 1),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 12,
        letterSpacing: 1,
      ),
    ),
  );
}
