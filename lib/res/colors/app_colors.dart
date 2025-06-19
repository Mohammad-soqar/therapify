import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static Color getBackgroundColor() {
    return Get.isDarkMode ? backgroundColorDark : containerColor;
  }

  static Color getContainerColor() {
    return Get.isDarkMode ? containerColorDark : backgroundColor;
  }

  static Color getCardColor() {
    return Get.isDarkMode ? cardColorDark : cardColor;
  }

  static Color getShadowColor() {
    return Get.isDarkMode ? shadowColorDark : shadowColor;
  }

  static Color getTitleColor() {
    return Get.isDarkMode ? titleColorDark : titleColor;
  }

  static Color getTextColor() {
    return Get.isDarkMode ? textColorDark : textColor;
  }

  static Color getTextColor2() {
    return Get.isDarkMode ? textColor2Dark : textColor2;
  }

  static Color getFillColor() {
    return Get.isDarkMode ? fillColorDark : fillColor;
  }

  static Color getBorderColor() {
    return Get.isDarkMode ? borderColorDark : borderColor;
  }

  // Primary Colors
  static Color primaryColor = const Color(0xFF5893FF);
  static const Color secondaryColor = Color(0xFFFEBA88);
  static const Color whiteColor = Color(0xFFffffff);
  static const Color blackColor = Color(0xFF000000);
  static const Color successColor = Color(0xFF3BB949);
  static const Color dangerColor = Color(0xFFFF536A);
  static const Color infoColor = Color(0xFF8fceff);
  static const Color violetColor = Color(0xFF9093fe);
  static const Color orangeColor = Color(0xFFff8254);
  static const Color warningColor = Color(0xFFffc457);

  // Backgorund Colors
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color containerColor = Color(0xFFF6F9FE); //FAFCF8
  static const Color cardColor = Color(0xFFF2F3F3);
  static const Color fillColor = Color(0xFFf7f7f8);
  static const Color borderColor = Color(0xFFE6E7E8);
  static const Color shadowColor = Color(0xFFeeeeee);
  static const Color bottomNavColor = Color(0xFF040D12);

  static const Color backgroundColorDark = Color(0xFF051E31);
  static const Color containerColorDark = Color(0xFF0C2537);
  static const Color cardColorDark = Color(0xFF0C2537);
  static const Color fillColorDark = Color(0xFF0C2537);
  static const Color borderColorDark = Color(0xFF0F2F46);
  static const Color shadowColorDark = Color(0xFF0F2F46);

  // Text Colors
  static const Color titleColor = Color(0xFF1A1A1A);
  static const Color textColor = Color(0xFF666666);
  static const Color textColor2 = Color(0xFF999999);
  static const Color titleColorDark = Color(0xFFf1f7f7);
  static const Color textColorDark = Color(0xFFD9E7FD);
  static const Color textColor2Dark = Color(0xFFCED3D8);
}
