import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');

    // select() 함수를 이용하면, state의 특정 값만 가져올수 있다.
    final isSpicy = ref.watch(selectProvider.select((state) => state.isSpicy));

    ref.listen(
      selectProvider.select((state) => state.hasBought),
      (previous, next) {
        print(next);
      },
    );

    return DefaultLayout(
      title: 'Select Provider',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isSpicy.toString()),
            // Text(state.name),
            // Text(
            //   state.isSpicy.toString(),
            // ),
            // Text(
            //   state.hasBought.toString(),
            // ),
            ElevatedButton(
              onPressed: () => ref.read(selectProvider.notifier).toggleIsSpicy(),
              child: const Text('Toggle Spicy'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(selectProvider.notifier).toggleHasBought(),
              child: const Text('Toggle Bought'),
            ),
          ],
        ),
      ),
    );
  }
}
