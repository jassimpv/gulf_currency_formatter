import 'package:intl/intl.dart';

import 'currency_negative_format.dart';

/// The numeral part of a formatted currency value, and whether the original
/// amount was negative (the sign/wrapping is applied separately so widgets
/// can style the symbol independently from the numeral).
typedef CurrencyParts = ({String numberPart, bool isNegative});

/// Shared numeral-formatting engine behind [AedCurrencyFormatter],
/// [SarCurrencyFormatter], and the generic currency formatter. Not exported;
/// only the currency symbol/code differ between currencies, so the
/// formatting logic lives here once.
CurrencyParts formatCurrencyParts(
  dynamic value, {
  required int decimalDigits,
  required String locale,
  required bool compact,
}) {
  final num amount = toNumOrThrow(value);
  final bool isNegative = amount < 0;
  final num absAmount = amount.abs();

  final NumberFormat numberFormat = compact
      ? NumberFormat.compactCurrency(
          locale: locale,
          symbol: '',
          decimalDigits: decimalDigits,
        )
      : NumberFormat.currency(
          locale: locale,
          symbol: '',
          decimalDigits: decimalDigits,
        );
  return (
    numberPart: numberFormat.format(absAmount).trim(),
    isNegative: isNegative,
  );
}

/// Formats [value] as a full currency string, combining the symbol/code
/// prefix, the numeral, and any negative-value wrapping.
String formatCurrencyValue(
  dynamic value, {
  required String symbolText,
  required String codeText,
  required int decimalDigits,
  required String locale,
  required bool showSymbol,
  required bool showCode,
  required int symbolSpacing,
  required bool compact,
  required CurrencyNegativeFormat negativeFormat,
}) {
  final CurrencyParts parts = formatCurrencyParts(
    value,
    decimalDigits: decimalDigits,
    locale: locale,
    compact: compact,
  );

  final String spacing = ' ' * symbolSpacing;
  final String prefix = showSymbol
      ? '$symbolText$spacing'
      : (showCode ? '$codeText$spacing' : '');
  final String body = '$prefix${parts.numberPart}';

  if (!parts.isNegative) return body;

  switch (negativeFormat) {
    case CurrencyNegativeFormat.minusSign:
      return '-$body';
    case CurrencyNegativeFormat.parentheses:
      return '($body)';
    case CurrencyNegativeFormat.trailing:
      return '$body-';
  }
}

/// Parses [value] (an [int], [double], [num], or numeric [String]) into a
/// [num], throwing if it can't be interpreted as one.
num toNumOrThrow(dynamic value) {
  if (value is num) return value;
  if (value is String) {
    final num? parsed = num.tryParse(value.trim());
    if (parsed == null) {
      throw FormatException(
        'Cannot parse "$value" as a number for currency formatting.',
      );
    }
    return parsed;
  }
  throw ArgumentError.value(
    value,
    'value',
    'Must be an int, double, num, or numeric String.',
  );
}
