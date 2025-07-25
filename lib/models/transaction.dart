class Transaction {
  int? id; // Changed from Isar.autoIncrement to nullable int

  final String transactionId;
  final double amount;
  final String currency;
  final String recipientName;
  final String recipientAccount;
  final DateTime date;
  final String status;
  final String? note;

  Transaction({
    this.id,
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.recipientName,
    required this.recipientAccount,
    required this.date,
    required this.status,
    this.note,
  });

  // Existing fromJson remains the same
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int?,
      transactionId: json['transactionId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      recipientName: json['recipientName'] as String,
      recipientAccount: json['recipientAccount'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      note: json['note'] as String?,
    );
  }

  // Existing toJson remains the same
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionId': transactionId,
      'amount': amount,
      'currency': currency,
      'recipientName': recipientName,
      'recipientAccount': recipientAccount,
      'date': date.toIso8601String(),
      'status': status,
      'note': note,
    };
  }
}
