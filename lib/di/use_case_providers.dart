import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/repository_providers.dart';
import 'package:kacha_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:kacha_test/features/auth/domain/use_cases/register_use_case.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_balance_use_case.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_transactions_use_case.dart';
import 'package:kacha_test/features/exchange/domain/use_cases/get_exchange_rate_use_case.dart';
import 'package:kacha_test/features/send_money/domain/use_cases/send_money_use_case.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LoginUseCase(authRepository: authRepository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return RegisterUseCase(authRepository: authRepository);
});

final getBalanceUseCaseProvider = Provider<GetBalanceUseCase>((ref) {
  final walletRepository = ref.read(walletRepositoryProvider);
  return GetBalanceUseCase(walletRepository: walletRepository);
});

final getTransactionsUseCaseProvider = Provider<GetTransactionsUseCase>((ref) {
  final walletRepository = ref.read(walletRepositoryProvider);
  return GetTransactionsUseCase(walletRepository: walletRepository);
});

final sendMoneyUseCaseProvider = Provider<SendMoneyUseCase>((ref) {
  final transferRepository = ref.read(transferRepositoryProvider);
  return SendMoneyUseCase(transferRepository: transferRepository);
});

final getExchangeRateUseCaseProvider = Provider<GetExchangeRateUseCase>((ref) {
  final exchangeRepository = ref.read(exchangeRepositoryProvider);
  return GetExchangeRateUseCase(exchangeRepository: exchangeRepository);
});
