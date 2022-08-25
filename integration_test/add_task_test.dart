import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_list/main.dart' as app;

Future<void> restoreFlutterError(Future<void> Function() call) async {
  try {
    await call();
  } catch (e) {
    final overriddenOnError = FlutterError.onError!;
    FlutterError.onError = (FlutterErrorDetails details) {
      overriddenOnError(details);
    };
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add new task by floating button', (WidgetTester tester) async {
    String val = DateTime.now().toIso8601String();
    await restoreFlutterError(() async {
      app.main();
      await tester.pumpAndSettle();

      final Finder fab = find.byTooltip('add_task');
      await tester.tap(fab);
      await tester.pumpAndSettle();

      final Finder field = find.byKey(const Key('text_field'));
      await tester.enterText(field, val);
      await tester.pumpAndSettle();

      final Finder save = find.byKey(const Key('save'));
      await tester.tap(save);
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text(val),
        200,
        duration: const Duration(
          milliseconds: 100,
        ),
      );
      await tester.pumpAndSettle();
    });

    expect(find.text(val), findsWidgets);
  });
}
