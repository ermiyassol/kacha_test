import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/send_money/domain/repositories/transfer_repository.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class SendMoneyUseCase {
  final TransferRepository _transferRepository;

  SendMoneyUseCase({required TransferRepository transferRepository})
    : _transferRepository = transferRepository;

  Future<Either<AppException, Transaction>> execute(
    String recipientId,
    double amount,
    String currency,
    String note,
  ) async {
    return await _transferRepository.sendMoney(
      recipientId,
      amount,
      currency,
      note,
    );
  }
}
