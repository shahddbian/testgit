import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String applanguage = 'en';
  ThemeMode appMode = ThemeMode.light;
  SharedPreferences? sharedpreferences;

  AppConfigProvider() {
    getConfigData();
  }

  Future<void> getConfigData() async {
    sharedpreferences = await SharedPreferences.getInstance();
    applanguage = sharedpreferences!.getString("appLanguage") ?? "en";
    sharedpreferences = await SharedPreferences.getInstance();
    appMode = sharedpreferences!.getString("appMode") == "dark"
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  Future<void> changelanguage(String newlanguage) async {
    if (applanguage == newlanguage) {
      return;
    }
    sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences!.setString("appLanguage", newlanguage);
    applanguage = newlanguage;
    notifyListeners();
  }

  Future<void> changetheme(ThemeMode newmode) async {
    if (appMode == newmode) {
      return;
    }
    sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences!
        .setString("appTheme", newmode == ThemeMode.dark ? "dark" : "light");
    appMode = newmode;
    notifyListeners();
  }

  bool isdarkmode() {
    return appMode == ThemeMode.dark;
  }
}
