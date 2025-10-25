import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../models/appconfig.dart';
import '../services/auth_service.dart';
import '../services/akun_service.dart';
import '../services/profile_service.dart';
import '../services/tabungan_service.dart';
import 'tabungan_provider.dart';
import 'riwayat_provider.dart';
import 'appconfigprovider.dart';

List<SingleChildWidget> registerProviders() {
  return [
    ChangeNotifierProvider<AppConfig>(
      create: (_) => dummyAppConfig,
    ),
    ProxyProvider<AppConfig, AuthService>(
      update: (_, appConfig, __) => AuthService(appConfig),
    ),
    ProxyProvider2<AppConfig, AuthService, AkunService>(
      update: (_, appConfig, authService, __) => AkunService(appConfig, authService),
    ),
    ProxyProvider2<AppConfig, AuthService, ProfileService>(
      update: (_, appConfig, authService, __) => ProfileService(appConfig, authService),
    ),
    ProxyProvider2<AppConfig, AuthService, TabunganService>(
      update: (_, appConfig, authService, __) => TabunganService(appConfig, authService),
    ),
    ChangeNotifierProxyProvider2<TabunganService, ProfileService, TabunganProvider>(
      create: (context) => TabunganProvider(context.read<TabunganService>(), context.read<ProfileService>()),
      update: (context, tabunganService, profileService, previous) => TabunganProvider(tabunganService, profileService),
    ),
    ChangeNotifierProxyProvider<TabunganService, RiwayatProvider>(
      create: (context) => RiwayatProvider(context.read<TabunganService>()),
      update: (context, tabunganService, previous) => RiwayatProvider(tabunganService),
    ),
  ];
}