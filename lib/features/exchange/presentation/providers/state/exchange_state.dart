import 'package:equatable/equatable.dart';
import 'package:kacha_test/models/exchange_rate.dart';

enum ExchangeStatus { initial, loading, loaded, failure }

class ExchangeState extends Equatable {
  final ExchangeStatus status;
  final ExchangeRate? rate;
  final double? amount;
  final double? convertedAmount;
  final String? error;

  const ExchangeState({
    this.status = ExchangeStatus.initial,
    this.rate,
    this.amount,
    this.convertedAmount,
    this.error,
  });

  const ExchangeState.initial() : this(status: ExchangeStatus.initial);

  const ExchangeState.loading() : this(status: ExchangeStatus.loading);

  const ExchangeState.loaded(ExchangeRate rate)
    : this(status: ExchangeStatus.loaded, rate: rate);

  const ExchangeState.failure(String error)
    : this(status: ExchangeStatus.failure, error: error);

  ExchangeState copyWith({
    ExchangeStatus? status,
    ExchangeRate? rate,
    double? amount,
    double? convertedAmount,
    String? error,
  }) {
    return ExchangeState(
      status: status ?? this.status,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, rate, amount, convertedAmount, error];
}
