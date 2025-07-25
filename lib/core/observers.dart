import 'package:flutter_riverpod/flutter_riverpod.dart';

class Observers extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // You can add logging or analytics here
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);
  }
}
