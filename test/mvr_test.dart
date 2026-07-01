import 'package:gulf_currency_formatter/gulf_currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CurrencyText renders MVR for en_MV locale', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CurrencyText(1250.75, locale: 'en_MV'),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.textContaining('1,250.75'), findsOneWidget);
  });
}
