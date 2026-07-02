import 'package:flutter/material.dart';

import 'currency_locale_data.dart';

/// Converts an ISO 3166-1 alpha-2 country code (e.g. `AE`) to its flag emoji
/// by mapping each letter to its Unicode regional indicator symbol.
String countryFlagEmoji(String countryCode) {
  final String upper = countryCode.toUpperCase();
  final int first = upper.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int second = upper.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(first) + String.fromCharCode(second);
}

/// One selectable entry in [CurrencyPicker]: an ISO 4217 currency code paired
/// with a representative ISO 3166-1 country code used to render its flag.
class CurrencyOption {
  const CurrencyOption({required this.currencyCode, required this.countryCode});

  /// The ISO 4217 currency code, e.g. `AED`.
  final String currencyCode;

  /// The ISO 3166-1 alpha-2 country code used to render this option's flag.
  final String countryCode;

  /// The flag emoji for [countryCode].
  String get flag => countryFlagEmoji(countryCode);
}

/// Every currency known to this package, each paired with the
/// alphabetically-first country that uses it, derived from
/// [countryToCurrencyCode] and sorted by currency code.
final List<CurrencyOption> allCurrencyOptions = _buildCurrencyOptions();

List<CurrencyOption> _buildCurrencyOptions() {
  final Map<String, String> currencyToCountry = <String, String>{};
  countryToCurrencyCode.forEach((String country, String currency) {
    currencyToCountry.putIfAbsent(currency, () => country);
  });
  return currencyToCountry.entries
      .map(
        (MapEntry<String, String> e) =>
            CurrencyOption(currencyCode: e.key, countryCode: e.value),
      )
      .toList()
    ..sort(
      (CurrencyOption a, CurrencyOption b) =>
          a.currencyCode.compareTo(b.currencyCode),
    );
}

/// Builds the widget shown for [option] in a [CurrencyPicker]'s button and
/// menu.
typedef CurrencyOptionBuilder = Widget Function(
    BuildContext context, CurrencyOption option);

/// A dropdown for picking a currency, showing each option's country flag
/// alongside its ISO 4217 code.
///
/// ```dart
/// CurrencyPicker(
///   value: 'AED',
///   onChanged: (code) => setState(() => selected = code),
/// )
/// ```
///
/// Customize the field's chrome with [decoration], or fall back to [label]
/// for just the field's label text. Customize each row's look with
/// [showFlag] and [style], or take full control with [itemBuilder].
class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.options,
    this.label,
    this.decoration,
    this.style,
    this.dropdownColor,
    this.borderRadius,
    this.showFlag = true,
    this.itemBuilder,
  });

  /// The currently selected ISO 4217 currency code.
  final String value;

  /// Called with the newly selected currency code when the user picks one.
  final ValueChanged<String> onChanged;

  /// The list of selectable currencies. Defaults to [allCurrencyOptions]
  /// (every currency known to this package) when null.
  final List<CurrencyOption>? options;

  /// Label shown on the dropdown's form field. Defaults to `'Currency'`.
  /// Ignored when [decoration] is provided.
  final String? label;

  /// Full control over the field's chrome (border, fill, padding, etc).
  /// Overrides [label] when provided.
  final InputDecoration? decoration;

  /// Text style applied to each option's currency code, and to the closed
  /// field's selected value.
  final TextStyle? style;

  /// Background color of the open dropdown menu.
  final Color? dropdownColor;

  /// Corner radius of the field and the open dropdown menu. Defaults to 12.
  final BorderRadius? borderRadius;

  /// Whether to show the country flag next to each currency code. Ignored
  /// when [itemBuilder] is provided.
  final bool showFlag;

  /// Overrides the default flag-and-code row with a fully custom builder
  /// for each option, used both in the closed field and the open menu.
  final CurrencyOptionBuilder? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? BorderRadius.circular(12);
    Widget buildRow(CurrencyOption option) {
      if (itemBuilder != null) return itemBuilder!(context, option);
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (showFlag) ...<Widget>[
            Text(option.flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
          ],
          Text(option.currencyCode, style: style),
        ],
      );
    }

    return DropdownButtonFormField<String>(
      // `initialValue` isn't available on this package's minimum supported
      // Flutter version (>=3.0.0); `value` behaves identically here.
      // ignore: deprecated_member_use
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      borderRadius: radius,
      dropdownColor: dropdownColor,
      decoration: decoration ??
          InputDecoration(
            labelText: label ?? 'Currency',
            border: OutlineInputBorder(borderRadius: radius),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
      items: <DropdownMenuItem<String>>[
        for (final CurrencyOption option in options ?? allCurrencyOptions)
          DropdownMenuItem<String>(
            value: option.currencyCode,
            child: buildRow(option),
          ),
      ],
      onChanged: (String? code) {
        if (code != null) onChanged(code);
      },
    );
  }
}
