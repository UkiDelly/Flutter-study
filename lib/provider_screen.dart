import 'package:flutter/material.dart';
import 'package:flutter_study/provider/counter_provider.dart';
import 'package:provider/provider.dart';

class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Consumer<Counter>(
              builder: (context, state, child) => Text('${state.count}'),
            ),
            const Spacer(),
            Consumer<Counter>(
              builder: (context, state, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => state.decrement(),
                    child: const Text('Decrement'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => state.increment(),
                    child: const Text('Increment'),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
