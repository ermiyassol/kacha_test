import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/service_providers.dart';
import 'package:kacha_test/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:kacha_test/features/dashboard/data/datasource/local/wallet_local_datasource.dart';
import 'package:kacha_test/features/dashboard/data/datasource/remote/wallet_remote_datasource.dart';
import 'package:kacha_test/features/exchange/data/datasource/remote/exchange_remote_datasource.dart';
import 'package:kacha_test/features/send_money/data/datasource/remote/transfer_remote_datasource.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final networkService = ref.read(networkServiceProvider);
  return AuthRemoteDataSourceImpl(networkService: networkService);
});

final walletRemoteDataSourceProvider = Provider<WalletRemoteDataSource>((ref) {
  final networkService = ref.read(networkServiceProvider);
  return WalletRemoteDataSourceImpl(networkService: networkService);
});

final walletLocalDataSourceProvider = Provider<WalletLocalDataSource>((ref) {
  final sharedPref = ref.read(sharedPrefProvider);
  return WalletLocalDataSourceImpl(sharedPref: sharedPref);
});

final transferRemoteDataSourceProvider = Provider<TransferRemoteDataSource>((
  ref,
) {
  final networkService = ref.read(networkServiceProvider);
  return TransferRemoteDataSourceImpl(networkService: networkService);
});

final exchangeRemoteDataSourceProvider = Provider<ExchangeRemoteDataSource>((
  ref,
) {
  final networkService = ref.read(networkServiceProvider);
  return ExchangeRemoteDataSourceImpl(networkService: networkService);
});
