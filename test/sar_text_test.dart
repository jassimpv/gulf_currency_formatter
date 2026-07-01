import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'SarText renders the symbol with the bundled font on its own span', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: SarText(1000),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.toPlainText(), '${SarCurrencyFormatter.symbol} 1,000.00');

    final TextSpan symbolSpan = root.children!.first as TextSpan;
    expect(symbolSpan.text, SarCurrencyFormatter.symbol);
    expect(symbolSpan.style?.fontFamily, SarCurrencyFormatter.symbolFontFamily);

    // The numeral must NOT carry the symbol font: this specific bundled
    // font maps ASCII '0' to an empty placeholder glyph, so applying it to
    // the numeral would make every zero digit disappear.
    final TextSpan numberSpan = root.children!.last as TextSpan;
    expect(numberSpan.text, ' 1,000.00');
    expect(numberSpan.style?.fontFamily,
        isNot(SarCurrencyFormatter.symbolFontFamily));
  });

  testWidgets('SarText preserves a caller-supplied style on the root span', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: SarText(1000, style: TextStyle(fontSize: 24)),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.style?.fontSize, 24);
  });

  testWidgets('SarText respects formatting options', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: SarText(-10, decimalDigits: 0, symbolSpacing: 2),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.toPlainText(), '-${SarCurrencyFormatter.symbol}  10');
  });
}
