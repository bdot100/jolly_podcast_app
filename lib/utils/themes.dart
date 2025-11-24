import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
    primaryColor: Color(0xFF6200EE),
    cardColor: Colors.white,
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFF03DAC6),
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
      error: Color(0xFFB00020),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.outfit(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF6200EE),
      unselectedItemColor: Colors.grey,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF051814),
    primaryColor: Color(0xFFB5E63B),
    cardColor: Color(0xFF0F2922),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFB5E63B),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF0F2922),
      background: Color(0xFF051814),
      error: Color(0xFFCF6679),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF051814),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.outfit(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF051814),
      selectedItemColor: Color(0xFFB5E63B),
      unselectedItemColor: Colors.grey,
    ),
  );
}
