import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkino/ui/common/loading_view.dart';

void main() {
  group('LoadingView', () {
    const loading = Key('test-loading');
    const error = Key('test-error');
    const success = Key('test-success');

    Future<void> _pumpWithLoadingStatus(
        WidgetTester tester, LoadingStatus status) async {
      return tester.pumpWidget(MaterialApp(
        home: LoadingView(
          status: status,
          loadingContent: Container(key: loading),
          errorContent: Container(key: error),
          successContent: Container(key: success),
        ),
      ));
    }

    testWidgets('loading', (WidgetTester tester) async {
      await _pumpWithLoadingStatus(tester, LoadingStatus.loading);
      await tester.pumpAndSettle();

      expect(find.byKey(loading), findsOneWidget);
      expect(find.byKey(error), findsNothing);
      expect(find.byKey(success), findsNothing);
    });

    testWidgets('error', (WidgetTester tester) async {
      await _pumpWithLoadingStatus(tester, LoadingStatus.error);
      await tester.pumpAndSettle();

      expect(find.byKey(loading), findsNothing);
      expect(find.byKey(error), findsOneWidget);
      expect(find.byKey(success), findsNothing);
    });

    testWidgets('success', (WidgetTester tester) async {
      await _pumpWithLoadingStatus(tester, LoadingStatus.success);
      await tester.pumpAndSettle();

      expect(find.byKey(loading), findsNothing);
      expect(find.byKey(error), findsNothing);
      expect(find.byKey(success), findsOneWidget);
    });
  });
}
