import 'currency_format_core.dart';
import 'currency_negative_format.dart';

/// Formats numeric values as Saudi Riyal currency text, using the new
/// Saudi Riyal symbol introduced by the Saudi Central Bank (SAMA) in 2025.
///
/// Defaults to [showCode] (`"SAR"`) rather than [showSymbol]: the new
/// symbol doesn't have a permanent Unicode codepoint yet, so this package's
/// bundled font ([symbolFontFamily]) maps it onto the placeholder character
/// [symbol] (`#`). Outside a widget styled with that font, [symbol] would
/// just render as a literal `#`. Use the `SarText` widget for zero-setup
/// rendering of the symbol, or pass `showSymbol: true, showCode: false` and
/// apply [symbolFontFamily] to your own `TextStyle` yourself.
class SarCurrencyFormatter {
  /// The placeholder character the bundled [symbolFontFamily] font maps to
  /// the Saudi Riyal glyph.
  ///
  /// This is a plain `#` outside of a widget using [symbolFontFamily] -- it
  /// only renders as the Riyal symbol when styled with that font.
  static const String symbol = '#';

  /// The ISO-style currency code, used when the symbol font isn't applied.
  static const String code = 'SAR';

  /// The font family bundled with this package that maps [symbol] (`#`) to
  /// the Saudi Riyal glyph. Apply it via `TextStyle(fontFamily:
  /// SarCurrencyFormatter.symbolFontFamily)`, or use `SarText`, which does
  /// this automatically.
  ///
  /// Flutter namespaces fonts a package declares in its own pubspec.yaml as
  /// `packages/<package_name>/<family>`, so this is *not* just
  /// `'SaudiRiyal'`.
  static const String symbolFontFamily =
      'packages/aed_currency_formatter/SaudiRiyal';

  /// Number of digits to show after the decimal point.
  final int decimalDigits;

  /// The locale used for digit grouping and decimal separators.
  final String locale;

  /// Whether to prefix the amount with the Riyal [symbol].
  final bool showSymbol;

  /// Whether to prefix the amount with the "SAR" [code] instead of the symbol.
  final bool showCode;

  /// Number of space characters placed between the symbol/code and the numeral.
  final int symbolSpacing;

  /// Whether to use a compact representation (e.g. `1.2K`, `3.4M`).
  final bool compact;

  /// How negative amounts should be rendered.
  final CurrencyNegativeFormat negativeFormat;

  /// Creates a reusable, configured SAR currency formatter.
  ///
  /// Throws an [AssertionError] in debug mode if both [showSymbol] and
  /// [showCode] are `true`.
  const SarCurrencyFormatter({
    this.decimalDigits = 2,
    this.locale = 'en_SA',
    this.showSymbol = false,
    this.showCode = true,
    this.symbolSpacing = 1,
    this.compact = false,
    this.negativeFormat = CurrencyNegativeFormat.minusSign,
  })  : assert(decimalDigits >= 0, 'decimalDigits cannot be negative'),
        assert(symbolSpacing >= 0, 'symbolSpacing cannot be negative'),
        assert(
          !(showSymbol && showCode),
          'The Riyal symbol and the "SAR" code must never be shown '
          'together. Set only one of showSymbol / showCode to true.',
        );

  /// Formats [value] using this formatter's configured options.
  ///
  /// [value] must be an [int], [double], [num], or a numeric [String].
  String formatValue(dynamic value) {
    return formatCurrencyValue(
      value,
      symbolText: symbol,
      codeText: code,
      decimalDigits: decimalDigits,
      locale: locale,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
  }

  /// Formats [value] as SAR currency text using default or supplied options.
  ///
  /// This is a convenience for one-off formatting; use the constructor
  /// instead when reusing the same options repeatedly.
  static String format(
    dynamic value, {
    int decimalDigits = 2,
    String locale = 'en_SA',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return SarCurrencyFormatter(
      decimalDigits: decimalDigits,
      locale: locale,
      showSymbol: showSymbol,
      showCode: showCode,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    ).formatValue(value);
  }
}
