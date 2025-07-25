class AppConfigs {
  static const String baseUrl = 'https://api.remittanceapp.com/v1/';

  // Mock exchange rates for demo purposes
  static const Map<String, double> mockExchangeRates = {
    'USD_EUR': 0.85,
    'USD_GBP': 0.73,
    'EUR_USD': 1.18,
    'EUR_GBP': 0.86,
    'GBP_USD': 1.37,
    'GBP_EUR': 1.16,
  };

  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP'];
}
