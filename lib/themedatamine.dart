import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appcolors.dart';

class myThemedate {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: appcolors.primaryColor,
    scaffoldBackgroundColor: appcolors.backlightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: appcolors.primaryColor,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: appcolors.blackColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: appcolors.blackColor,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: appcolors.primaryColor,
    scaffoldBackgroundColor: appcolors.darkbackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: appcolors.primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: appcolors.whiteColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: appcolors.whiteColor,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
