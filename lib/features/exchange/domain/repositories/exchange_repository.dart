import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/exchange_rate.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class ExchangeRepository {
  Future<Either<AppException, ExchangeRate>> getExchangeRate(
    String fromCurrency,
    String toCurrency,
  );
}
