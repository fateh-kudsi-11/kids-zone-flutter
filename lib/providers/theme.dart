import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  bool _themeDark = false;

  get themeMode => _themeDark;

  toggleTheme(bool isDark) {
    _themeDark = isDark;
    notifyListeners();
  }
}
