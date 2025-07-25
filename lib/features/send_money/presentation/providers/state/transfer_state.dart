import 'package:equatable/equatable.dart';
import 'package:kacha_test/models/transaction.dart';

enum TransferStatus { initial, loading, success, failure }

class TransferState extends Equatable {
  final TransferStatus status;
  final Transaction? transaction;
  final String? error;

  const TransferState({
    this.status = TransferStatus.initial,
    this.transaction,
    this.error,
  });

  const TransferState.initial() : this(status: TransferStatus.initial);

  const TransferState.loading() : this(status: TransferStatus.loading);

  const TransferState.success(Transaction transaction)
    : this(status: TransferStatus.success, transaction: transaction);

  const TransferState.failure(String error)
    : this(status: TransferStatus.failure, error: error);

  @override
  List<Object?> get props => [status, transaction, error];
}
