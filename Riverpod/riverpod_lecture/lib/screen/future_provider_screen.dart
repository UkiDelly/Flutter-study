import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multiplesFutureProvider);

    return DefaultLayout(
      title: 'Future Provider',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.when(
              data: (data) {
                return Text(
                  data.toString(),
                  textAlign: TextAlign.center,
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
