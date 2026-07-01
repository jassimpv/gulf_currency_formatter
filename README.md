# aed_currency_formatter

Format `int`, `double`, `num`, and numeric `String` values as currency text
and widgets. UAE Dirham (AED) and Saudi Riyal (SAR) get first-class support
for their official, newly-introduced symbols:

- [UAE Dirham currency symbol guideline](https://www.centralbank.ae/media/jlhi41xu/dirham_currency_symbol_guideline_english.pdf) (Central Bank of the UAE)
- The new Saudi Riyal symbol, introduced by the Saudi Central Bank (SAMA) in 2025

Every other world currency is also supported, resolved generically from a
locale (or the device's current locale) using `package:intl`'s currency data.

This is a **Flutter package**: it bundles both official AED/SAR symbol
fonts, so those glyphs render correctly in any Flutter app with zero setup.

## Guideline compliance

- Each symbol is always placed **to the left** of the numeral.
- Configurable spacing keeps a clear gap between the symbol and the numeral.
- A symbol and its currency code are **never shown together** — enabling
  both `showSymbol` and `showCode` throws an error.
- **Plain-text APIs (`toAed()`/`toAedCurrency()`/`AedCurrencyFormatter`,
  `toSar()`/`toSarCurrency()`/`SarCurrencyFormatter`,
  `toCurrency()`/`toCurrencyText()`/`CurrencyFormatter`) default to the
  currency code, not the symbol.**
  - The Dirham symbol (`AedCurrencyFormatter.symbol`, Unicode `U+20C3`) was
    accepted by the Unicode Technical Committee for Unicode 18.0
    (September 2026); outside a widget styled with the bundled font, it
    renders as a missing-glyph box.
  - The Riyal symbol doesn't have a permanent Unicode codepoint yet, so the
    bundled font maps it onto a placeholder character
    (`SarCurrencyFormatter.symbol`, `'#'`); outside a widget styled with
    that font, it would just look like a literal `#`.
  - `CurrencyFormatter` may resolve to AED or SAR depending on the locale,
    inheriting the same caveat.
- **The `AedText`, `SarText`, and `CurrencyText` widgets default to the
  symbol** and apply the correct font automatically, since only a widget
  can guarantee correct rendering.

## Getting started

```yaml
dependencies:
  aed_currency_formatter: ^0.3.0
```

```dart
import 'package:aed_currency_formatter/aed_currency_formatter.dart';
```

## Usage

### AedText / SarText widgets (recommended for UI)

Render the official symbol with the bundled font applied automatically —
no font setup required:

```dart
AedText(1250.75); // displays: ⃃ 1,250.75, using the bundled Dirham font
SarText(1250.75); // displays the Saudi Riyal symbol, using the bundled font

AedText(
  -10,
  negativeFormat: CurrencyNegativeFormat.parentheses,
  style: TextStyle(fontSize: 20),
);
```

### CurrencyText widget (any other currency)

Resolves the currency from a locale — or the device's current locale, if
omitted — and renders it, delegating to `AedText`/`SarText` automatically
when the resolved currency is AED or SAR:

```dart
CurrencyText(1250.75); // uses the device's current locale
CurrencyText(1250.75, locale: 'en_US'); // '$1,250.75'
CurrencyText(1250, locale: 'ja_JP');    // '¥1,250' (0 decimal digits, per JPY)
CurrencyText(1250.75, locale: 'en_AE'); // delegates to AedText automatically
```

### Extension methods (plain text)

Useful for logs, PDFs, or anywhere outside a styled `Text` widget. Default
to the currency code, since plain strings can't carry font information:

```dart
1000.toAed();           // 'AED 1,000.00'
1250.75.toAed();        // 'AED 1,250.75'
'5000'.toAedCurrency(); // 'AED 5,000.00'

1000.toSar();           // 'SAR 1,000.00'
1250.75.toSar();        // 'SAR 1,250.75'
'5000'.toSarCurrency(); // 'SAR 5,000.00'

1000.toCurrency(locale: 'en_US');           // 'USD 1,000.00'
'1000'.toCurrencyText(locale: 'ja_JP');     // 'JPY 1,000'
1000.toCurrency(); // resolves the currency from the device's current locale
```

### Formatter classes

```dart
// One-off formatting with the static helpers.
AedCurrencyFormatter.format(1000);      // 'AED 1,000.00'
SarCurrencyFormatter.format(1000);      // 'SAR 1,000.00'
CurrencyFormatter.format(1000, locale: 'en_GB'); // 'GBP 1,000.00'

// A reusable, configured formatter.
const formatter = AedCurrencyFormatter(
  decimalDigits: 0,
  showCode: true,
  showSymbol: false,
);
formatter.formatValue(2500); // 'AED 2,500'
```

### Using a symbol outside AedText / SarText

If you build your own `Text` widget instead of using `AedText`/`SarText`,
apply the bundled font explicitly via `symbolFontFamily` (note Flutter
namespaces package fonts as `packages/<package>/<family>`), and scope it to
just the symbol character — some bundled fonts map ordinary codepoints
(like ASCII digits) to empty placeholder glyphs, so applying the font to
the whole string can make digits disappear:

```dart
Text.rich(
  TextSpan(children: [
    TextSpan(
      text: AedCurrencyFormatter.symbol,
      style: TextStyle(fontFamily: AedCurrencyFormatter.symbolFontFamily),
    ),
    const TextSpan(text: ' 1,000.00'),
  ]),
);
```

### How currencies are resolved from a locale

`CurrencyFormatter` and `CurrencyText` resolve a locale's region subtag
(e.g. the `SA` in `ar_SA`) to an ISO 4217 currency code using this
package's own country/currency table — `package:intl` alone doesn't
reliably infer the correct currency from a locale (it resolves `ar_SA` to
Egyptian Pound and `en_AE` to US Dollar, for example). You can use this
resolution directly:

```dart
currencyCodeForLocale('en_GB'); // 'GBP'
systemLocale(); // the device's current locale, e.g. 'en_US'
```

### Options

All options below are available on `AedCurrencyFormatter` /
`SarCurrencyFormatter` / `CurrencyFormatter`, their static `format` methods,
and all extension methods. `AedText` / `SarText` / `CurrencyText` accept
the same options except `showSymbol` / `showCode` (they always show the
symbol) and `CurrencyFormatter`/`CurrencyText` additionally accept `locale`
as nullable (device locale when omitted) and `decimalDigits` as nullable
(currency's own default when omitted).

| Option           | Type                     | Default                            | Description                                                             |
| ---------------- | ------------------------ | ----------------------------------- | ------------------------------------------------------------------------ |
| `decimalDigits`  | `int`                    | `2`                                  | Number of digits after the decimal point.                                |
| `locale`         | `String`                 | `'en_AE'` / `'en_SA'`                | Locale used for digit grouping and decimal separators.                    |
| `showSymbol`     | `bool`                   | `false`                              | Prefix the amount with the currency symbol.                              |
| `showCode`       | `bool`                   | `true`                               | Prefix the amount with the currency code (`"AED"` / `"SAR"` / ISO code). |
| `symbolSpacing`  | `int`                    | `1`                                  | Number of spaces between the symbol/code and the numeral.                |
| `compact`        | `bool`                   | `false`                              | Use compact notation, e.g. `AED 1.2M`.                                   |
| `negativeFormat` | `CurrencyNegativeFormat` | `CurrencyNegativeFormat.minusSign`   | How negative values are rendered: `minusSign`, `parentheses`, `trailing`. |

`showSymbol` and `showCode` cannot both be `true` at the same time.

### Negative values

```dart
(-10).toAed(); // '-AED 10.00'

(-10).toAed(negativeFormat: CurrencyNegativeFormat.parentheses); // '(AED 10.00)'

(-10).toAed(negativeFormat: CurrencyNegativeFormat.trailing); // 'AED 10.00-'
```

### Compact format

```dart
1500000.toAed(compact: true, decimalDigits: 1); // 'AED 1.5M'
1500000.toSar(compact: true, decimalDigits: 1); // 'SAR 1.5M'
```

### Hiding the symbol and code

```dart
1000.toAed(showSymbol: false, showCode: false); // '1,000.00'
```

## Additional information

See `example/` for a runnable Flutter app demonstrating `AedText`,
`SarText`, `CurrencyText`, and the plain-text APIs side by side.

Contributions and issues are welcome. Please make sure `flutter test` and
`flutter analyze` pass before submitting a pull request.
