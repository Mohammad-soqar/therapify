import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  final getStorage = GetStorage();
  final themeModeKey = "themeMode";

  ThemeMode getThemeMode() {
    String? mode = getStorage.read(themeModeKey);
    if (mode == "light") return ThemeMode.light;
    if (mode == "dark") return ThemeMode.dark;
    return ThemeMode.system;
  }

  // Save the selected theme mode
  void saveThemeMode(ThemeMode themeMode) {
    String modeString;
    if (themeMode == ThemeMode.dark) {
      modeString = "dark";
    } else if (themeMode == ThemeMode.light) {
      modeString = "light";
    } else {
      modeString = "system";
    }
    getStorage.write(themeModeKey, modeString);
  }

  // Change the theme mode and save it
  void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    saveThemeMode(themeMode);
  }
}
