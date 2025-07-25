import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:kacha_test/models/user.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<Either<AppException, User>> execute(
    String email,
    String password,
    String name,
  ) async {
    return await _authRepository.register(email, password, name);
  }
}
