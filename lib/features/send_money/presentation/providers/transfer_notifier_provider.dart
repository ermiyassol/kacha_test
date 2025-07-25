import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/features/send_money/presentation/providers/state/transfer_notifier.dart';
import 'package:kacha_test/features/send_money/presentation/providers/state/transfer_state.dart';

final transferNotifierProvider =
    AutoDisposeStateNotifierProvider<TransferNotifier, TransferState>(
      (ref) => TransferNotifier(),
    );
