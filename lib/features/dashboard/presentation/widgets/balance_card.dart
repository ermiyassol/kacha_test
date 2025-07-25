import 'package:flutter/material.dart';
import 'package:kacha_test/app/app_colors.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_text_styles.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final String currency;

  const BalanceCard({super.key, required this.balance, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.p16),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Balance',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryLight,
              ),
            ),
            SizedBox(height: AppDimens.p8),
            Text(
              '$balance $currency',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
