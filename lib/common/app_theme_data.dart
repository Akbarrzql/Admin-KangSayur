import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_value.dart';

class AppThemeData {
  static ThemeData getThemeLight() {
    const Color primaryColor = ColorValue.primaryColor;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
    MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: GoogleFonts.nunitoSans(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorValue.primaryColor,
          minimumSize: const Size(double.infinity, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.nunitoSans(
          fontSize: 24,
        ),
        headline2: GoogleFonts.nunitoSans(
          fontSize: 20,
        ),
        headline3: GoogleFonts.nunitoSans(
          fontSize: 16,
        ),
        headline4: GoogleFonts.nunitoSans(
          fontSize: 14,
        ),
        bodyText1: GoogleFonts.nunitoSans(
          fontSize: 12,
        ),
        bodyText2: GoogleFonts.nunitoSans(
          fontSize: 10,
        ),
      ),
    );
  }
}