/// Format int, double, num, and String values as currency text and widgets.
///
/// UAE Dirham (AED), Saudi Riyal (SAR), and Omani Rial (OMR) are supported
/// with their official symbols via bundled fonts. Every other world currency
/// is supported generically, resolved from a locale (or the device's current
/// locale) using
/// `package:intl`'s standard currency data.
library gulf_currency_formatter;

export 'src/currency_locale_data.dart' show currencyCodeForLocale, systemLocale;
export 'src/currency_negative_format.dart';
export 'src/currency_text.dart';
