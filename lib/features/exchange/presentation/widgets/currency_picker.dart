import 'package:flutter/material.dart';
import 'package:kacha_test/app/app_configs.dart';
import 'package:kacha_test/app/app_text_styles.dart';

class CurrencyPicker extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final String label;

  const CurrencyPicker({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: AppConfigs.supportedCurrencies
              .map(
                (currency) =>
                    DropdownMenuItem(value: currency, child: Text(currency)),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
