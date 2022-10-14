import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/auto_dispose_modifier_provider.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);
    return DefaultLayout(
      title: 'Auto Dispose Modifier',
      body: Center(
        child: state.when(
          data: (data) => Text(
            data.toString(),
          ),
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
