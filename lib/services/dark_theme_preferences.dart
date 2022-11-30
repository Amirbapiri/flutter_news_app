import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const themeStatus = "themeStatus";

  setDarkTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(themeStatus, value);
  }

  Future<bool> getCurrentTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(themeStatus) ?? false;
  }
}
