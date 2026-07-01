import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

const String _s = AedCurrencyFormatter.symbol;

void main() {
  group('AedCurrencyFormatter.format', () {
    test('formats an int with default options ("AED" code)', () {
      expect(AedCurrencyFormatter.format(1000), 'AED 1,000.00');
    });

    test('formats a double with default options', () {
      expect(AedCurrencyFormatter.format(1250.75), 'AED 1,250.75');
    });

    test('formats a numeric String', () {
      expect(AedCurrencyFormatter.format('5000'), 'AED 5,000.00');
    });

    test('respects decimalDigits', () {
      expect(AedCurrencyFormatter.format(10, decimalDigits: 0), 'AED 10');
      expect(
        AedCurrencyFormatter.format(10, decimalDigits: 3),
        'AED 10.000',
      );
    });

    test('showSymbol renders the Dirham symbol instead of the code', () {
      expect(
        AedCurrencyFormatter.format(10, showSymbol: true, showCode: false),
        '$_s 10.00',
      );
    });

    test('showSymbol false and showCode false renders only the numeral', () {
      expect(
        AedCurrencyFormatter.format(10, showSymbol: false, showCode: false),
        '10.00',
      );
    });

    test('never allows the symbol and "AED" code together', () {
      expect(
        () => AedCurrencyFormatter(showSymbol: true, showCode: true),
        throwsA(isA<AssertionError>()),
      );
    });

    test('respects symbolSpacing', () {
      expect(
        AedCurrencyFormatter.format(10, symbolSpacing: 3),
        'AED   10.00',
      );
      expect(
        AedCurrencyFormatter.format(10, symbolSpacing: 0),
        'AED10.00',
      );
    });

    test('supports compact formatting', () {
      final String result = AedCurrencyFormatter.format(
        1500000,
        compact: true,
        decimalDigits: 1,
      );
      expect(result, startsWith('AED '));
      expect(result, contains('M'));
    });

    test('throws FormatException for invalid numeric strings', () {
      expect(
        () => AedCurrencyFormatter.format('not a number'),
        throwsFormatException,
      );
    });

    test('throws ArgumentError for unsupported types', () {
      expect(
        () => AedCurrencyFormatter.format(<String, dynamic>{}),
        throwsArgumentError,
      );
    });

    group('negative value handling', () {
      test('minusSign (default) places the sign before everything', () {
        expect(AedCurrencyFormatter.format(-10), '-AED 10.00');
      });

      test('parentheses wraps the amount', () {
        expect(
          AedCurrencyFormatter.format(
            -10,
            negativeFormat: CurrencyNegativeFormat.parentheses,
          ),
          '(AED 10.00)',
        );
      });

      test('trailing appends a minus sign at the end', () {
        expect(
          AedCurrencyFormatter.format(
            -10,
            negativeFormat: CurrencyNegativeFormat.trailing,
          ),
          'AED 10.00-',
        );
      });
    });
  });

  group('Reusable AedCurrencyFormatter instance', () {
    test('formatValue uses the configured options', () {
      const AedCurrencyFormatter formatter = AedCurrencyFormatter(
        decimalDigits: 0,
        showSymbol: true,
        showCode: false,
      );
      expect(formatter.formatValue(2500), '$_s 2,500');
    });
  });

  group('Extensions', () {
    test('int.toAed() defaults to the "AED" code', () {
      expect(1000.toAed(), 'AED 1,000.00');
    });

    test('double.toAed()', () {
      expect(1250.75.toAed(), 'AED 1,250.75');
    });

    test('String.toAedCurrency()', () {
      expect('5000'.toAedCurrency(), 'AED 5,000.00');
    });

    test('extensions accept the same options as the formatter', () {
      expect(
        1000.toAed(showSymbol: true, showCode: false, decimalDigits: 0),
        '$_s 1,000',
      );
    });
  });
}
