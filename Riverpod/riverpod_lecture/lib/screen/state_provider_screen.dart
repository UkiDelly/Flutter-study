import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/state_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // 지속적으로 값을 watch해서 변경이 있을때마다 위젯을 재빌드한다.
    // UI 관련 코드에서만 사용하는게 좋다.
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProvider Screen',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: const Text('up'),
            ),
            ElevatedButton(
              onPressed: () {

                // 실행되는 순가 딱 한번 값을 가져온다.
                // onPressed 같은 특정 액션 뒤에 실행할때 read을 사용하는게 좋다.
                // 예를 들어 provider내의 함수 등등
                ref.read(numberProvider.notifier).state--;
              },
              child: const Text('down'),
            )
          ],
        ),
      ),
    );
  }
}
