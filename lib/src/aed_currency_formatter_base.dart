import 'currency_format_core.dart';
import 'currency_negative_format.dart';

/// Formats numeric values as UAE Dirham currency text, following the
/// Central Bank of the UAE Dirham currency symbol guideline:
/// https://www.centralbank.ae/media/jlhi41xu/dirham_currency_symbol_guideline_english.pdf
///
/// Per the guideline the symbol always sits to the left of the numeral
/// with clear spacing, and the symbol is never combined with the "AED"
/// code in the same string.
///
/// Defaults to [showCode] (`"AED"`) rather than [showSymbol]: as plain text,
/// the official symbol (Unicode `U+20C3`) needs a font that maps that
/// codepoint to the Dirham glyph, and mainstream device fonts won't ship
/// one until Unicode 18.0 (September 2026). This package bundles that font
/// (family [symbolFontFamily]) for Flutter apps: use the `AedText` widget
/// for zero-setup rendering of the symbol, or pass
/// `showSymbol: true, showCode: false` and apply [symbolFontFamily] to your
/// own `TextStyle` yourself.
class AedCurrencyFormatter {
  /// The official UAE Dirham currency symbol (Unicode U+20C3).
  ///
  /// Requires a font that maps this codepoint to the Dirham glyph, such as
  /// the bundled [symbolFontFamily], to render correctly.
  static const String symbol = '⃃';

  /// The ISO-style currency code, used when a symbol font isn't available.
  static const String code = 'AED';

  /// The font family bundled with this package that maps `U+20C3` to the
  /// official Dirham glyph. Apply it via `TextStyle(fontFamily:
  /// AedCurrencyFormatter.symbolFontFamily)`, or use `AedText`, which does
  /// this automatically.
  ///
  /// Flutter namespaces fonts a package declares in its own pubspec.yaml as
  /// `packages/<package_name>/<family>`, so this is *not* just `'Dirham'`.
  static const String symbolFontFamily =
      'packages/aed_currency_formatter/Dirham';

  /// Number of digits to show after the decimal point.
  final int decimalDigits;

  /// The locale used for digit grouping and decimal separators.
  final String locale;

  /// Whether to prefix the amount with the Dirham [symbol].
  final bool showSymbol;

  /// Whether to prefix the amount with the "AED" [code] instead of the symbol.
  final bool showCode;

  /// Number of space characters placed between the symbol/code and the numeral.
  final int symbolSpacing;

  /// Whether to use a compact representation (e.g. `1.2K`, `3.4M`).
  final bool compact;

  /// How negative amounts should be rendered.
  final CurrencyNegativeFormat negativeFormat;

  /// Creates a reusable, configured AED currency formatter.
  ///
  /// Throws an [AssertionError] in debug mode if both [showSymbol] and
  /// [showCode] are `true`, since the guideline forbids showing the symbol
  /// and the "AED" code together.
  const AedCurrencyFormatter({
    this.decimalDigits = 2,
    this.locale = 'en_AE',
    this.showSymbol = false,
    this.showCode = true,
    this.symbolSpacing = 1,
    this.compact = false,
    this.negativeFormat = CurrencyNegativeFormat.minusSign,
  })  : assert(decimalDigits >= 0, 'decimalDigits cannot be negative'),
        assert(symbolSpacing >= 0, 'symbolSpacing cannot be negative'),
        assert(
          !(showSymbol && showCode),
          'The Dirham symbol and the "AED" code must never be shown '
          'together (Central Bank of the UAE guideline). Set only one of '
          'showSymbol / showCode to true.',
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

  /// Formats [value] as AED currency text using default or supplied options.
  ///
  /// This is a convenience for one-off formatting; use the constructor
  /// instead when reusing the same options repeatedly.
  static String format(
    dynamic value, {
    int decimalDigits = 2,
    String locale = 'en_AE',
    bool showSymbol = false,
    bool showCode = true,
    int symbolSpacing = 1,
    bool compact = false,
    CurrencyNegativeFormat negativeFormat = CurrencyNegativeFormat.minusSign,
  }) {
    return AedCurrencyFormatter(
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
