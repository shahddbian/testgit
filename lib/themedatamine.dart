import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appcolors.dart';

class myThemedate {
  static final ThemeData LightTheme = ThemeData(
      primaryColor: appcolors.primaryColor,
      scaffoldBackgroundColor: appcolors.backlightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appcolors.primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: appcolors.primaryColor,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appcolors.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(color: appcolors.whiteColor, width: 6),
        ),
      ),
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: appcolors.blackColor,
      )));
  static final ThemeData DarkTheme = ThemeData(
      primaryColor: appcolors.primaryColor,
      scaffoldBackgroundColor: appcolors.darkbackColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appcolors.primaryColor,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: appcolors.primaryColor,
                width: 2,
              ))),
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: appcolors.blackColor),
          bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: appcolors.blackColor)));
}
