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
  inputDecorationTheme: ThemeController().inputTheme(),
    colorScheme: ColorScheme.light(
      surface: Color(0xFFEFEFEF),
      primary: Colors.white,
    ),
    textTheme: mainTextTheme,
);

ThemeData darkTheme = ThemeData(
    inputDecorationTheme: ThemeController().inputTheme(),
    colorScheme: ColorScheme.dark(
      surface: Colors.blue,
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


  InputDecorationTheme inputTheme() => InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 4),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 4),
      borderRadius: BorderRadius.circular(12),
    ),


  );



}

InputDecoration textFieldDecoration(String hintText) => InputDecoration(
    hintText: hintText,
    prefixIcon: Padding(
      padding: const EdgeInsets.all(12),
      child: const Icon(Icons.flight_takeoff),
    )

);
