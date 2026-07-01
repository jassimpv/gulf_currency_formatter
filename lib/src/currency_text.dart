import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'aed_text.dart';
import 'currency_format_core.dart';
import 'currency_locale_data.dart';
import 'currency_negative_format.dart';
import 'mvr_text.dart';
import 'omr_text.dart';
import 'sar_text.dart';

/// Displays [value] as currency text for any world currency, resolving the
/// currency from [locale] (or the device's current locale when [locale] is
/// omitted).
///
/// Delegates internally for AED, SAR, OMR, and MVR when those currencies are
/// resolved, so their official symbols render correctly with the
/// bundled fonts. Every other currency's symbol (e.g. `$`, `€`, `¥`) is
/// plain Unicode text and needs no special font.
class CurrencyText extends StatelessWidget {
  const CurrencyText(
    this.value, {
    super.key,
    this.locale,
    this.decimalDigits,
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

  /// The locale used to resolve the currency and drive number formatting.
  /// Defaults to the device's current locale when null.
  final String? locale;

  /// Number of digits to show after the decimal point. Defaults to the
  /// resolved currency's own convention when null.
  final int? decimalDigits;

  /// Number of space characters placed between the symbol and the numeral.
  final int symbolSpacing;

  /// Whether to use a compact representation (e.g. `1.2K`, `3.4M`).
  final bool compact;

  /// How negative amounts should be rendered.
  final CurrencyNegativeFormat negativeFormat;

  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final String loc = locale ?? systemLocale();
    final String currencyCode = currencyCodeForLocale(loc) ?? 'USD';

    if (currencyCode == 'AED') {
      return AedText(
        value,
        decimalDigits: decimalDigits ?? 2,
        locale: loc,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      );
    }
    if (currencyCode == 'SAR') {
      return SarText(
        value,
        decimalDigits: decimalDigits ?? 2,
        locale: loc,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      );
    }
    if (currencyCode == 'OMR') {
      return OmrText(
        value,
        decimalDigits: decimalDigits ?? 3,
        locale: loc,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      );
    }
    if (currencyCode == 'MVR') {
      return MvrText(
        value,
        decimalDigits: decimalDigits ?? 2,
        locale: loc,
        symbolSpacing: symbolSpacing,
        compact: compact,
        negativeFormat: negativeFormat,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
      );
    }
    final NumberFormat probe = withLocaleFallback(
      loc,
      (String locale) =>
          NumberFormat.simpleCurrency(locale: locale, name: currencyCode),
    );
    final String text = formatCurrencyValue(
      value,
      symbolText: probe.currencySymbol,
      codeText: currencyCode,
      decimalDigits: decimalDigits ?? probe.decimalDigits ?? 2,
      locale: loc,
      showSymbol: true,
      showCode: false,
      symbolSpacing: symbolSpacing,
      compact: compact,
      negativeFormat: negativeFormat,
    );
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
