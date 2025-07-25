import 'package:kacha_test/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:kacha_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kacha_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:kacha_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:kacha_test/features/auth/domain/use_cases/register_use_case.dart';
import 'package:kacha_test/features/dashboard/data/datasource/local/wallet_local_datasource.dart';
import 'package:kacha_test/features/dashboard/data/datasource/remote/wallet_remote_datasource.dart';
import 'package:kacha_test/features/dashboard/data/repositories/wallet_repository_impl.dart';
import 'package:kacha_test/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_balance_use_case.dart';
import 'package:kacha_test/features/dashboard/domain/use_cases/get_transactions_use_case.dart';
import 'package:kacha_test/features/exchange/data/datasource/remote/exchange_remote_datasource.dart';
import 'package:kacha_test/features/exchange/data/repositories/exchange_repository_impl.dart';
import 'package:kacha_test/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:kacha_test/features/exchange/domain/use_cases/get_exchange_rate_use_case.dart';
import 'package:kacha_test/features/send_money/data/datasource/remote/transfer_remote_datasource.dart';
import 'package:kacha_test/features/send_money/data/repositories/transfer_repository_impl.dart';
import 'package:kacha_test/features/send_money/domain/repositories/transfer_repository.dart';
import 'package:kacha_test/features/send_money/domain/use_cases/send_money_use_case.dart';
import 'package:kacha_test/shared/local/cache/local_db.dart';
import 'package:kacha_test/shared/local/cache/local_db_impl.dart';
import 'package:kacha_test/shared/local/shared_prefs/shared_pref.dart';
import 'package:kacha_test/shared/local/shared_prefs/shared_pref_impl.dart';
import 'package:kacha_test/shared/network/dio_network_service.dart';
import 'package:kacha_test/shared/network/network_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initSingletons() async {
  // Services
  injector.registerLazySingleton<LocalDb>(() => InitDbImpl());
  injector.registerLazySingleton<NetworkService>(() => DioNetworkService());
  injector.registerLazySingleton<SharedPref>(() => SharedPrefImplementation());

  // Initiating db
  await injector<LocalDb>().initDb();
}

void provideDataSources() {
  // Auth
  injector.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      networkService: injector.get<NetworkService>(),
    ),
  );

  // Wallet
  injector.registerFactory<WalletLocalDataSource>(
    () => WalletLocalDataSourceImpl(sharedPref: injector.get<SharedPref>()),
  );
  injector.registerFactory<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(
      networkService: injector.get<NetworkService>(),
    ),
  );

  // Transfer
  injector.registerFactory<TransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(
      networkService: injector.get<NetworkService>(),
    ),
  );

  // Exchange
  injector.registerFactory<ExchangeRemoteDataSource>(
    () => ExchangeRemoteDataSourceImpl(
      networkService: injector.get<NetworkService>(),
    ),
  );
}

void provideRepositories() {
  // Auth
  injector.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: injector.get<AuthRemoteDataSource>(),
    ),
  );

  // Wallet
  injector.registerFactory<WalletRepository>(
    () => WalletRepositoryImpl(
      walletRemoteDataSource: injector.get<WalletRemoteDataSource>(),
      walletLocalDataSource: injector.get<WalletLocalDataSource>(),
    ),
  );

  // Transfer
  injector.registerFactory<TransferRepository>(
    () => TransferRepositoryImpl(
      transferDataSource: injector.get<TransferRemoteDataSource>(),
    ),
  );

  // Exchange
  injector.registerFactory<ExchangeRepository>(
    () => ExchangeRepositoryImpl(
      exchangeDataSource: injector.get<ExchangeRemoteDataSource>(),
    ),
  );
}

void provideUseCases() {
  // Auth
  injector.registerFactory<LoginUseCase>(
    () => LoginUseCase(authRepository: injector.get<AuthRepository>()),
  );
  injector.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(authRepository: injector.get<AuthRepository>()),
  );

  // Wallet
  injector.registerFactory<GetBalanceUseCase>(
    () => GetBalanceUseCase(walletRepository: injector.get<WalletRepository>()),
  );
  injector.registerFactory<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(
      walletRepository: injector.get<WalletRepository>(),
    ),
  );

  // Transfer
  injector.registerFactory<SendMoneyUseCase>(
    () => SendMoneyUseCase(
      transferRepository: injector.get<TransferRepository>(),
    ),
  );

  // Exchange
  injector.registerFactory<GetExchangeRateUseCase>(
    () => GetExchangeRateUseCase(
      exchangeRepository: injector.get<ExchangeRepository>(),
    ),
  );
}
