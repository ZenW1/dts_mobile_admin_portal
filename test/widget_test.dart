// Basic widget test for DTS Admin Portal
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dts_admin_portal/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app wrapped in ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: DTSAdminApp(),
      ),
    );

    // Verify the app builds without error
    expect(find.byType(DTSAdminApp), findsOneWidget);
  });
}
