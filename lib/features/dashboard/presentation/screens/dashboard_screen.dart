import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/app/app_dimens.dart';
import 'package:kacha_test/app/app_strings.dart';
import 'package:kacha_test/app/app_text_styles.dart';
import 'package:kacha_test/features/dashboard/presentation/providers/state/wallet_state.dart';
import 'package:kacha_test/features/dashboard/presentation/providers/wallet_notifier_provider.dart';
import 'package:kacha_test/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:kacha_test/features/dashboard/presentation/widgets/transaction_item.dart';
import 'package:kacha_test/routes/app_router.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletNotifierProvider.notifier).getWalletData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.dashboard, style: AppTextStyles.titleMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(walletNotifierProvider.notifier).getWalletData(),
          ),
        ],
      ),
      body: _buildBody(walletState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(Routes.sendMoney.name),
        child: const Icon(Icons.send),
      ),
    );
  }

  Widget _buildBody(WalletState state) {
    if (state.status == WalletStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == WalletStatus.failure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error ?? 'An error occurred'),
            ElevatedButton(
              onPressed: () =>
                  ref.read(walletNotifierProvider.notifier).getWalletData(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.status == WalletStatus.loaded) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.p16),
        child: Column(
          children: [
            BalanceCard(
              balance: state.wallet!.balance,
              currency: state.wallet!.currency,
            ),
            SizedBox(height: AppDimens.p24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.recentTransactions,
                  style: AppTextStyles.titleSmall,
                ),
                TextButton(
                  onPressed: () => context.pushNamed(Routes.exchange.name),
                  child: Text(AppStrings.exchange),
                ),
              ],
            ),
            SizedBox(height: AppDimens.p16),
            if (state.transactions.isEmpty)
              Text(AppStrings.noTransactions, style: AppTextStyles.bodyMedium)
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  return TransactionItem(
                    transaction: state.transactions[index],
                  );
                },
              ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
