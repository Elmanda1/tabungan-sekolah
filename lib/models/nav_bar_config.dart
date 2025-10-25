import 'package:flutter/material.dart';

class NavBarConfig {
  final Map<String, String> menuTexts;
  final Map<String, IconData> menuIcons;
  final Map<String, IconData> menuActiveIcons;
  final Map<String, Color> colors;

  const NavBarConfig({
    required this.menuTexts,
    required this.menuIcons,
    required this.menuActiveIcons,
    required this.colors,
  });

  factory NavBarConfig.fromAppConfig(Map<String, dynamic> config) {
    return NavBarConfig(
      menuTexts: Map<String, String>.from(config['menuTexts'] ?? {}),
      menuIcons: Map<String, IconData>.from(config['menuIcons'] ?? {}),
      menuActiveIcons: Map<String, IconData>.from(config['menuActiveIcons'] ?? {}),
      colors: Map<String, Color>.from(config['colorPalette'] ?? {}),
    );
  }
}
