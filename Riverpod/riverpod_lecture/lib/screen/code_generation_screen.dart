import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/code_generation_provider.dart';

class CodeGeneratioNScreen extends ConsumerWidget {
  const CodeGeneratioNScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 이전에 사용하던 방법으로 state을 가져오기
    final state = ref.watch(getStateProvider);
    final futureState = ref.watch(getStateFutureProvider);
    final futureState2 = ref.watch(getStateFuture2Provider);
    final familyState = ref.watch(getStateMultiplyProvider(number1: 5, number2: 5));

    // StateNotifier state 가져오기
    final stateNotifierState = ref.watch(getStateNotifierProvider);
    return DefaultLayout(
      title: 'Code Generation',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('State: $state'),
            const SizedBox(height: 20),
            futureState.when(
              data: (data) => Text('Future state: $data'),
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            futureState2.when(
              data: (data) => Text('Future state that keep alive: $data'),
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            Text('Family state: $familyState'),

            // state notifier
            const SizedBox(height: 20),
            Text('StateNotifier state: $stateNotifierState'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(getStateNotifierProvider.notifier).increment(),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(getStateNotifierProvider.notifier).decrement(),
                  child: const Text('-'),
                )
              ],
            )

            // invalidate() 함수 테스트
            // state을 더이상 유효하지 않게 해서 초기상태로 되돌린다.
            ,
            ElevatedButton(
              onPressed: () {
                // ref.invalidate()는 2.0에 추가된 함수이다.
                // StateNotifierProvider를 초기화 즉, 초기값은 0으로 되돌아간다.
                ref.invalidate(getStateNotifierProvider);
              },
              child: const Text('Invalidate'),
            ),
          ],
        ),
      ),
    );
  }
}
