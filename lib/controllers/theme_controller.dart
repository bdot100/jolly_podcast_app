import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get themeMode {
    final storedValue = _box.read(_key);
    if (storedValue == null) return ThemeMode.system;
    return storedValue ? ThemeMode.dark : ThemeMode.light;
  }

  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);

  void changeTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
    if (mode == ThemeMode.dark) {
      saveTheme(true);
    } else if (mode == ThemeMode.light) {
      saveTheme(false);
    } else {
      _box.remove(_key);
    }
  }
}
