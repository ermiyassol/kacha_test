import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/features/exchange/presentation/providers/state/exchange_notifier.dart';
import 'package:kacha_test/features/exchange/presentation/providers/state/exchange_state.dart';

final exchangeNotifierProvider =
    AutoDisposeStateNotifierProvider<ExchangeNotifier, ExchangeState>(
      (ref) => ExchangeNotifier(),
    );
