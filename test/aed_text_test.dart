import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'AedText renders the symbol with the bundled font on its own span', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: AedText(1000),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.toPlainText(), '${AedCurrencyFormatter.symbol} 1,000.00');

    final TextSpan symbolSpan = root.children!.first as TextSpan;
    expect(symbolSpan.text, AedCurrencyFormatter.symbol);
    expect(symbolSpan.style?.fontFamily, AedCurrencyFormatter.symbolFontFamily);

    // The numeral must NOT carry the symbol font, since some bundled fonts
    // map digit codepoints to empty placeholder glyphs.
    final TextSpan numberSpan = root.children!.last as TextSpan;
    expect(numberSpan.text, ' 1,000.00');
    expect(numberSpan.style?.fontFamily,
        isNot(AedCurrencyFormatter.symbolFontFamily));
  });

  testWidgets('AedText preserves a caller-supplied style on the root span', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: AedText(1000, style: TextStyle(fontSize: 24)),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.style?.fontSize, 24);
  });

  testWidgets('AedText respects formatting options', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: AedText(-10, decimalDigits: 0, symbolSpacing: 2),
      ),
    );

    final Text textWidget = tester.widget(find.byType(Text));
    final TextSpan root = textWidget.textSpan! as TextSpan;
    expect(root.toPlainText(), '-${AedCurrencyFormatter.symbol}  10');
  });
}
