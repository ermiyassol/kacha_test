import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/response/auth_response.dart';
import 'package:kacha_test/models/user.dart';
import 'package:kacha_test/shared/network/network_service.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class AuthRemoteDataSource {
  Future<Either<AppException, User>> login(String email, String password);
  Future<Either<AppException, User>> register(
    String email,
    String password,
    String name,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Either<AppException, User>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _networkService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      // ignore: avoid_print
      print("response - $response");

      return response.fold((l) => Left(l), (r) {
        final authResponse = AuthResponse.fromJson(r.data);
        return Right(authResponse.user);
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Login failed',
          statusCode: 0,
          identifier: 'AuthRemoteDataSource.login',
          which: 'auth',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, User>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _networkService.post(
        '/auth/register',
        data: {'email': email, 'password': password, 'name': name},
      );

      return response.fold((l) => Left(l), (r) {
        final authResponse = AuthResponse.fromJson(r.data);
        return Right(authResponse.user);
      });
    } catch (e) {
      return Left(
        AppException(
          message: 'Registration failed',
          statusCode: 0,
          identifier: 'AuthRemoteDataSource.register',
          which: 'auth',
        ),
      );
    }
  }
}
