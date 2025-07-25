import 'package:dartz/dartz.dart';
import 'package:kacha_test/features/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:kacha_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:kacha_test/models/user.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authDataSource})
    : _authRemoteDataSource = authDataSource;

  @override
  Future<Either<AppException, User>> login(
    String email,
    String password,
  ) async {
    return await _authRemoteDataSource.login(email, password);
  }

  @override
  Future<Either<AppException, User>> register(
    String email,
    String password,
    String name,
  ) async {
    return await _authRemoteDataSource.register(email, password, name);
  }
}
