import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          //0A1931  // white yellow 0xFFFCF8EC
          isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
        secondary:
            isDarkTheme ? const Color(0xFF1a1f3c) : const Color(0xFFE9FCFC),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      cardColor:
          isDarkTheme ? const Color(0xFF0a0d2c) : const Color(0xFFF2FDFD),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme:
            isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
      ),

      // ✅ Add this
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
