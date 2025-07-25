import 'package:dartz/dartz.dart';
import 'package:kacha_test/models/user.dart';
import 'package:kacha_test/shared/util/app_exception.dart';

abstract class AuthRepository {
  Future<Either<AppException, User>> login(String email, String password);
  Future<Either<AppException, User>> register(
    String email,
    String password,
    String name,
  );
}
