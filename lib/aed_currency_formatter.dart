/// Format int, double, num, and String values as currency text and widgets.
///
/// UAE Dirham (AED) and Saudi Riyal (SAR) are supported with their official,
/// newly-introduced symbols via bundled fonts. Every other world currency is
/// supported generically, resolved from a locale (or the device's current
/// locale) using `package:intl`'s standard currency data.
library aed_currency_formatter;

export 'src/aed_currency_extensions.dart';
export 'src/aed_currency_formatter_base.dart';
export 'src/aed_text.dart';
export 'src/currency_extensions.dart';
export 'src/currency_formatter.dart';
export 'src/currency_locale_data.dart' show currencyCodeForLocale, systemLocale;
export 'src/currency_negative_format.dart';
export 'src/currency_text.dart';
export 'src/sar_currency_extensions.dart';
export 'src/sar_currency_formatter_base.dart';
export 'src/sar_text.dart';
