import 'package:kacha_test/models/exchange_rate.dart';

class ExchangeResponse {
  final ExchangeRate rate;

  ExchangeResponse({required this.rate});

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeResponse(
      rate: ExchangeRate.fromJson(json['rate'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate.toJson()};
  }
}
