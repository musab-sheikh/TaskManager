import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData;

  ThemeManager(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}