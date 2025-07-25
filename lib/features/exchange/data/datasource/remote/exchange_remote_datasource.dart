import 'package:dartz/dartz.dart';
import 'package:kacha_test/app/app_configs.dart';
import 'package:kacha_test/models/exchange_rate.dart';
import 'package:kacha_test/models/response/exchange_response.dart';
import 'package:kacha_test/shared/network/network_service.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class ExchangeRemoteDataSource {
  Future<Either<AppException, ExchangeRate>> getExchangeRate(
    String fromCurrency,
    String toCurrency,
  );
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final NetworkService _networkService;

  ExchangeRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Either<AppException, ExchangeRate>> getExchangeRate(
    String fromCurrency,
    String toCurrency,
  ) async {
    try {
      // For demo purposes, we'll use mock data
      final rateKey = '${fromCurrency}_$toCurrency';
      final mockRate = AppConfigs.mockExchangeRates[rateKey] ?? 1.0;

      final exchangeRate = ExchangeRate(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        rate: mockRate,
        lastUpdated: DateTime.now(),
      );

      return Right(exchangeRate);

      // In a real app, you would use the API call:
      // final response = await _networkService.get(
      //   '/exchange/rate',
      //   queryParams: {
      //     'from': fromCurrency,
      //     'to': toCurrency,
      //   },
      // );
      //
      // return response.fold(
      //   (l) => Left(l),
      //   (r) {
      //     final exchangeResponse = ExchangeResponse.fromJson(r.data);
      //     return Right(exchangeResponse.rate);
      //   },
      // );
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to get exchange rate',
          statusCode: 0,
          identifier: 'ExchangeRemoteDataSource.getExchangeRate',
          which: 'api',
        ),
      );
    }
  }
}
