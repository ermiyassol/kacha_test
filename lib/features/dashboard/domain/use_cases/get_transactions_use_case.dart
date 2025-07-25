import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:kacha_test/models/transaction.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class GetTransactionsUseCase {
  final WalletRepository _walletRepository;

  GetTransactionsUseCase({required WalletRepository walletRepository})
    : _walletRepository = walletRepository;

  Future<Either<AppException, List<Transaction>>> execute() async {
    return await _walletRepository.getTransactions();
  }
}
