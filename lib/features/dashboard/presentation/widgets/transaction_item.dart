import 'package:flutter/material.dart';
import 'package:kacha_test/app/app_colors.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_text_styles.dart';
import 'package:kacha_test/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppDimens.p8),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.recipientName,
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  '${transaction.amount} ${transaction.currency}',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: transaction.status == 'completed'
                        ? AppColors.updateNotificationColorLight
                        : AppColors.error,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.p8),
            Text(
              transaction.transactionId,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryLight,
              ),
            ),
            SizedBox(height: AppDimens.p8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  transaction.status,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: transaction.status == 'completed'
                        ? AppColors.updateNotificationColorLight
                        : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
