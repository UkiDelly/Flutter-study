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
          ],
        ),
      ),
    );
  }
}
