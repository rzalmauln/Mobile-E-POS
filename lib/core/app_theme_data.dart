import 'color_values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValues.primary600;
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
      950: primaryColor,
    };

    final MaterialColor primaryMaterialColor =
      MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
      useMaterial3: false,
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      scaffoldBackgroundColor: ColorValues.grayscale100,
      canvasColor: ColorValues.grayscale100,
      hintColor: ColorValues.grayscale900,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorValues.primary600,
          unselectedItemColor: ColorValues.grayscale300,
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
              color: ColorValues.primary600,
              fontSize: 12,
              fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(
              color: ColorValues.grayscale300,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorValues.primary600,
                elevation: 0,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ))),
        iconTheme: IconThemeData(size: 6.w, color: ColorValues.grayscale900),
        textTheme: TextTheme(
          // headlineLarge: Callout
          // bodyLarge: Body
          // bodyMedium: Caption 1
          // bodySmall: Caption 2
          // titleLarge: Large Title
          // labelLarge: Button
          headlineLarge: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            letterSpacing: -0.32,
          ),
          bodyLarge: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            letterSpacing: -0.5,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.plusJakartaSans(fontSize: 11),
          titleLarge: GoogleFonts.plusJakartaSans(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.08,
          ),
          labelLarge: GoogleFonts.plusJakartaSans(
              fontSize: 12, fontWeight: FontWeight.w500),
        )
    );
  }
}