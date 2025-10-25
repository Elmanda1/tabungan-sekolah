import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For clearing token on 401
import '../models/appconfig.dart'; // Assuming AppConfig contains baseUrl

class ApiService {
  late Dio _dio;
  final AppConfig appConfig;
  final _secureStorage = const FlutterSecureStorage();

  ApiService(this.appConfig, {Dio? dio}) {
    _dio = dio ?? Dio(BaseOptions(
      baseUrl: appConfig.baseUrl, // Use baseUrl from AppConfig
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add Bearer token to all requests
        final token = await _secureStorage.read(key: 'auth_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';

        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        // Handle 401 Unauthorized - token expired
        if (error.response?.statusCode == 401) {
          // Clear token and redirect to login
          await _secureStorage.delete(key: 'auth_token');
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('auth_token'); // Clear from SharedPreferences as well if used elsewhere
          // TODO: Implement navigation to login screen.
          // This typically involves a Navigator or a routing solution.
          // For now, we'll just clear the token.
        }
        return handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;
}
