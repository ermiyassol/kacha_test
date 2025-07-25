import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/app/app_colors.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_strings.dart';
import 'package:kacha_test/app/app_text_styles.dart';
import 'package:kacha_test/features/exchange/presentation/providers/exchange_notifier_provider.dart';
import 'package:kacha_test/features/exchange/presentation/providers/state/exchange_state.dart';
import 'package:kacha_test/features/exchange/presentation/widgets/currency_picker.dart';

class ExchangeScreen extends ConsumerStatefulWidget {
  const ExchangeScreen({super.key});

  @override
  ConsumerState<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends ConsumerState<ExchangeScreen> {
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exchangeState = ref.watch(exchangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.currencyExchange,
          style: AppTextStyles.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.p16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CurrencyPicker(
                    value: _fromCurrency,
                    onChanged: (value) {
                      setState(() {
                        _fromCurrency = value!;
                      });
                      _getExchangeRate();
                    },
                    label: AppStrings.from,
                  ),
                ),
                SizedBox(width: AppDimens.p16),
                Expanded(
                  child: CurrencyPicker(
                    value: _toCurrency,
                    onChanged: (value) {
                      setState(() {
                        _toCurrency = value!;
                      });
                      _getExchangeRate();
                    },
                    label: AppStrings.to,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.p24),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: AppStrings.amount,
                border: OutlineInputBorder(),
                suffixText: _fromCurrency,
              ),
              onChanged: (value) {
                if (value.isNotEmpty && exchangeState.rate != null) {
                  final amount = double.tryParse(value) ?? 0;
                  ref
                      .read(exchangeNotifierProvider.notifier)
                      .calculateAmount(amount, exchangeState.rate!.rate);
                }
              },
            ),
            SizedBox(height: AppDimens.p24),
            if (exchangeState.status == ExchangeStatus.loading)
              const Center(child: CircularProgressIndicator())
            else if (exchangeState.status == ExchangeStatus.loaded)
              Column(
                children: [
                  Text(
                    '1 $_fromCurrency = ${exchangeState.rate!.rate} $_toCurrency',
                    style: AppTextStyles.bodyMedium,
                  ),
                  SizedBox(height: AppDimens.p16),
                  if (exchangeState.amount != null &&
                      exchangeState.convertedAmount != null)
                    Text(
                      '${exchangeState.amount} $_fromCurrency = ${exchangeState.convertedAmount!.toStringAsFixed(2)} $_toCurrency',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                ],
              ),
            if (exchangeState.status == ExchangeStatus.failure)
              Text(
                exchangeState.error ?? AppStrings.exchangeRateError,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                ),
              ),
            SizedBox(height: AppDimens.p24),
            ElevatedButton(
              onPressed: _getExchangeRate,
              child: Text(AppStrings.getExchangeRate),
            ),
          ],
        ),
      ),
    );
  }

  void _getExchangeRate() {
    ref
        .read(exchangeNotifierProvider.notifier)
        .getExchangeRate(_fromCurrency, _toCurrency);
  }
}
