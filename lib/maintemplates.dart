import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/nav_bar.dart';
import '../models/appconfig.dart';

// Navigation callback type
typedef NavigationCallback = void Function(String route);

class MainTemplate extends StatelessWidget {
  final Widget body;
  final bool showBottomNavBar;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;

  const MainTemplate({
    super.key,
    required this.body,
    this.showBottomNavBar = true,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.backgroundColor, 
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.read<AppConfig>().colorPalette;
    
    return Scaffold(
      backgroundColor: backgroundColor ?? colors['background'],
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: showBottomNavBar
          ? BottomNavBar(
              currentRoute: ModalRoute.of(context)?.settings.name ?? '/',
              onItemTapped: (route) {
                // Use Navigator for navigation instead of GoRouter
                if (route != ModalRoute.of(context)?.settings.name) {
                  Navigator.pushReplacementNamed(context, route);
                }
              },
            )
          : null,
    );
  }
}

