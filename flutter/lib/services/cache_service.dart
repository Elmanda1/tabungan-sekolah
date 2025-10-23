import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<dynamic> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value != null) {
      final decoded = jsonDecode(value);
      final timestamp = DateTime.parse(decoded['timestamp']);
      final expiry = Duration(minutes: 5);
      if (DateTime.now().difference(timestamp) < expiry) {
        return decoded['data'];
      }
    }
    return null;
  }

  Future<void> set(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode({
      'timestamp': DateTime.now().toIso8601String(),
      'data': data,
    });
    await prefs.setString(key, value);
  }
}
