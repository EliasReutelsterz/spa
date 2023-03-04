import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier{
  bool isDarkModeOn = false;

  void toogleTheme(){
    isDarkModeOn = !isDarkModeOn;
    notifyListeners();
  }
}