'''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/views/home_view.dart';
import 'package:fluttertest/providers/tabungan_provider.dart';
import 'package:fluttertest/providers/base_provider.dart';
import 'package:fluttertest/models/appconfig.dart';
import 'package:fluttertest/config/environment.dart';
import 'package:mockito/mockito.dart';

// Mock class for TabunganProvider
class MockTabunganProvider extends Mock implements TabunganProvider {}

void main() {
  testWidgets('HomeView should display error message when state is error and message is null', (WidgetTester tester) async {
    // Create a mock TabunganProvider
    final mockTabunganProvider = MockTabunganProvider();

    // Stub the state to be ViewState.error and errorMessage to be null
    when(mockTabunganProvider.state).thenReturn(ViewState.error);
    when(mockTabunganProvider.errorMessage).thenReturn(null);
    when(mockTabunganProvider.error).thenReturn(null);

    // Create a test config
    final testConfig = AppConfig(
      baseUrl: Environment.apiBaseUrl,
      featureFlags: {
        'feature.home.profile_card.enabled': true,
        'feature.home.dashboard_tabungan.enabled': true,
      },
      menuTexts: {'test': 'Test'},
      menuIcons: {'test': Icons.home},
      menuActiveIcons: {'test': Icons.home_filled},
      colorPalette: {
        'primary': Colors.blue,
        'background': Colors.white,
        'accent': Colors.orange,
        'text': Colors.black,
      },
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TabunganProvider>.value(value: mockTabunganProvider),
          Provider<AppConfig>.value(value: testConfig),
        ],
        child: const MaterialApp(
          home: HomeView(title: 'Home'),
        ),
      ),
    );

    // The first pump triggers the build, but the error dialog is shown in a post-frame callback.
    await tester.pump(); 

    // Verify that the error text is displayed.
    expect(find.text('An unknown error occurred.'), findsOneWidget);
  });
}
''