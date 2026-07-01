import 'package:flutter/widgets.dart';

import 'currency_negative_format.dart';
import 'currency_symbol_spans.dart';
import 'sar_currency_formatter_base.dart';

/// Displays [value] as Saudi Riyal currency text using the new Saudi Riyal
/// symbol, with the bundled [SarCurrencyFormatter.symbolFontFamily] font
/// automatically applied so the glyph renders correctly with zero setup.
class SarText extends StatelessWidget {
  const SarText(
    this.value, {
    super.key,
    this.decimalDigits = 2,
    this.locale = 'en_SA',
    this.symbolSpacing = 1,
    this.compact = false,
    this.negativeFormat = CurrencyNegativeFormat.minusSign,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  /// The value to format; must be an [int], [double], [num], or a numeric
  /// [String].
  final dynamic value;

  /// Number of digits to show after the decimal point.
  final int decimalDigits;

  /// The locale used for digit grouping and decimal separators.
  final String locale;

  /// Number of space characters placed between the symbol and the numeral.
  final int symbolSpacing;

  /// Whether to use a compact representation (e.g. `1.2K`, `3.4M`).
  final bool compact;

  /// How negative amounts should be rendered.
  final CurrencyNegativeFormat negativeFormat;

  /// The base text style. [SarCurrencyFormatter.symbolFontFamily] is applied
  /// on top of this style so the Riyal glyph always renders correctly.
  final TextStyle? style;

  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final List<InlineSpan> spans = buildCurrencySymbolSpans(
      value: value,
      symbolText: SarCurrencyFormatter.symbol,
      symbolFontFamily: SarCurrencyFormatter.symbolFontFamily,
      decimalDigits: decimalDigits,
      locale: locale,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
    return Text.rich(
      TextSpan(style: style, children: spans),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
