class Wallet {
  int? id; // Changed from Isar.autoIncrement to nullable int

  final double balance;
  final String currency;
  final DateTime lastUpdated;

  Wallet({
    this.id,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as int?,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
      'currency': currency,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
