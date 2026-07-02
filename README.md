# gulf_currency

A Flutter currency text package for real apps.

It formats int, double, num, and numeric String values as currency widgets, with built-in symbol-font support for:

- AED (UAE Dirham)
- SAR (Saudi Riyal)
- OMR (Omani Rial)
- MVR (Maldivian Rufiyaa)

All other currencies are also supported through locale-driven ISO currency resolution.

## Articles

- [Solving the AED, SAR, and OMR Symbol Problem in Flutter](https://medium.com/p/f668b017596a)

## Unicode status (important)

- AED symbol: officially accepted for Unicode 18.0, but not reliably available in mainstream device fonts yet.
- OMR symbol: scheduled for Unicode 18.0, but not reliably available in mainstream device fonts yet.
- MVR symbol: scheduled for Unicode 18.0, but not reliably available in mainstream device fonts yet.
- SAR symbol: no permanent Unicode codepoint yet.

Because of this, this package bundles the required fonts so AED, SAR, OMR, and MVR symbols can render correctly in Flutter UI today.

## Font files used

This package supports all world currencies through locale-based formatting.
The bundled font files below are specifically for official symbol rendering of AED, SAR, OMR, and MVR:

- AED (Dirham): lib/fonts/dirham/dirham.ttf
- SAR (Saudi Riyal): lib/fonts/saudi_riyal/saudi-riyal-symbol.ttf
- OMR (Omani Rial): lib/fonts/omani_rial/omani-rial-symbol.ttf
- MVR (Maldivian Rufiyaa): lib/fonts/mvr_rufiyaa/mvr-rufiyaa-symbol.ttf

## Search keywords 

This package is useful if you are searching for:

- UAE Dirham symbol Flutter
- AED symbol not showing
- Saudi Riyal symbol Flutter
- SAR currency symbol font
- Omani Rial symbol Flutter
- OMR symbol Unicode support
- Maldivian Rufiyaa symbol Flutter
- MVR currency symbol font
- Gulf currency symbol package Flutter
- Arabic currency symbol Flutter

## Why this package

- CurrencyText auto-resolves currency from locale.
- AED, SAR, OMR, and MVR symbols render with bundled fonts out of the box.
- Great for UI currency display with locale-aware formatting.

## Install

Add this to pubspec.yaml:

```yaml
dependencies:
  gulf_currency: ^2.0.0
```

Then import:

```dart
import 'package:gulf_currency/gulf_currency.dart';
```

## Quick start

### Widget usage (recommended)

```dart
CurrencyText(1250.75, locale: 'en_AE');
CurrencyText(1250.75, locale: 'ar_SA');
CurrencyText(1250.75, locale: 'en_OM');
CurrencyText(1250.75, locale: 'en_MV');
CurrencyText(1250.75, locale: 'en_US');
```

### CurrencyPicker

A dropdown for picking a currency, showing each option's country flag next to its ISO 4217 code:

```dart
CurrencyPicker(
  value: selectedCurrencyCode,
  onChanged: (code) => setState(() => selectedCurrencyCode = code),
);
```

Customization options:

- `options`: restrict the list to a subset of `CurrencyOption`s (defaults to `allCurrencyOptions`, every currency this package knows about).
- `label`: the field's label text (defaults to `'Currency'`).
- `decoration`: full `InputDecoration` override for the field's chrome (border, fill, padding); overrides `label` when set.
- `style`: `TextStyle` applied to each option's currency code.
- `dropdownColor`: background color of the open menu.
- `borderRadius`: corner radius of the field and open menu (defaults to 12).
- `showFlag`: set to `false` to hide the flag and show just the code.
- `itemBuilder`: `Widget Function(BuildContext, CurrencyOption)` for full control over each row's contents.

```dart
CurrencyPicker(
  value: selectedCurrencyCode,
  onChanged: (code) => setState(() => selectedCurrencyCode = code),
  options: <CurrencyOption>[
    const CurrencyOption(currencyCode: 'AED', countryCode: 'AE'),
    const CurrencyOption(currencyCode: 'USD', countryCode: 'US'),
  ],
  decoration: const InputDecoration(border: InputBorder.none),
  dropdownColor: Colors.white,
  itemBuilder: (context, option) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(option.flag),
      const SizedBox(width: 8),
      Text(option.currencyCode, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
```

## Web run screenshot (folder and file name)

When you upload your Flutter web run screenshot, put it in this exact location:

- Folder: assets/screenshots/
- File name: web-run.png
- Full path: assets/screenshots/web-run.png

Screenshot:

![Flutter Web Run Screenshot](assets/screenshots/web-run.png)

## Example app

Run the example:

```bash
cd example
flutter run -d chrome
```

## CurrencyText options

Main options available on CurrencyText:

- decimalDigits
- symbolSpacing
- compact
- negativeFormat

## Locale resolution

CurrencyText resolves currency from locale region and then formats with intl.

Examples:

```dart
currencyCodeForLocale('en_AE'); // AED
currencyCodeForLocale('ar_SA'); // SAR
currencyCodeForLocale('en_OM'); // OMR
currencyCodeForLocale('en_MV'); // MVR
```

## License

MIT. See LICENSE.
