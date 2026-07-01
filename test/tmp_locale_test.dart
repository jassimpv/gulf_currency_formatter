import 'package:gulf_currency_formatter/gulf_currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'CurrencyText with an unrecognized locale falls back instead of throwing',
      (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CurrencyText(1250.75, locale: 'not_a_real_locale'),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.textContaining('1,250.75'), findsOneWidget);
  });
}
