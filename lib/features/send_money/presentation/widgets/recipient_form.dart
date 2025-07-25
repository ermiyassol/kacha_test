import 'package:flutter/material.dart';
import 'package:kacha_test/app/app_configs.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_strings.dart';
import 'package:kacha_test/app/app_text_styles.dart';

class RecipientForm extends StatelessWidget {
  final TextEditingController recipientController;
  final TextEditingController amountController;
  final TextEditingController noteController;
  final String currency;
  final ValueChanged<String?> onCurrencyChanged;

  const RecipientForm({
    super.key,
    required this.recipientController,
    required this.amountController,
    required this.noteController,
    required this.currency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.recipientDetails, style: AppTextStyles.titleSmall),
        SizedBox(height: AppDimens.p16),
        TextFormField(
          controller: recipientController,
          decoration: InputDecoration(
            labelText: AppStrings.recipientEmailOrPhone,
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.recipientRequired;
            }
            return null;
          },
        ),
        SizedBox(height: AppDimens.p16),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppStrings.amount,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.amountRequired;
                  }
                  if (double.tryParse(value) == null) {
                    return AppStrings.invalidAmount;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: AppDimens.p8),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<String>(
                value: currency,
                decoration: InputDecoration(
                  labelText: AppStrings.currency,
                  border: OutlineInputBorder(),
                ),
                items: AppConfigs.supportedCurrencies
                    .map(
                      (currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ),
                    )
                    .toList(),
                onChanged: onCurrencyChanged,
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimens.p16),
        TextFormField(
          controller: noteController,
          decoration: InputDecoration(
            labelText: AppStrings.noteOptional,
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}
