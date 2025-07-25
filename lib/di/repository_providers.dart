import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/data_source_providers.dart';
import 'package:kacha_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kacha_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:kacha_test/features/dashboard/data/repositories/wallet_repository_impl.dart';
import 'package:kacha_test/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:kacha_test/features/exchange/data/repositories/exchange_repository_impl.dart';
import 'package:kacha_test/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:kacha_test/features/send_money/data/repositories/transfer_repository_impl.dart';
import 'package:kacha_test/features/send_money/domain/repositories/transfer_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(authDataSource: authDataSource);
});

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  final walletRemoteDataSource = ref.read(walletRemoteDataSourceProvider);
  final walletLocalDataSource = ref.read(walletLocalDataSourceProvider);
  return WalletRepositoryImpl(
    walletRemoteDataSource: walletRemoteDataSource,
    walletLocalDataSource: walletLocalDataSource,
  );
});

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  final transferDataSource = ref.read(transferRemoteDataSourceProvider);
  return TransferRepositoryImpl(transferDataSource: transferDataSource);
});

final exchangeRepositoryProvider = Provider<ExchangeRepository>((ref) {
  final exchangeDataSource = ref.read(exchangeRemoteDataSourceProvider);
  return ExchangeRepositoryImpl(exchangeDataSource: exchangeDataSource);
});
