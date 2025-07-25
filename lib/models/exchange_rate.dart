class ExchangeRate {
  int? id; // Changed from Isar auto-increment to nullable int

  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime lastUpdated;

  ExchangeRate({
    this.id, // Now optional
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.lastUpdated,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      id: json['id'] as int?, // Added ID from JSON if needed
      fromCurrency: json['fromCurrency'] as String,
      toCurrency: json['toCurrency'] as String,
      rate: (json['rate'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include ID in JSON if needed
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'rate': rate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
