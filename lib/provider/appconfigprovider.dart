import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String applanguage = 'en';
  ThemeMode appMode = ThemeMode.light;

  void changelanguage(String newlanguage) {
    if (applanguage == newlanguage) {
      return;
    }
    applanguage = newlanguage;
    notifyListeners();
  }

  void changetheme(ThemeMode newmode) {
    if (appMode == newmode) {
      return;
    }
    appMode = newmode;
    notifyListeners();
  }
}
