import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/common/widgets/default_layout.dart';
import 'package:riverpod_lecture/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() => _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    // initState 함수에는 절대로 ref.watch()를 사용하면 안됀다. initState는 단발성(일회성)으로 실행되기 때문이다.
    controller = TabController(
      length: 10,
      vsync: this,

      // initState()는 단발성(일회성)으로 실행하기 때문에 provider의 값을 일회성으로 가져오는 read() 함수를 사용한다.
      initialIndex: ref.read(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    // listen 함수에는 3가지 파라미터가 있는데, 첫번째는 provider를 넣고,
    // previous는 이전 state을 의미하고, next는 변경된 이후의 state을 의미한다.
    // generic을 넣어서 반환값을 지정할수도 있다.
    ref.listen<int>(listenProvider, (previous, next) {
      // provider에 변경이 일어나면 listen 함수가 실행된다.
      // 지금의 경우 provider 값이 변경될때마다, controller의 값을 바꾸고 있다.
      if (previous != next) {
        controller.animateTo(next);
      }

      // dispose를 자동으로 하기 때무네 listen할 필요 없다.
    });

    return DefaultLayout(
      title: 'Listen Provider',
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update((state) => state == 10 ? 10 : state + 1);
                },
                child: const Text('다음'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update((state) => state == 0 ? 0 : state - 1);
                },
                child: const Text('이전'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
