import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/Injector.dart';
import 'package:kacha_test/features/exchange/domain/use_cases/get_exchange_rate_use_case.dart';
import 'package:kacha_test/features/exchange/presentation/providers/state/exchange_state.dart';

class ExchangeNotifier extends StateNotifier<ExchangeState> {
  final GetExchangeRateUseCase _getExchangeRateUseCase = injector
      .get<GetExchangeRateUseCase>();

  ExchangeNotifier() : super(const ExchangeState.initial());

  Future<void> getExchangeRate(String fromCurrency, String toCurrency) async {
    state = const ExchangeState.loading();

    final result = await _getExchangeRateUseCase.execute(
      fromCurrency,
      toCurrency,
    );

    state = result.fold(
      (failure) => ExchangeState.failure(failure.message!),
      (rate) => ExchangeState.loaded(rate),
    );
  }

  void calculateAmount(double amount, double rate) {
    final loadedState = state;
    state = loadedState.copyWith(
      amount: amount,
      convertedAmount: amount * rate,
    );
  }
}
