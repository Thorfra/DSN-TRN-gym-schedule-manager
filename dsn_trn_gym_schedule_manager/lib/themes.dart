import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  Color lightPrimaryColor = const Color.fromARGB(255, 20, 70, 115);
  Color darkPrimaryColor = const Color.fromARGB(255, 20, 70, 115);
  Color secondaryColor = const Color.fromARGB(255, 32, 82, 149);
  Color accentColor = const Color.fromARGB(255, 44, 116, 179);

  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.bebasNeue().fontFamily,
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white),
    colorScheme: const ColorScheme.light().copyWith(
        primary: tema.lightPrimaryColor, secondary: tema.secondaryColor),
  );

  static ThemeData darkTheme = ThemeData(
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: tema.secondaryColor, foregroundColor: Colors.black),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: tema.darkPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: tema.darkPrimaryColor,
          foregroundColor: Colors.black));
}

ThemeClass tema = ThemeClass();
