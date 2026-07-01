## 0.4.0

- Add generic, locale-driven currency support for every other world
  currency: `CurrencyFormatter`, `num.toCurrency()`,
  `String.toCurrencyText()`, and the `CurrencyText` widget. Resolves the
  currency from a locale (or the device's current locale), using this
  package's own country-to-currency table (`package:intl` alone doesn't
  reliably infer currency from locale) and `package:intl`'s currency data
  for symbols/decimal digits. Delegates to `AedCurrencyFormatter`/
  `AedText` or `SarCurrencyFormatter`/`SarText` automatically when the
  resolved currency is AED or SAR.
- Fix: `AedText`/`SarText` no longer apply the bundled symbol font to the
  whole formatted string. The Saudi Riyal font maps ASCII `0` to an empty
  placeholder glyph (an artifact of its generation), so doing so made every
  zero digit disappear (e.g. `SAR 1,250.75` rendered as `1,25 .75`). The
  font is now scoped to just the symbol character via `Text.rich`.

## 0.3.0

- Add Saudi Riyal support: `SarCurrencyFormatter`, `num.toSar()`,
  `String.toSarCurrency()`, and the `SarText` widget, mirroring the
  existing AED API. Bundles the new Saudi Riyal symbol font.
- **Breaking:** renamed `AedNegativeFormat` to `CurrencyNegativeFormat`,
  now shared between `AedCurrencyFormatter` and `SarCurrencyFormatter`.

## 0.2.0

- **Breaking:** this is now a Flutter package (requires the Flutter SDK) so
  it can bundle the official Dirham symbol font and expose it automatically
  to any app that depends on this package.
- Add the `AedText` widget: renders the Dirham symbol with the bundled font
  applied automatically, for zero-setup correct rendering in the UI.
- Add `AedCurrencyFormatter.symbolFontFamily` for applying the bundled font
  to your own `TextStyle`.

## 0.1.0

- Initial release.
- `AedCurrencyFormatter` class with `decimalDigits`, `locale`, `showSymbol`,
  `showCode`, `symbolSpacing`, `compact`, and `negativeFormat` options.
- `num.toAed()` and `String.toAedCurrency()` extension methods.
- Enforces the Central Bank of the UAE guideline: the Dirham symbol sits to
  the left of the numeral with configurable spacing, and the symbol and the
  "AED" code are never shown together.
- Defaults to `showCode: true` / `showSymbol: false` since the official
  Dirham symbol (`U+20C3`) isn't yet rendered by mainstream device fonts.
