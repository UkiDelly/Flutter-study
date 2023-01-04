import 'package:flutter/material.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/screen/auto_dispose_modifier_screen.dart';
import 'package:riverpod_lecture/screen/code_generation_screen.dart';
import 'package:riverpod_lecture/screen/family_modifier_screen.dart';
import 'package:riverpod_lecture/screen/future_provider_screen.dart';
import 'package:riverpod_lecture/screen/listen_provider_screen.dart';
import 'package:riverpod_lecture/screen/provider_screen.dart';
import 'package:riverpod_lecture/screen/select_provider_screen.dart';
import 'package:riverpod_lecture/screen/state_notifier_screen.dart';
import 'package:riverpod_lecture/screen/state_provider_screen.dart';
import 'package:riverpod_lecture/screen/strean_proivder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StateProviderScreen(),
              ),
            ),
            child: const Text('StateProvider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StateNotifierProviderScreen(),
              ),
            ),
            child: const Text('State Notifier Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FutureProviderScreen(),
              ),
            ),
            child: const Text('Future Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StreamProviderScreen(),
              ),
            ),
            child: const Text('Stream Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FamilyModifierScreen(),
              ),
            ),
            child: const Text('Family Modifier Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AutoDisposeModifierScreen(),
              ),
            ),
            child: const Text('Auto Dispose Modifier Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListenProviderScreen(),
              ),
            ),
            child: const Text('Listen Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectProviderScreen(),
              ),
            ),
            child: const Text('Select Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProviderScreen(),
              ),
            ),
            child: const Text('Provider in Provider Screen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CodeGeneratioNScreen(),
              ),
            ),
            child: const Text('Code Generation Screen'),
          ),
        ],
      ),
    );
  }
}
