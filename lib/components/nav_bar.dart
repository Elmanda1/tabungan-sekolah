import 'dart:ui';
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
    // Get AppConfig from provider
    final appConfig = Provider.of<AppConfig>(context, listen: true);
    
    // Use the color palette from the app config
    final colors = appConfig.colorPalette;
    
    // Get menu configurations with fallbacks
    final menuTexts = Map<String, String>.from(appConfig.menuTexts);
    final menuIcons = Map<String, IconData>.from(appConfig.menuIcons);
    final menuActiveIcons = Map<String, IconData>.from(appConfig.menuActiveIcons);
    
    // Ensure we have at least the default menu items
    if (menuTexts.isEmpty) {
      menuTexts.addAll({
        'beranda': 'Beranda',
        'riwayat': 'Riwayat',
        'transaksi': 'Transaksi',
        'akun': 'Akun',
      });
    }
    
    // Always use filled icons for both active and inactive states
    menuIcons.addAll({
      'beranda': Icons.home,
      'riwayat': Icons.history,
      'transaksi': Icons.add_circle,
      'akun': Icons.person,
    });
    
    menuActiveIcons.addAll({
      'beranda': Icons.home,
      'riwayat': Icons.history,
      'transaksi': Icons.add_circle,
      'akun': Icons.person,
    });

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
        icon: _AnimatedNavIcon(
          icon: icon,
          isActive: isActive,
          activeColor: Colors.white,
          inactiveColor: Colors.white.withOpacity(0.7),
          backgroundColor: colors['primary'] ?? Colors.green,
        ),
        label: entry.value,
      );
    }).toList();

    // Convert menuTexts to list for index-based access
    final menuItemsList = menuTexts.entries.toList();
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
            backgroundColor: Colors.transparent,
            selectedItemColor: colors['text'],
            unselectedItemColor: colors['textSecondary'],
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors['text'],
              height: 2.0,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: colors['textSecondary'],
              height: 2.0,
            ),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
          ),
        ),
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

class _AnimatedNavIcon extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const _AnimatedNavIcon({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.backgroundColor,
  });

  @override
  _AnimatedNavIconState createState() => _AnimatedNavIconState();
}

class _AnimatedNavIconState extends State<_AnimatedNavIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: widget.backgroundColor.withOpacity(0.3),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_AnimatedNavIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle with animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _colorAnimation.value,
                ),
              );
            },
          ),
          // Icon with scale animation
          ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              widget.icon,
              color: widget.isActive ? widget.activeColor : widget.inactiveColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
