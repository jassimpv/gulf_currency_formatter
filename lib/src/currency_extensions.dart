import 'currency_formatter.dart';
import 'currency_negative_format.dart';

/// Generic, locale-driven currency formatting for [num] (and therefore
/// [int] and [double]).
extension CurrencyNumFormatting on num {
  /// Formats this number as currency text, resolving the currency from
  /// [locale] (or the device's current locale when omitted).
  ///
  /// Example: `1000.toCurrency(locale: 'en_US')` -> `"USD 1,000.00"`
  String toCurrency({
    String? locale,
    int? decimalDigits,
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return CurrencyFormatter.format(
      this,
      locale: locale,
      decimalDigits: decimalDigits,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }
}

/// Generic, locale-driven currency formatting for numeric [String]s.
extension CurrencyStringFormatting on String {
  /// Parses this string as a number and formats it as currency text,
  /// resolving the currency from [locale] (or the device's current locale
  /// when omitted).
  ///
  /// Example: `"5000".toCurrencyText(locale: 'ja_JP')` -> `"JPY 5,000"`
  ///
  /// Throws a [FormatException] if this string is not a valid number.
  String toCurrencyText({
    String? locale,
    int? decimalDigits,
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return CurrencyFormatter.format(
      this,
      locale: locale,
      decimalDigits: decimalDigits,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }
}
