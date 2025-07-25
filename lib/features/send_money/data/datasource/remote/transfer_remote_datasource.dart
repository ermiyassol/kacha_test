import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/response/transfer_response.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/network/network_service.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class TransferRemoteDataSource {
  Future<Either<AppException, Transaction>> sendMoney(
    String recipientId,
    double amount,
    String currency,
    String note,
  );
}

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final NetworkService _networkService;

  TransferRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Either<AppException, Transaction>> sendMoney(
    String recipientId,
    double amount,
    String currency,
    String note,
  ) async {
    try {
      final response = await _networkService.post(
        '/transfers/send',
        data: {
          'recipient_id': recipientId,
          'amount': amount,
          'currency': currency,
          'note': note,
        },
      );

      return response.fold((l) => Left(l), (r) {
        final transferResponse = TransferResponse.fromJson(r.data);
        return Right(transferResponse.transaction);
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to send money',
          statusCode: 0,
          identifier: 'TransferRemoteDataSource.sendMoney',
          which: 'api',
        ),
      );
    }
  }
}
