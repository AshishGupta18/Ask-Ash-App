import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = 'pref_key';

  setTheme(bool value) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    sharedpreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    return sharedpreferences.getBool(PREF_KEY);
  }
}
