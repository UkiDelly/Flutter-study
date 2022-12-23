import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // didUpdateProvider를 이용하면 Provider 값이 업데이트 될때마다 어떤 provider가 어떤 값에서 어떤 값으로 업데이트 됬는데 로깅할수 있다.
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    print('[Provider Updated] provider : $provider / pv = $previousValue  / nv = $newValue');
  }

  // Provider가 추가될때 호출된다.
  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    print('[Provider Added] provider : $provider / value: $value');
  }

  //
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);

    print('[Provider Disposed] provider : $provider');
  }
}
