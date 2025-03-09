import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

TextTheme mainTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 34,
  ),
  headlineMedium: TextStyle(
    fontSize: 24,
  ),
  headlineSmall: TextStyle(
    fontSize: 20,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
  )

);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade400,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade200
    ),
    textTheme: mainTextTheme,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700
    ),
    textTheme: mainTextTheme,
);

class ThemeController extends GetxController {
  final RxBool _isDark = false.obs;
  final _storage = GetStorage();
  final String _keyIsDark = 'isDark';

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    try {
      _isDark.value = await _storage.read(_keyIsDark);
    }catch(e){
      _isDark.value = false;
    }
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

/*
  InputDecorationTheme inputTheme() => InputDecorationTheme(
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 4),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 4),
      borderRadius: BorderRadius.circular(12),
    ),


  );
*/


}
