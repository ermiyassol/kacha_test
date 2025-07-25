import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:kacha_test/features/auth/presentation/providers/state/auth_state.dart';

final authNotifierProvider =
    AutoDisposeStateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(),
    );
