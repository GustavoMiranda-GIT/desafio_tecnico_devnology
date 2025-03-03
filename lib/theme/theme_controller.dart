import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white,
    )
);

ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Colors.blue,
    )
);

class ThemeController extends GetxController {
  RxBool _isDark = false.obs;
  final _storage = GetStorage();
  final String _keyIsDark = 'isDark';

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    _isDark.value = await _storage.read(_keyIsDark);
    _setThemeMode();
  }

  changeThemeMode() {
    _isDark.value = !_isDark.value;
    _setThemeMode();
  }

  Future _setThemeMode() async {
    Get.changeThemeMode(_isDark.value ? ThemeMode.dark : ThemeMode.light);
    await _storage.write(_keyIsDark, _isDark.value);
  }


}