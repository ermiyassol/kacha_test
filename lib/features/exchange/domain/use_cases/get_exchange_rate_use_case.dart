import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:kacha_test/models/exchange_rate.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class GetExchangeRateUseCase {
  final ExchangeRepository _exchangeRepository;

  GetExchangeRateUseCase({required ExchangeRepository exchangeRepository})
    : _exchangeRepository = exchangeRepository;

  Future<Either<AppException, ExchangeRate>> execute(
    String fromCurrency,
    String toCurrency,
  ) async {
    return await _exchangeRepository.getExchangeRate(fromCurrency, toCurrency);
  }
}
