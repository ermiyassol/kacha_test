import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/Injector.dart';
import 'package:kacha_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:kacha_test/features/auth/domain/use_cases/register_use_case.dart';
import 'package:kacha_test/features/auth/presentation/providers/state/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase = injector.get<LoginUseCase>();
  final RegisterUseCase _registerUseCase = injector.get<RegisterUseCase>();

  AuthNotifier() : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await _loginUseCase.execute(email, password);
    state = result.fold(
      (failure) => AuthState.failure(failure.message!),
      (user) => AuthState.authenticated(user),
    );
  }

  Future<void> register(String email, String password, String name) async {
    state = const AuthState.loading();
    final result = await _registerUseCase.execute(email, password, name);
    state = result.fold(
      (failure) => AuthState.failure(failure.message!),
      (user) => AuthState.authenticated(user),
    );
  }

  void logout() {
    state = const AuthState.unauthenticated();
  }
}
