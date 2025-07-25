import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/dashboard/domain/repositories/wallet_repository.dart';
import 'package:kacha_test/models/wallet.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class GetBalanceUseCase {
  final WalletRepository _walletRepository;

  GetBalanceUseCase({required WalletRepository walletRepository})
    : _walletRepository = walletRepository;

  Future<Either<AppException, Wallet>> execute() async {
    return await _walletRepository.getBalance();
  }
}
