import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:kacha_test/models/user.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<Either<AppException, User>> execute(
    String email,
    String password,
  ) async {
    return await _authRepository.login(email, password);
  }
}
