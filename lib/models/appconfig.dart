import 'package:flutter/material.dart';
import '../config/environment.dart';

class AppConfig extends ChangeNotifier {
  final Map<String, String> menuTexts;
  final Map<String, IconData> menuIcons;
  final Map<String, IconData> menuActiveIcons;
  final Map<String, Color> colorPalette;
  final Map<String, bool> featureFlags;
  final String baseUrl;

  // Default constructor with required parameters
  AppConfig({
    required this.baseUrl,
    required Map<String, String> menuTexts,
    required Map<String, IconData> menuIcons,
    required Map<String, IconData> menuActiveIcons,
    required Map<String, Color> colorPalette,
    Map<String, bool>? featureFlags,
  })  : menuTexts = Map<String, String>.from(menuTexts),
        menuIcons = Map<String, IconData>.from(menuIcons),
        menuActiveIcons = Map<String, IconData>.from(menuActiveIcons),
        colorPalette = Map<String, Color>.from(colorPalette),
        featureFlags = Map<String, bool>.from(featureFlags ?? {}) {
    // Ensure all required keys exist
    _validateMaps();
  }

  // Check if a feature is enabled
  bool isFeatureEnabled(String feature) => featureFlags[feature] ?? false;

  // Enable/disable a feature
  void setFeature(String feature, bool enabled) {
    featureFlags[feature] = enabled;
    notifyListeners();
  }

  // Factory constructor with default values
  factory AppConfig.defaultConfig() {
    return AppConfig(
      baseUrl: Environment.apiBaseUrl, // Default API base URL
      menuTexts: {
        'beranda': 'Beranda',
        'riwayat': 'Riwayat',
        'transaksi': 'Transaksi',
        'akun': 'Akun',
      },
      menuIcons: {
        'beranda': Icons.home_outlined,
        'riwayat': Icons.history_outlined,
        'transaksi': Icons.add_circle_outline,
        'akun': Icons.person_outline,
      },
      menuActiveIcons: {
        'beranda': Icons.home,
        'riwayat': Icons.history,
        'transaksi': Icons.add_circle,
        'akun': Icons.person,
      },
      colorPalette: {
        'primary': const Color(0xFF01986c),
        'primaryLight': const Color(0xFF34D399),
        'primaryDark': const Color(0xFF047857),
        'background': const Color(0xFFF9FAFB),
        'surface': Colors.white,
        'card': Colors.white,
        'text': const Color(0xFF111827),
        'textSecondary': const Color(0xFF6B7280),
        'textTertiary': const Color(0xFF9CA3AF),
        'success': const Color(0xFF10B981),
        'error': const Color(0xFFEF4444),
        'divider': const Color(0xFFE5E7EB),
        'highlight': const Color(0x1A01986c),
        'border' : const Color.fromARGB(26, 202, 202, 202)
      },
    );
  }

  // Validate that all required keys exist in the maps
  void _validateMaps() {
    if (menuTexts.isEmpty || menuIcons.isEmpty || menuActiveIcons.isEmpty) {
      throw ArgumentError('All maps must be non-empty');
    }

    // Ensure all menu items have corresponding icons
    for (final key in menuTexts.keys) {
      if (!menuIcons.containsKey(key)) {
        throw ArgumentError('Missing icon for menu item: $key');
      }
      if (!menuActiveIcons.containsKey(key)) {
        throw ArgumentError('Missing active icon for menu item: $key');
      }
    }
  }

  // Add methods to update the config if needed
  void updateColorPalette(Map<String, Color> newPalette) {
    colorPalette.clear();
    colorPalette.addAll(Map<String, Color>.from(newPalette));
    notifyListeners();
  }

  void updateMenuTexts(Map<String, String> newMenuTexts) {
    menuTexts.clear();
    menuTexts.addAll(Map<String, String>.from(newMenuTexts));
    notifyListeners();
  }
}
