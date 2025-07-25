import 'package:kacha_test/models/transaction.dart';

class TransferResponse {
  final Transaction transaction;

  TransferResponse({required this.transaction});

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      transaction: Transaction.fromJson(
        json['transaction'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'transaction': transaction.toJson()};
  }
}
