import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/authentication/auth_service.dart';
import 'package:task_manager/ui/login.dart';
import 'package:task_manager/ui/theme_manager.dart';
import 'package:mockito/mockito.dart';

// Mock the necessary classes using Mockito or a similar package if needed
class MockAuthService extends Mock implements AuthService {}
class MockThemeManager extends Mock implements ThemeManager {}

void main() {
  group('LoginScreen Tests', () {
    // Mock the authentication service
    late AuthService mockAuthService;
    late ThemeManager mockThemeManager;

    setUp(() {
      mockAuthService = MockAuthService();
      mockThemeManager = MockThemeManager();
    });

    Widget makeTestableWidget({required Widget child}) {
      return MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<AuthService>(create: (_) => mockAuthService),
            Provider<ThemeManager>(create: (_) => mockThemeManager),
          ],
          child: child,
        ),
      );
    }

    testWidgets('empty email and password shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: LoginScreen()));

      // Find the login button and tap it
      final loginButton = find.text('Login');
      await tester.tap(loginButton);

      // Rebuild the widget to show validation errors
      await tester.pump();

      // Check for error messages
      expect(find.text('Please enter an email address'), findsOneWidget);
      expect(find.text('Please enter a password'), findsOneWidget);
    });

    testWidgets('non-empty invalid email shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: LoginScreen()));

      // Enter invalid email and valid password
      await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');

      // Tap the login button
      await tester.tap(find.text('Login'));

      // Rebuild the widget to show validation errors
      await tester.pump();

      // Check for error messages
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('valid email and password does not show error message', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: LoginScreen()));

      // Enter valid email and password
      await tester.enterText(find.byType(TextFormField).first, 'email@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');

      // Tap the login button
      await tester.tap(find.text('Login'));

      // Rebuild the widget to validate inputs
      await tester.pump();

      // Verify no error messages are shown for valid inputs
      expect(find.text('Please enter an email address'), findsNothing);
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.text('Please enter a password'), findsNothing);
    });
  });
}
