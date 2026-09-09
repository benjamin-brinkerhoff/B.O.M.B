import 'package:flutter/material.dart';

/// App theme definitions tailored for clean, high-contrast scripture reading.
class AppTheme {
  // Light palette: Warm parchment reading tone
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6B4C2C), // Warm rich cedar/amber
      brightness: Brightness.light,
      surface: const Color(0xFFFAF8F5),   // Soft warm background
    ),
    scaffoldBackgroundColor: const Color(0xFFFAF8F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFAF8F5),
      elevation: 0,
      centerTitle: false,
    ),
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: Color(0xFFF3EEE7),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFFF3EEE7),
    ),
  );

  // Dark palette: Deep slate for comfortable nighttime study
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFD4A373),
      brightness: Brightness.dark,
      surface: const Color(0xFF1E1F22),
    ),
    scaffoldBackgroundColor: const Color(0xFF141517),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF141517),
      elevation: 0,
      centerTitle: false,
    ),
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: Color(0xFF1E1F22),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Color(0xFF1E1F22),
    ),
  );
}
