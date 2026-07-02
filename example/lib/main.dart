import 'package:gulf_currency/gulf_currency.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('gulf_currency example')),
        body: const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Row(
                  label: 'CurrencyText (en_US)',
                  child: CurrencyText(1250.75, locale: 'en_US'),
                ),

                SizedBox(height: 12),

                _Row(
                  label: 'CurrencyText (ja_JP)',
                  child: CurrencyText(1250, locale: 'ja_JP'),
                ),

                SizedBox(height: 12),

                _Row(
                  label: 'CurrencyText (en_GB)',
                  child: CurrencyText(1250.75, locale: 'en_GB'),
                ),

                SizedBox(height: 12),

                // CurrencyText automatically delegates to AedText/SarText
                // when the resolved currency is AED or SAR.
                _Row(
                  label: 'CurrencyText (en_AE)',
                  child: CurrencyText(1250.75, locale: 'en_AE'),
                ),

                SizedBox(height: 12),

                _Row(
                  label: 'CurrencyText (ar_SA)',
                  child: CurrencyText(1250.75, locale: 'ar_SA'),
                ),

                SizedBox(height: 12),

                _Row(
                  label: 'CurrencyText (en_OM)',
                  child: CurrencyText(1250.75, locale: 'en_OM'),
                ),

                SizedBox(height: 12),

                _Row(
                  label: 'CurrencyText (en_MV)',
                  child: CurrencyText(1250.75, locale: 'en_MV'),
                ),

                SizedBox(height: 24),

                _CurrencyPickerDemo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrencyPickerDemo extends StatefulWidget {
  const _CurrencyPickerDemo();

  @override
  State<_CurrencyPickerDemo> createState() => _CurrencyPickerDemoState();
}

class _CurrencyPickerDemoState extends State<_CurrencyPickerDemo> {
  String _currencyCode = 'AED';

  @override
  Widget build(BuildContext context) {
    final String countryCode = allCurrencyOptions
        .firstWhere(
            (CurrencyOption option) => option.currencyCode == _currencyCode)
        .countryCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('CurrencyPicker'),
        const SizedBox(height: 8),
        SizedBox(
          width: 220,
          child: CurrencyPicker(
            value: _currencyCode,
            onChanged: (String code) => setState(() => _currencyCode = code),
          ),
        ),
        const SizedBox(height: 12),
        _Row(
          label: 'Selected currency',
          child: CurrencyText(1250.75, locale: 'en_$countryCode'),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: 220, child: Text(label)),
        child,
      ],
    );
  }
}
