import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/exchange_rate.dart';
import 'package:kacha_test/features/exchange/data/datasource/remote/exchange_remote_datasource.dart';
import 'package:kacha_test/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource _exchangeRemoteDataSource;

  ExchangeRepositoryImpl({required ExchangeRemoteDataSource exchangeDataSource})
    : _exchangeRemoteDataSource = exchangeDataSource;

  @override
  Future<Either<AppException, ExchangeRate>> getExchangeRate(
    String fromCurrency,
    String toCurrency,
  ) async {
    return await _exchangeRemoteDataSource.getExchangeRate(
      fromCurrency,
      toCurrency,
    );
  }
}
