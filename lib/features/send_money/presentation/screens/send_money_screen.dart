import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/app/app_colors.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_strings.dart';
import 'package:kacha_test/app/app_text_styles.dart';
import 'package:kacha_test/features/send_money/presentation/providers/state/transfer_state.dart';
import 'package:kacha_test/features/send_money/presentation/providers/transfer_notifier_provider.dart';
import 'package:kacha_test/features/send_money/presentation/widgets/recipient_form.dart';
import 'package:go_router/go_router.dart';

class SendMoneyScreen extends ConsumerStatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  ConsumerState<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends ConsumerState<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _currency = 'USD';

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(transferNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.sendMoney, style: AppTextStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.p16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipientForm(
                recipientController: _recipientController,
                amountController: _amountController,
                noteController: _noteController,
                currency: _currency,
                onCurrencyChanged: (value) {
                  setState(() {
                    _currency = value!;
                  });
                },
              ),
              SizedBox(height: AppDimens.p24),
              if (transferState.status == TransferStatus.loading)
                const Center(child: CircularProgressIndicator())
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(AppStrings.sendMoney),
                  ),
                ),
              if (transferState.status == TransferStatus.success)
                Padding(
                  padding: EdgeInsets.only(top: AppDimens.p16),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.transferSuccessful,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.updateNotificationColorLight,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(transferNotifierProvider.notifier).reset();
                          context.pop();
                        },
                        child: Text(AppStrings.backToDashboard),
                      ),
                    ],
                  ),
                ),
              if (transferState.status == TransferStatus.failure)
                Padding(
                  padding: EdgeInsets.only(top: AppDimens.p16),
                  child: Text(
                    transferState.error ?? AppStrings.transferFailed,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(transferNotifierProvider.notifier)
          .sendMoney(
            recipientId: _recipientController.text.trim(),
            amount: double.parse(_amountController.text.trim()),
            currency: _currency,
            _noteController.text.trim(),
          );
    }
  }
}
