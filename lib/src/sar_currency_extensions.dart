import 'currency_negative_format.dart';
import 'sar_currency_formatter_base.dart';

/// Saudi Riyal currency formatting for [num] (and therefore [int] and
/// [double]).
extension SarNumFormatting on num {
  /// Formats this number as Saudi Riyal currency text.
  ///
  /// Example: `1000.toSar()` -> `"SAR 1,000.00"`
  String toSar({
    int decimalDigits = 2,
    String locale = 'en_SA',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return SarCurrencyFormatter.format(
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

/// Saudi Riyal currency formatting for numeric [String]s.
extension SarStringFormatting on String {
  /// Parses this string as a number and formats it as Saudi Riyal currency
  /// text.
  ///
  /// Example: `"5000".toSarCurrency()` -> `"SAR 5,000.00"`
  ///
  /// Throws a [FormatException] if this string is not a valid number.
  String toSarCurrency({
    int decimalDigits = 2,
    String locale = 'en_SA',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return SarCurrencyFormatter.format(
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
