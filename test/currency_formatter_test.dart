import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('currencyCodeForLocale', () {
    test('resolves common locales to the correct ISO currency code', () {
      expect(currencyCodeForLocale('en_US'), 'USD');
      expect(currencyCodeForLocale('ja_JP'), 'JPY');
      expect(currencyCodeForLocale('de_DE'), 'EUR');
      expect(currencyCodeForLocale('en_GB'), 'GBP');
      expect(currencyCodeForLocale('en_IN'), 'INR');
      expect(currencyCodeForLocale('en_AE'), 'AED');
      expect(currencyCodeForLocale('ar_SA'), 'SAR');
    });

    test('accepts hyphenated locale tags', () {
      expect(currencyCodeForLocale('en-US'), 'USD');
      expect(currencyCodeForLocale('ar-SA'), 'SAR');
    });

    test('returns null when there is no region subtag', () {
      expect(currencyCodeForLocale('en'), isNull);
    });

    test('returns null for an unknown region', () {
      expect(currencyCodeForLocale('en_ZZ'), isNull);
    });
  });

  group('CurrencyFormatter', () {
    test('formats USD with the standard \$ symbol', () {
      expect(
        CurrencyFormatter.format(
          1000,
          locale: 'en_US',
          showSymbol: true,
          showCode: false,
        ),
        '\$ 1,000.00',
      );
    });

    test('formats JPY with 0 decimal digits by default', () {
      expect(CurrencyFormatter.format(1234, locale: 'ja_JP'), 'JPY 1,234');
    });

    test('formats KWD with 3 decimal digits by default', () {
      expect(CurrencyFormatter.format(1234, locale: 'en_KW'), 'KWD 1,234.000');
    });

    test('defaults to the "code" prefix, not the symbol', () {
      expect(CurrencyFormatter.format(1000, locale: 'en_US'), 'USD 1,000.00');
    });

    test('delegates AED to AedCurrencyFormatter semantics', () {
      expect(
        CurrencyFormatter.format(1000, locale: 'en_AE'),
        AedCurrencyFormatter.format(1000),
      );
    });

    test('delegates SAR to SarCurrencyFormatter semantics', () {
      // Use the same locale SarCurrencyFormatter defaults to ('en_SA'), so
      // this compares like with like rather than tripping over Arabic-locale
      // bidi marks that `intl` inserts for 'ar_SA'.
      expect(
        CurrencyFormatter.format(1000, locale: 'en_SA'),
        SarCurrencyFormatter.format(1000),
      );
    });

    test('falls back to USD for an unresolvable locale', () {
      expect(CurrencyFormatter.format(1000, locale: 'en_ZZ'), 'USD 1,000.00');
    });

    test('never allows the symbol and code together', () {
      expect(
        () => CurrencyFormatter(showSymbol: true, showCode: true),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('Extensions', () {
    test('num.toCurrency()', () {
      expect(1000.toCurrency(locale: 'en_GB'), 'GBP 1,000.00');
    });

    test('String.toCurrencyText()', () {
      expect('1000'.toCurrencyText(locale: 'en_GB'), 'GBP 1,000.00');
    });
  });
}
