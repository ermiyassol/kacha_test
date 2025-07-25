import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/models/transaction.dart';

class WalletResponse {
  final Wallet wallet;
  final List<Transaction> transactions;

  WalletResponse({required this.wallet, required this.transactions});

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      wallet: Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      transactions: (json['transactions'] as List<dynamic>)
          .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet': wallet.toJson(),
      'transactions': transactions.map((t) => t.toJson()).toList(),
    };
  }
}
