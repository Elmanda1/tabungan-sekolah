class NavConstants {
  // Default menu items
  static const Map<String, String> defaultMenuItems = {
    'beranda': 'Beranda',
    'riwayat': 'Riwayat',
    'transaksi': 'Transaksi',
    'akun': 'Akun',
  };

  // Default icons for menu items
  static const Map<String, String> defaultIcons = {
    'beranda': 'home',
    'riwayat': 'history',
    'transaksi': 'add_circle',
    'akun': 'person',
  };

  // Route to menu key mapping
  static const Map<String, String> routeToKey = {
    '/home': 'beranda',
    '/riwayat': 'riwayat',
    '/transaksi': 'transaksi',
    '/akun': 'akun',
  };

  // Navigation bar styles
  static const double blurSigma = 10.0;
  static const double borderRadius = 20.0;
  static const double labelHeight = 2.0;
  static const double fontSize = 12.0;
  static const double selectedFontWeight = 500.0;
  static const double unselectedFontWeight = 400.0;
  static const double elevation = 0.0;
}
