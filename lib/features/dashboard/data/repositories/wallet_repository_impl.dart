import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/dashboard/data/datasource/local/wallet_local_datasource.dart';
import 'package:kacha_test/features/dashboard/data/datasource/remote/wallet_remote_datasource.dart';
import 'package:kacha_test/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _walletRemoteDataSource;
  final WalletLocalDataSource _walletLocalDataSource;

  WalletRepositoryImpl({
    required WalletRemoteDataSource walletRemoteDataSource,
    required WalletLocalDataSource walletLocalDataSource,
  }) : _walletRemoteDataSource = walletRemoteDataSource,
       _walletLocalDataSource = walletLocalDataSource;

  @override
  Future<Either<AppException, Wallet>> getBalance() async {
    try {
      final remoteResult = await _walletRemoteDataSource.getBalance();
      return remoteResult.fold(
        (l) async {
          // Remote call failed, try local cache
          final localResult = await _walletLocalDataSource.getCachedBalance();
          return localResult;
        },
        (r) async {
          // Cache the successful remote result
          await _walletLocalDataSource.cacheBalance(r);
          return Right(r);
        },
      );
    } catch (e) {
      // Fallback to local cache if any unexpected error occurs
      return await _walletLocalDataSource.getCachedBalance();
    }
  }

  @override
  Future<Either<AppException, List<Transaction>>> getTransactions() async {
    try {
      final remoteResult = await _walletRemoteDataSource.getTransactions();
      return remoteResult.fold(
        (l) async {
          // Remote call failed, try local cache
          final localResult = await _walletLocalDataSource
              .getCachedTransactions();
          return localResult;
        },
        (r) async {
          // Cache the successful remote result
          await _walletLocalDataSource.cacheTransactions(r);
          return Right(r);
        },
      );
    } catch (e) {
      // Fallback to local cache if any unexpected error occurs
      return await _walletLocalDataSource.getCachedTransactions();
    }
  }
}
