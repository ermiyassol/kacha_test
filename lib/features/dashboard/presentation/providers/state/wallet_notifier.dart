import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/Injector.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_balance_use_case.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_transactions_use_case.dart';
import 'package:kacha_test/features/dashboard/presentation/providers/state/wallet_state.dart';

class WalletNotifier extends StateNotifier<WalletState> {
  final GetBalanceUseCase _getBalanceUseCase = injector
      .get<GetBalanceUseCase>();
  final GetTransactionsUseCase _getTransactionsUseCase = injector
      .get<GetTransactionsUseCase>();

  WalletNotifier() : super(const WalletState.initial());

  Future<void> getWalletData() async {
    state = const WalletState.loading();

    final balanceResult = await _getBalanceUseCase.execute();
    final transactionsResult = await _getTransactionsUseCase.execute();

    balanceResult.fold(
      (failure) => state = WalletState.failure(failure.message!),
      (balance) {
        transactionsResult.fold(
          (failure) => state = WalletState.failure(failure.message!),
          (transactions) => state = WalletState.loaded(balance, transactions),
        );
      },
    );
  }
}
