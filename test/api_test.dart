import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import '../lib/models/appconfig.dart';
import '../lib/services/akun_service.dart';
import '../lib/services/api_service.dart';
import '../lib/services/auth_service.dart';
import '../lib/services/tabungan_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock the flutter_secure_storage channel
  const MethodChannel channel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  final Map<String, String> storage = {};

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'write':
        storage[methodCall.arguments['key']] = methodCall.arguments['value'];
        return null;
      case 'read':
        return storage[methodCall.arguments['key']];
      case 'delete':
        storage.remove(methodCall.arguments['key']);
        return null;
      default:
        return null;
    }
  });

  group('API Service Tests', () {
    late AppConfig appConfig;
    late ApiService apiService;
    late AuthService authService;
    late AkunService akunService;
    late TabunganService tabunganService;
    late Dio mockDio; // Declare mock Dio

    setUp(() {
      appConfig = AppConfig.defaultConfig();
      mockDio = Dio(BaseOptions(baseUrl: appConfig.baseUrl)); // Initialize mock Dio
      apiService = ApiService(appConfig, dio: mockDio); // Inject mock Dio
      authService = AuthService(apiService);
      akunService = AkunService(apiService);
      tabunganService = TabunganService(apiService);
    });

    test('Test /test endpoint', () async {
      // Mock response for /test
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/test') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'message': 'Test successful'}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing /test endpoint...');
        final testResponse = await apiService.dio.get('/test');
        expect(testResponse.statusCode, 200);
        expect(testResponse.data['success'], true);
        print('✓ Test: ${testResponse.data}');
      } catch (e) {
        fail('❌ Test failed: $e');
      }
    });

    test('Login and get token', () async {
      // Mock response for login
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/auth/login') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'data': {'token': 'mock_token'}}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing login...');
        // Replace with actual test credentials
        await authService.login('test@example.com', 'password');
        expect(authService.token, isNotNull);
        print('✓ Login successful, token: ${authService.token}');
      } catch (e) {
        fail('❌ Login failed: $e');
      }
    });

    test('Get Account Info', () async {
      // Mock response for /akun
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/akun') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'data': {'name': 'Test User', 'email': 'test@example.com'}}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing /akun endpoint...');
        final akunResponse = await akunService.getAkunInfo();
        expect(akunResponse, isA<Map<String, dynamic>>());
        print('✓ Akun: $akunResponse');
      } catch (e) {
        fail('❌ Akun info failed: $e');
      }
    });

    test('Get Balance', () async {
      // Mock response for /tabungan/saldo
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/tabungan/saldo') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'data': {'balance': 100000}}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing /tabungan/saldo endpoint...');
        final saldoResponse = await tabunganService.getBalance();
        expect(saldoResponse, isA<Map<String, dynamic>>());
        print('✓ Saldo: $saldoResponse');
      } catch (e) {
        fail('❌ Saldo failed: $e');
      }
    });

    test('Get History', () async {
      // Mock response for /tabungan/history
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/tabungan/history') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'data': [{'id': 1, 'amount': 50000, 'type': 'in'}]}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing /tabungan/history endpoint...');
        final historyResponse = await tabunganService.getTransactionHistory();
        expect(historyResponse, isA<List<Map<String, dynamic>>>());
        print('✓ History: $historyResponse');
      } catch (e) {
        fail('❌ History failed: $e');
      }
    });

    test('Get Income/Expenses', () async {
      // Mock response for /tabungan/income-expenses
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/tabungan/income-expenses') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'data': {'income': 200000, 'expenses': 50000}}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing /tabungan/income-expenses endpoint...');
        final incomeExpensesResponse =
            await tabunganService.getIncomeExpenses();
        expect(incomeExpensesResponse, isA<Map<String, dynamic>>());
        print('✓ Income/Expenses: $incomeExpensesResponse');
      } catch (e) {
        fail('❌ Income/Expenses failed: $e');
      }
    });

    test('Logout', () async {
      // Mock response for logout
      mockDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == '/auth/logout') {
          return handler.resolve(Response(requestOptions: options, data: {'success': true, 'message': 'Logout successful'}, statusCode: 200));
        }
        return handler.next(options);
      }));

      try {
        print('Testing logout...');
        await authService.logout();
        expect(authService.token, isNull);
        print('✓ Logout successful');
      } catch (e) {
        fail('❌ Logout failed: $e');
      }
    });
  });
}
