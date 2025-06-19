import 'package:therapify/res/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final light = ThemeData().copyWith(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.containerColor, // AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.primaryColor, // Header background color
      onPrimary: Colors.white, // Header text color
      surface: AppColors.backgroundColor, // Background color of the date picker
      onSurface: AppColors.textColor, seedColor: AppColors.primaryColor, // Text color
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // Button text color
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle:
          TextStyle(fontFamily: "Outfit", fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.titleColor),
      titleTextStyle:
          TextStyle(fontFamily: "Outfit", fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.titleColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColor,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 36, fontWeight: FontWeight.w500, color: AppColors.titleColor),
      titleLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.titleColor),
      titleMedium:
          TextStyle(fontFamily: "Outfit", fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.titleColor),
      bodyLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.titleColor),
      bodyMedium:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textColor),
      bodySmall:
          TextStyle(fontFamily: "Outfit", fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textColor2),
      labelLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.whiteColor),
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.primaryColor, // Header background color
      onPrimary: Colors.white, // Header text color
      surface: AppColors.backgroundColorDark, // Background color of the date picker
      onSurface: AppColors.textColorDark, seedColor: AppColors.primaryColor, // Text color
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // Button text color
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle:
          TextStyle(fontFamily: "Outfit", fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.titleColorDark),
      titleTextStyle:
          TextStyle(fontFamily: "Outfit", fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.titleColorDark),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textColorDark,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 36, fontWeight: FontWeight.w500, color: AppColors.titleColorDark),
      titleLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.titleColorDark),
      titleMedium:
          TextStyle(fontFamily: "Outfit", fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.titleColorDark),
      bodyLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.titleColorDark),
      bodyMedium:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textColorDark),
      bodySmall:
          TextStyle(fontFamily: "Outfit", fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textColor2Dark),
      labelLarge:
          TextStyle(fontFamily: "Outfit", fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.whiteColor),
    ),
  );
}
