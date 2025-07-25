import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/features/dashboard/presentation/providers/state/wallet_notifier.dart';
import 'package:kacha_test/features/dashboard/presentation/providers/state/wallet_state.dart';

final walletNotifierProvider =
    AutoDisposeStateNotifierProvider<WalletNotifier, WalletState>(
      (ref) => WalletNotifier(),
    );
