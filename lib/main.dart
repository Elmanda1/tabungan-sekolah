import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/appconfig.dart';
import 'providers/appconfigprovider.dart' as config_provider;
import 'views/home_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppConfig>(
      create: (context) => AppConfig(
        menuTexts: config_provider.dummyAppConfig.menuTexts,
        colorPalette: config_provider.dummyAppConfig.colorPalette,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<AppConfig>(context);

    return MaterialApp(
      title: 'Configurable App',
      theme: ThemeData(
        primaryColor: config.colorPalette['primary'],
        scaffoldBackgroundColor: config.colorPalette['background'],
      ),
      home: const HomeView(title: 'Buku Keuangan'),
    );
  }
}
