import 'package:aed_currency_formatter/aed_currency_formatter.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('aed_currency_formatter example')),
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
              ],
            ),
          ),
        ),
      ),
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
