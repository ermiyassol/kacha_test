import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class WalletRepository {
  Future<Either<AppException, Wallet>> getBalance();
  Future<Either<AppException, List<Transaction>>> getTransactions();
}
