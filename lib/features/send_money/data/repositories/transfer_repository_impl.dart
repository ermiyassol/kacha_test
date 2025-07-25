import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/send_money/data/datasource/remote/transfer_remote_datasource.dart';
import 'package:kacha_test/features/send_money/domain/repositories/transfer_repository.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSource _transferRemoteDataSource;

  TransferRepositoryImpl({required TransferRemoteDataSource transferDataSource})
    : _transferRemoteDataSource = transferDataSource;

  @override
  Future<Either<AppException, Transaction>> sendMoney(
    String recipientId,
    double amount,
    String currency,
    String note,
  ) async {
    return await _transferRemoteDataSource.sendMoney(
      recipientId,
      amount,
      currency,
      note,
    );
  }
}
