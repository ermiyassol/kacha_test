import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class TransferRepository {
  Future<Either<AppException, Transaction>> sendMoney(
    String recipientId,
    double amount,
    String currency,
    String note,
  );
}
