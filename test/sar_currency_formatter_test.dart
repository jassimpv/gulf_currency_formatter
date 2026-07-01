import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

const String _s = SarCurrencyFormatter.symbol;

void main() {
  group('SarCurrencyFormatter.format', () {
    test('formats an int with default options ("SAR" code)', () {
      expect(SarCurrencyFormatter.format(1000), 'SAR 1,000.00');
    });

    test('formats a double with default options', () {
      expect(SarCurrencyFormatter.format(1250.75), 'SAR 1,250.75');
    });

    test('formats a numeric String', () {
      expect(SarCurrencyFormatter.format('5000'), 'SAR 5,000.00');
    });

    test('respects decimalDigits', () {
      expect(SarCurrencyFormatter.format(10, decimalDigits: 0), 'SAR 10');
    });

    test(
        'showSymbol renders the placeholder glyph character instead of the code',
        () {
      expect(
        SarCurrencyFormatter.format(10, showSymbol: true, showCode: false),
        '$_s 10.00',
      );
    });

    test('showSymbol false and showCode false renders only the numeral', () {
      expect(
        SarCurrencyFormatter.format(10, showSymbol: false, showCode: false),
        '10.00',
      );
    });

    test('never allows the symbol and "SAR" code together', () {
      expect(
        () => SarCurrencyFormatter(showSymbol: true, showCode: true),
        throwsA(isA<AssertionError>()),
      );
    });

    test('respects symbolSpacing', () {
      expect(
        SarCurrencyFormatter.format(10, symbolSpacing: 3),
        'SAR   10.00',
      );
    });

    test('supports compact formatting', () {
      final String result = SarCurrencyFormatter.format(
        1500000,
        compact: true,
        decimalDigits: 1,
      );
      expect(result, startsWith('SAR '));
      expect(result, contains('M'));
    });

    test('throws FormatException for invalid numeric strings', () {
      expect(
        () => SarCurrencyFormatter.format('not a number'),
        throwsFormatException,
      );
    });

    group('negative value handling', () {
      test('minusSign (default) places the sign before everything', () {
        expect(SarCurrencyFormatter.format(-10), '-SAR 10.00');
      });

      test('parentheses wraps the amount', () {
        expect(
          SarCurrencyFormatter.format(
            -10,
            negativeFormat: CurrencyNegativeFormat.parentheses,
          ),
          '(SAR 10.00)',
        );
      });

      test('trailing appends a minus sign at the end', () {
        expect(
          SarCurrencyFormatter.format(
            -10,
            negativeFormat: CurrencyNegativeFormat.trailing,
          ),
          'SAR 10.00-',
        );
      });
    });
  });

  group('Extensions', () {
    test('int.toSar() defaults to the "SAR" code', () {
      expect(1000.toSar(), 'SAR 1,000.00');
    });

    test('double.toSar()', () {
      expect(1250.75.toSar(), 'SAR 1,250.75');
    });

    test('String.toSarCurrency()', () {
      expect('5000'.toSarCurrency(), 'SAR 5,000.00');
    });
  });
}
