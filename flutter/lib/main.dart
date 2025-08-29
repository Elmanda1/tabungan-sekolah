import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/appconfig.dart';
import 'providers/appconfigprovider.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/riwayat_view.dart';
import 'views/akun_view.dart';

void main() async {
  // Initialize date formatting for Indonesian locale
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  
  // Use the pre-configured dummyAppConfig
  runApp(MyApp(appConfig: dummyAppConfig));
}

class MyApp extends StatelessWidget {
  final AppConfig appConfig;
  
  const MyApp({super.key, required this.appConfig});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appConfig,
      child: Builder(
        builder: (context) {
          final config = Provider.of<AppConfig>(context);
          final textColor = config.colorPalette['text']!;
          
          return MaterialApp(
            title: 'Configurable App',
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: config.colorPalette['primary'],
              scaffoldBackgroundColor: config.colorPalette['background'],
              
              // Apply text color to all text themes
              textTheme: TextTheme(
                bodyLarge: TextStyle(color: textColor),
                bodyMedium: TextStyle(color: textColor),
                titleLarge: TextStyle(color: textColor),
                titleMedium: TextStyle(color: textColor),
                titleSmall: TextStyle(color: textColor),
                labelLarge: TextStyle(color: textColor),
                labelMedium: TextStyle(color: textColor),
                labelSmall: TextStyle(color: textColor),
                displayLarge: TextStyle(color: textColor),
                displayMedium: TextStyle(color: textColor),
                displaySmall: TextStyle(color: textColor),
                headlineMedium: TextStyle(color: textColor),
                headlineSmall: TextStyle(color: textColor),
              ).apply(
                displayColor: textColor,
                bodyColor: textColor,
              ),
              
              // App bar theming
              appBarTheme: AppBarTheme(
                backgroundColor: config.colorPalette['primary'],
                titleTextStyle: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: textColor),
                actionsIconTheme: IconThemeData(color: textColor),
              ),
              
              // Icon theming
              iconTheme: IconThemeData(color: textColor),
              primaryIconTheme: IconThemeData(color: textColor),
              
              // Floating action button theming
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: config.colorPalette['accent'],
                foregroundColor: textColor,
              ),
              
              // Card theming
              cardTheme: CardThemeData(
                color: config.colorPalette['primary']?.withOpacity(0.1),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(8.0),
                shadowColor: Colors.black.withOpacity(0.1),
                surfaceTintColor: Colors.transparent,
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginView(),
              '/home': (context) => const HomeView(title: 'Buku Keuangan'),
              '/riwayat': (context) => const RiwayatView(),
              '/akun': (context) => const AkunView(),
            },
          );
        },
      ),
    );
  }
}
