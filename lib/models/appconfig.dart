import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {
  Map<String, String> menuTexts;
  Map<String, Color> colorPalette;

  AppConfig({
    required this.menuTexts,
    required this.colorPalette,
  });

  // Add methods to update the config if needed
  void updateColorPalette(Map<String, Color> newPalette) {
    colorPalette = newPalette;
    notifyListeners();
  }

  void updateMenuTexts(Map<String, String> newMenuTexts) {
    menuTexts = newMenuTexts;
    notifyListeners();
  }
}
