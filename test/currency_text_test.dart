import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CurrencyText delegates to AedText for an AED locale', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CurrencyText(1000, locale: 'en_AE'),
      ),
    );

    expect(find.byType(AedText), findsOneWidget);
    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.toPlainText(), '${AedCurrencyFormatter.symbol} 1,000.00');
  });

  testWidgets('CurrencyText delegates to SarText for a SAR locale', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CurrencyText(1000, locale: 'en_SA'),
      ),
    );

    expect(find.byType(SarText), findsOneWidget);
  });

  testWidgets('CurrencyText renders a plain symbol for other currencies', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CurrencyText(1000, locale: 'en_US'),
      ),
    );

    expect(find.byType(AedText), findsNothing);
    expect(find.byType(SarText), findsNothing);
    final Text textWidget = tester.widget(find.byType(Text));
    expect(textWidget.data, '\$ 1,000.00');
  });
}
