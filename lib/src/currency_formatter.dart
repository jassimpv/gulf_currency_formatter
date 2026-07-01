import 'package:intl/intl.dart';

import 'aed_currency_formatter_base.dart';
import 'currency_format_core.dart';
import 'currency_locale_data.dart';
import 'currency_negative_format.dart';
import 'sar_currency_formatter_base.dart';

/// Formats numeric values as currency text for any world currency,
/// resolving the currency from [locale] (or the device's current locale
/// when [locale] is omitted).
///
/// UAE Dirham and Saudi Riyal are special-cased to delegate to
/// [AedCurrencyFormatter] and [SarCurrencyFormatter], since those two
/// currencies use this package's bundled custom symbol fonts. Every other
/// currency uses `package:intl`'s standard currency data.
///
/// As with [AedCurrencyFormatter] and [SarCurrencyFormatter], defaults to
/// [showCode] rather than [showSymbol]: this formatter may resolve to AED
/// or SAR depending on the locale, and their symbols require the bundled
/// font from a `Text` widget to render correctly. Use `CurrencyText` for
/// zero-setup symbol rendering in the UI.
class CurrencyFormatter {
  /// The locale used to resolve the currency and to drive number formatting
  /// conventions (digit grouping, decimal separator). Defaults to the
  /// device's current locale (via `dart:ui`'s `PlatformDispatcher`) when null.
  final String? locale;

  /// Number of digits to show after the decimal point. Defaults to the
  /// resolved currency's own convention (e.g. `0` for JPY, `3` for KWD,
  /// `2` otherwise) when null.
  final int? decimalDigits;

  /// Whether to prefix the amount with the currency symbol.
  final bool showSymbol;

  /// Whether to prefix the amount with the ISO currency code.
  final bool showCode;

  /// Number of space characters placed between the symbol/code and the numeral.
  final int symbolSpacing;

  /// Whether to use a compact representation (e.g. `1.2K`, `3.4M`).
  final bool compact;

  /// How negative amounts should be rendered.
  final CurrencyNegativeFormat negativeFormat;

  /// Creates a reusable, configured generic currency formatter.
  const CurrencyFormatter({
    this.locale,
    this.decimalDigits,
    this.showSymbol = false,
    this.showCode = true,
    this.symbolSpacing = 1,
    this.compact = false,
    this.negativeFormat = CurrencyNegativeFormat.minusSign,
  }) : assert(
          !(showSymbol && showCode),
          'A currency symbol and code must never be shown together. Set '
          'only one of showSymbol / showCode to true.',
        );

  /// The locale used for currency resolution and number formatting: either
  /// the explicit [locale], or the device's current locale.
  String get resolvedLocale => locale ?? systemLocale();

  /// The resolved ISO 4217 currency code, falling back to `USD` if it can't
  /// be determined from [resolvedLocale].
  String get resolvedCurrencyCode =>
      currencyCodeForLocale(resolvedLocale) ?? 'USD';

  /// Formats [value] using this formatter's configured options.
  ///
  /// [value] must be an [int], [double], [num], or a numeric [String].
  String formatValue(dynamic value) {
    final String currencyCode = resolvedCurrencyCode;
    final String loc = resolvedLocale;

    if (currencyCode == 'AED') {
      return AedCurrencyFormatter(
        decimalDigits: decimalDigits ?? 2,
        locale: loc,
        showSymbol: showSymbol,
        showCode: showCode,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
      ).formatValue(value);
    }
    if (currencyCode == 'SAR') {
      return SarCurrencyFormatter(
        decimalDigits: decimalDigits ?? 2,
        locale: loc,
        showSymbol: showSymbol,
        showCode: showCode,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
      ).formatValue(value);
    }

    final NumberFormat probe = NumberFormat.simpleCurrency(
      locale: loc,
      name: currencyCode,
    );
    return formatCurrencyValue(
      value,
      symbolText: probe.currencySymbol,
      codeText: currencyCode,
      decimalDigits: decimalDigits ?? probe.decimalDigits ?? 2,
      locale: loc,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }

  /// Formats [value] as currency text using default or supplied options.
  ///
  /// This is a convenience for one-off formatting; use the constructor
  /// instead when reusing the same options repeatedly.
  static String format(
    dynamic value, {
    String? locale,
    int? decimalDigits,
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return CurrencyFormatter(
      locale: locale,
      decimalDigits: decimalDigits,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    ).formatValue(value);
  }
}
