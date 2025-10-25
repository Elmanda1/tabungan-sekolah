import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/nav_constants.dart';
import '../models/appconfig.dart';
import '../models/nav_bar_config.dart';
import '../utils/nav_bar_utils.dart';
import '../widgets/blur_container.dart';
import '../widgets/nav_bar_item.dart';

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
    print('=== Building BottomNavBar ===');
    final appConfig = Provider.of<AppConfig>(context, listen: true);
    
    // Debug print all feature flags
    print('All feature flags:');
    appConfig.featureFlags.forEach((key, value) {
      print('- $key: $value');
    });
    
    final config = NavBarConfig.fromAppConfig({
      'menuTexts': appConfig.menuTexts,
      'menuIcons': appConfig.menuIcons,
      'menuActiveIcons': appConfig.menuActiveIcons,
      'colorPalette': appConfig.colorPalette,
    });

    // Merge with default values
    final menuTexts = _getMergedMenuTexts(config.menuTexts);
    final colors = config.colors;
    
    print('All menu items: ${menuTexts.keys.toList()}');

    // Get only enabled menu items
    final enabledItems = menuTexts.entries.where((entry) {
      final featureFlag = 'feature.${entry.key}.enabled';
      final isEnabled = appConfig.isFeatureEnabled(featureFlag);
      print('Nav Item: ${entry.key}, Enabled: $isEnabled, Flag: $featureFlag');
      return isEnabled;
    }).toList();

    print('Total enabled items: ${enabledItems.length}');
    print('Enabled items: ${enabledItems.map((e) => e.key).toList()}');

    // Don't show navigation bar if there are less than 2 items
    if (enabledItems.length < 2) {
      print('Hiding navigation bar - only ${enabledItems.length} items enabled (need at least 2)');
      print('Enabled items: ${enabledItems.map((e) => e.key).toList()}');
      return const SizedBox.shrink();
    }

    // Create navigation items
    print('Building navigation bar with ${enabledItems.length} items');
    final items = _buildNavItems(enabledItems, colors);
    print('Navigation items built successfully');
    
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
      child: BlurContainer(
        child: BottomNavigationBar(
          items: items,
          currentIndex: _getCurrentIndex(menuTexts, enabledItems),
          onTap: (index) => _onItemTapped(index, enabledItems, menuTexts),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: colors['text'],
          unselectedItemColor: colors['textSecondary'],
          selectedLabelStyle: _getLabelStyle(colors['text'], true),
          unselectedLabelStyle: _getLabelStyle(colors['textSecondary'], false),
          selectedFontSize: NavConstants.fontSize,
          unselectedFontSize: NavConstants.fontSize,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: NavConstants.elevation,
        ),
      ),
    );
  }

  Map<String, String> _getMergedMenuTexts(Map<String, String> customTexts) {
    final result = Map<String, String>.from(NavConstants.defaultMenuItems);
    result.addAll(customTexts);
    return result;
  }

  List<BottomNavigationBarItem> _buildNavItems(
    List<MapEntry<String, String>> enabledItems,
    Map<String, Color> colors,
  ) {
    return enabledItems.map((entry) {
      final key = entry.key;
      final isActive = NavBarUtils.getMenuKeyForRoute(currentRoute) == key;
      
      return NavBarItem(
        label: entry.value,
        icon: NavBarUtils.getDefaultIcon(key, filled: isActive),
        isActive: isActive,
        activeColor: colors['text'] ?? Colors.black,
        inactiveColor: colors['textSecondary'] ?? Colors.grey,
        backgroundColor: colors['primary'] ?? Colors.blue,
      ).toBottomNavBarItem();
    }).toList();
  }

  int _getCurrentIndex(
    Map<String, String> allMenuTexts,
    List<MapEntry<String, String>> enabledItems,
  ) {
    final currentKey = NavConstants.routeToKey[currentRoute];
    
    // If no items are enabled, return 0 as a fallback
    if (enabledItems.isEmpty) return 0;
    
    // Find the index in the filtered list
    final index = enabledItems.indexWhere(
      (entry) => entry.key == currentKey,
    );
    
    // If current route is not in enabled items, default to first enabled item
    return index >= 0 ? index : 0;
  }

  void _onItemTapped(
    int index,
    List<MapEntry<String, String>> enabledItems,
    Map<String, String> allMenuTexts,
  ) {
    if (index >= 0 && index < enabledItems.length) {
      final menuKey = enabledItems[index].key;
      final route = NavConstants.routeToKey.entries
          .firstWhere(
            (entry) => entry.value == menuKey,
            orElse: () => NavConstants.routeToKey.entries.first,
          )
          .key;
      onItemTapped(route);
    }
  }

  TextStyle _getLabelStyle(Color? color, bool isSelected) {
    return TextStyle(
      fontSize: NavConstants.fontSize,
      fontWeight: isSelected
          ? FontWeight.w500
          : FontWeight.normal,
      color: color,
      height: NavConstants.labelHeight,
    );
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
