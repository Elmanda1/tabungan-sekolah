
class Environment {
  static const String dev = 'development';
  static const String prod = 'production';

  static const String current = String.fromEnvironment('ENV', defaultValue: dev);

  static String get apiBaseUrl {
    switch (current) {
      case prod:
        return 'https://your-domain.com/profil-sekolah/flutterapi';
      case dev:
      default:
        return 'http://10.0.2.2:8000/flutterapi';
    }
  }
}
