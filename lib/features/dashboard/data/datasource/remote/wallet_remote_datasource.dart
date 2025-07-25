import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/response/wallet_response.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/shared/network/network_service.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class WalletRemoteDataSource {
  Future<Either<AppException, Wallet>> getBalance();
  Future<Either<AppException, List<Transaction>>> getTransactions();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final NetworkService _networkService;

  WalletRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Either<AppException, Wallet>> getBalance() async {
    try {
      final response = await _networkService.get('/wallet/balance');
      return response.fold((l) => Left(l), (r) {
        final walletResponse = WalletResponse.fromJson(r.data);
        return Right(walletResponse.wallet);
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to fetch balance',
          statusCode: 0,
          identifier: 'WalletRemoteDataSource.getBalance',
          which: 'api',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<Transaction>>> getTransactions() async {
    try {
      final response = await _networkService.get('/wallet/transactions');
      return response.fold((l) => Left(l), (r) {
        final walletResponse = WalletResponse.fromJson(r.data);
        return Right(walletResponse.transactions);
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to fetch transactions',
          statusCode: 0,
          identifier: 'WalletRemoteDataSource.getTransactions',
          which: 'api',
        ),
      );
    }
  }
}
