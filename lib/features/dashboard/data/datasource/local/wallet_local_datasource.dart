import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/shared/local/shared_prefs/shared_pref.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class WalletLocalDataSource {
  Future<Either<AppException, Wallet>> getCachedBalance();
  Future<Either<AppException, List<Transaction>>> getCachedTransactions();
  Future<void> cacheBalance(Wallet wallet);
  Future<void> cacheTransactions(List<Transaction> transactions);
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  final SharedPref _sharedPref;
  static const String _balanceKey = 'cached_wallet_balance';
  static const String _transactionsKey = 'cached_transactions';

  WalletLocalDataSourceImpl({required SharedPref sharedPref})
    : _sharedPref = sharedPref;

  @override
  Future<Either<AppException, Wallet>> getCachedBalance() async {
    try {
      final jsonString = await _sharedPref.get(_balanceKey);
      if (jsonString == null) {
        return Left(
          AppException(
            message: 'No cached balance found',
            statusCode: 0,
            identifier: 'WalletLocalDataSource.getCachedBalance',
            which: 'cache',
          ),
        );
      }
      final jsonMap = jsonDecode(jsonString as String) as Map<String, dynamic>;
      final wallet = Wallet.fromJson(jsonMap);
      return Right(wallet);
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to get cached balance',
          statusCode: 0,
          identifier: 'WalletLocalDataSource.getCachedBalance',
          which: 'cache',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<Transaction>>>
  getCachedTransactions() async {
    try {
      final jsonString = await _sharedPref.get(_transactionsKey);
      if (jsonString == null) {
        return Right([]); // Return empty list if no transactions are cached
      }
      final jsonList = jsonDecode(jsonString as String) as List<dynamic>;
      final transactions = jsonList
          .map((item) => Transaction.fromJson(item as Map<String, dynamic>))
          .toList();
      return Right(transactions);
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to get cached transactions',
          statusCode: 0,
          identifier: 'WalletLocalDataSource.getCachedTransactions',
          which: 'cache',
        ),
      );
    }
  }

  @override
  Future<void> cacheBalance(Wallet wallet) async {
    try {
      final jsonString = jsonEncode(wallet.toJson());
      await _sharedPref.set(_balanceKey, jsonString);
    } catch (e) {
      throw AppException(
        message: 'Failed to cache balance',
        statusCode: 0,
        identifier: 'WalletLocalDataSource.cacheBalance',
        which: 'cache',
      );
    }
  }

  @override
  Future<void> cacheTransactions(List<Transaction> transactions) async {
    try {
      final jsonString = jsonEncode(
        transactions.map((t) => t.toJson()).toList(),
      );
      await _sharedPref.set(_transactionsKey, jsonString);
    } catch (e) {
      throw AppException(
        message: 'Failed to cache transactions',
        statusCode: 0,
        identifier: 'WalletLocalDataSource.cacheTransactions',
        which: 'cache',
      );
    }
  }
}
