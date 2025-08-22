import 'package:flutter/material.dart';
import '../constants/nav_constants.dart';

class NavBarUtils {
  // Get the current index based on route
  static int getCurrentIndex(String currentRoute, List<String> routes) {
    final index = NavConstants.routeToKey.entries
        .toList()
        .indexWhere((entry) => entry.key == currentRoute);
    return index >= 0 ? index : 0;
  }

  // Get the route for a given index
  static String? getRouteForIndex(int index) {
    final routes = NavConstants.routeToKey.keys.toList();
    return index >= 0 && index < routes.length ? routes[index] : null;
  }

  // Get the menu key for a route
  static String? getMenuKeyForRoute(String route) {
    return NavConstants.routeToKey[route];
  }

  // Get the default icon
  static IconData getDefaultIcon(String key, {bool filled = false}) {
    final iconName = NavConstants.defaultIcons[key] ?? 'help_outline';
    if (filled) {
      return _getIconData(iconName) ?? Icons.help_outline;
    }
    final outlinedIconName = '${iconName}_outlined';
    return _getIconData(outlinedIconName) ?? _getIconData(iconName) ?? Icons.help_outline;
  }

  // Helper to get IconData from string
  static IconData? _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'home_outlined':
        return Icons.home_outlined;
      case 'history':
        return Icons.history;
      case 'history_outlined':
        return Icons.history_outlined;
      case 'add_circle':
        return Icons.add_circle;
      case 'add_circle_outlined':
        return Icons.add_circle_outline;
      case 'person':
        return Icons.person;
      case 'person_outlined':
        return Icons.person_outline;
      default:
        return Icons.help_outline;
    }
  }
}
