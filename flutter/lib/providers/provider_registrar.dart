import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../models/appconfig.dart';
import 'appconfigprovider.dart';
import 'tabungan_provider.dart';
import 'riwayat_provider.dart';

List<SingleChildWidget> getProviders(AppConfig appConfig) {
  return [
    ChangeNotifierProvider.value(value: appConfig),
    ChangeNotifierProvider(create: (_) => TabunganProvider()),
    ChangeNotifierProvider(create: (_) => RiwayatProvider()),
  ];
}
