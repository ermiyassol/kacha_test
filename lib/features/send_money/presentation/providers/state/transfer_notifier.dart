import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kacha_test/di/Injector.dart';
import 'package:kacha_test/features/send_money/domain/use_cases/send_money_use_case.dart';
import 'package:kacha_test/features/send_money/presentation/providers/state/transfer_state.dart';

class TransferNotifier extends StateNotifier<TransferState> {
  final SendMoneyUseCase _sendMoneyUseCase = injector.get<SendMoneyUseCase>();

  TransferNotifier() : super(const TransferState.initial());

  Future<void> sendMoney(
    String trim, {
    required String recipientId,
    required double amount,
    required String currency,
    String note = '',
  }) async {
    state = const TransferState.loading();

    final result = await _sendMoneyUseCase.execute(
      recipientId,
      amount,
      currency,
      note,
    );

    state = result.fold(
      (failure) => TransferState.failure(failure.message!),
      (transaction) => TransferState.success(transaction),
    );
  }

  void reset() {
    state = const TransferState.initial();
  }
}
