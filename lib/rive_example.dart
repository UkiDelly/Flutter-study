import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveExample extends StatefulWidget {
  const RiveExample({super.key});

  @override
  State<RiveExample> createState() => _RiveExampleState();
}

class _RiveExampleState extends State<RiveExample> {
  late StateMachineController controller;
  void onInit(Artboard artboard) {
    controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine',
    ) as StateMachineController;

    artboard.addController(controller);
    setState(() {
      controller.isActive = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              // https://rive.app/community/3902-8169-pathfinder/ <- 예제 애니매이션
              child: RiveAnimation.asset(
                // .riv 파일 가져오기
                'assets/nodegen.riv',
                artboard: 'Logo Animation',
                // riv파일에서 사용할 artboard 이름설정
                // riv파일에서 사용할 애니메이션 컨트롤러
                // controllers: [controller],

                // riv파일에서 사용할 state machine 가져오기
                // stateMachines: ['State Machine 1'],

                // Rive 위젯이 생성될때 실행될 함수
                onInit: onInit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
