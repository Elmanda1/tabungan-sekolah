import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../models/appconfig.dart';
import '../services/auth_service.dart';
import '../services/akun_service.dart';
import '../services/profile_service.dart';
import '../services/tabungan_service.dart';
import '../services/api_service.dart'; // Import ApiService
import 'tabungan_provider.dart';
import 'riwayat_provider.dart';                 

List<SingleChildWidget> registerProviders() {
  return [
    ChangeNotifierProvider<AppConfig>(
      create: (_) => AppConfig.defaultConfig(),
    ),
    Provider<ApiService>( // Provide ApiService
      create: (context) => ApiService(context.read<AppConfig>()),
    ),
    ProxyProvider<ApiService, AuthService>( // AuthService now depends on ApiService
      update: (_, apiService, __) => AuthService(apiService),
    ),
    ProxyProvider<ApiService, AkunService>( // AkunService now depends on ApiService
      update: (_, apiService, __) => AkunService(apiService),
    ),
    ProxyProvider<ApiService, ProfileService>( // ProfileService now depends on ApiService
      update: (_, apiService, __) => ProfileService(apiService),
    ),
    ProxyProvider<ApiService, TabunganService>( // TabunganService now depends on ApiService
      update: (_, apiService, __) => TabunganService(apiService),
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