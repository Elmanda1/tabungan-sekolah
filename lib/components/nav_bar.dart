import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appconfig.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;
  final Function(String) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.currentRoute,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // Default values in case of errors
    Map<String, String> menuTexts = {};
    Map<String, IconData> menuIcons = {};
    Map<String, IconData> menuActiveIcons = {};
    Map<String, Color> colors = {
      'primary': Colors.blue,
      'background': Colors.white,
      'surface': Colors.white,
      'text': Colors.black,
      'textSecondary': Colors.grey,
      'success': Colors.green,
      'error': Colors.red,
    };

    try {
      // Try to get AppConfig from provider
      final appConfig = Provider.of<AppConfig>(context, listen: true);
      
      // Safely copy the maps with fallbacks
      menuTexts = Map<String, String>.from(appConfig.menuTexts);
      menuIcons = Map<String, IconData>.from(appConfig.menuIcons);
      menuActiveIcons = Map<String, IconData>.from(appConfig.menuActiveIcons);
      colors = Map<String, Color>.from(appConfig.colorPalette);
    } catch (e) {
      // If there's an error, use default values
      debugPrint('Error accessing AppConfig: $e');
      menuTexts = {
        'beranda': 'Beranda',
        'riwayat': 'Riwayat',
        'transaksi': 'Transaksi',
        'akun': 'Akun',
      };
      
      menuIcons = {
        'beranda': Icons.home_outlined,
        'riwayat': Icons.history_outlined,
        'transaksi': Icons.add_circle_outline,
        'akun': Icons.person_outline,
      };
      
      menuActiveIcons = {
        'beranda': Icons.home,
        'riwayat': Icons.history,
        'transaksi': Icons.add_circle,
        'akun': Icons.person,
      };
    }

    // Ensure we have at least the default menu items
    if (menuTexts.isEmpty) {
      menuTexts = {
        'beranda': 'Beranda',
        'riwayat': 'Riwayat',
        'transaksi': 'Transaksi',
        'akun': 'Akun',
      };
    }

    // Map routes to menu keys
    final routeToKey = {
      '/home': 'beranda',
      '/riwayat': 'riwayat',
      '/transaksi': 'transaksi',
      '/akun': 'akun',
    };

    // Create bottom navigation items from menuTexts
    final items = menuTexts.entries.map((entry) {
      final key = entry.key;
      final isActive = routeToKey[currentRoute] == key;
      
      // Get icon with fallback
      final icon = isActive
          ? menuActiveIcons[key] ?? _getDefaultIcon(key, filled: true)
          : menuIcons[key] ?? _getDefaultIcon(key, filled: false);
      
      return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: isActive 
              ? colors['primary'] ?? Colors.blue
              : colors['textSecondary'] ?? Colors.grey,
        ),
        label: entry.value,
      );
    }).toList();

    // Convert menuTexts to list for index-based access
    final menuItemsList = menuTexts.entries.toList();
    
    return Container(
      decoration: BoxDecoration(
        color: colors['surface'] ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: items,
        currentIndex: items.indexWhere((item) {
          final itemIndex = items.indexOf(item);
          if (itemIndex < 0 || itemIndex >= menuItemsList.length) return false;
          final menuKey = menuItemsList[itemIndex].key;
          return routeToKey[currentRoute] == menuKey;
        }).clamp(0, items.length - 1),
        onTap: (index) {
          if (index >= 0 && index < menuItemsList.length) {
            final menuKey = menuItemsList[index].key;
            final route = routeToKey.entries
                .firstWhere(
                  (entry) => entry.value == menuKey,
                  orElse: () => routeToKey.entries.first,
                )
                .key;
            onItemTapped(route);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: colors['surface'] ?? Colors.white,
        selectedItemColor: colors['primary'] ?? Colors.blue,
        unselectedItemColor: colors['textSecondary'] ?? Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colors['primary'] ?? Colors.blue,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: colors['textSecondary'] ?? Colors.grey,
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8,
      ),
    );
  }
  
  // Helper method to get default icons based on menu key
  static IconData _getDefaultIcon(String key, {bool filled = false}) {
    switch (key) {
      case 'beranda':
        return filled ? Icons.home : Icons.home_outlined;
      case 'riwayat':
        return filled ? Icons.history : Icons.history_outlined;
      case 'transaksi':
        return filled ? Icons.add_circle : Icons.add_circle_outline;
      case 'akun':
        return filled ? Icons.person : Icons.person_outline;
      default:
        return filled ? Icons.circle : Icons.circle_outlined;
    }
  }
}
