import 'package:equatable/equatable.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/models/wallet.dart';

enum WalletStatus { initial, loading, loaded, failure }

class WalletState extends Equatable {
  final WalletStatus status;
  final Wallet? wallet;
  final List<Transaction> transactions;
  final String? error;

  const WalletState({
    this.status = WalletStatus.initial,
    this.wallet,
    this.transactions = const [],
    this.error,
  });

  const WalletState.initial() : this(status: WalletStatus.initial);

  const WalletState.loading() : this(status: WalletStatus.loading);

  const WalletState.loaded(Wallet wallet, List<Transaction> transactions)
    : this(
        status: WalletStatus.loaded,
        wallet: wallet,
        transactions: transactions,
      );

  const WalletState.failure(String error)
    : this(status: WalletStatus.failure, error: error);

  @override
  List<Object?> get props => [status, wallet, transactions, error];
}
