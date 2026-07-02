import 'package:gulf_currency/gulf_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CurrencyPicker shows the selected currency and its flag', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyPicker(value: 'AED', onChanged: (_) {}),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('AED'), findsOneWidget);
    expect(find.text(countryFlagEmoji('AE')), findsOneWidget);
  });

  testWidgets('CurrencyPicker calls onChanged when a new option is picked', (
    tester,
  ) async {
    String? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurrencyPicker(
            value: 'AED',
            onChanged: (String code) => selected = code,
          ),
        ),
      ),
    );

    await tester.tap(find.text('AED'));
    await tester.pumpAndSettle();
    // AFN is the option immediately after AED alphabetically, so it's
    // already within the menu's initial scroll viewport.
    await tester.tap(find.text('AFN').last);
    await tester.pumpAndSettle();

    expect(selected, 'AFN');
  });
}
