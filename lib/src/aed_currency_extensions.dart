import 'aed_currency_formatter_base.dart';
import 'currency_negative_format.dart';

/// AED currency formatting for [num] (and therefore [int] and [double]).
extension AedNumFormatting on num {
  /// Formats this number as UAE Dirham currency text.
  ///
  /// Example: `1000.toAed()` -> `"AED 1,000.00"`
  String toAed({
    int decimalDigits = 2,
    String locale = 'en_AE',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return AedCurrencyFormatter.format(
      this,
      decimalDigits: decimalDigits,
      locale: locale,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }
}

/// AED currency formatting for numeric [String]s.
extension AedStringFormatting on String {
  /// Parses this string as a number and formats it as UAE Dirham currency text.
  ///
  /// Example: `"5000".toAedCurrency()` -> `"AED 5,000.00"`
  ///
  /// Throws a [FormatException] if this string is not a valid number.
  String toAedCurrency({
    int decimalDigits = 2,
    String locale = 'en_AE',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return AedCurrencyFormatter.format(
      this,
      decimalDigits: decimalDigits,
      locale: locale,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }
}
