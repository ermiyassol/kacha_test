import 'package:equatable/equatable.dart';
import 'package:kacha_test/models/user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? error;

  const AuthState._({required this.status, this.user, this.error});

  const AuthState.initial() : this._(status: AuthStatus.initial);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(User user)
    : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  const AuthState.failure(String error)
    : this._(status: AuthStatus.failure, error: error);

  @override
  List<Object?> get props => [status, user, error];
}
