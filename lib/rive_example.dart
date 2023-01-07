import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveExample extends StatefulWidget {
  const RiveExample({super.key});

  @override
  State<RiveExample> createState() => _RiveExampleState();
}

class _RiveExampleState extends State<RiveExample> {
  // Rive 파일의 'body_looking, 'hand', 'lights'이름의 애니메이션을 컨트롤하는 컨트롤러
  List<RiveAnimationController> animationController = [
    SimpleAnimation('body_looking'),
    SimpleAnimation('hand'),
    SimpleAnimation('lights'),
  ];

  // Bool 타입의 input
  SMIBool? trigger;

  // state machine을 컨트롤하는 컨트롤서
  late StateMachineController controller;

  // Rive 애니메이션이 생성되면 호출되는 콜백
  String artboard = 'Tour';
  void onInit(Artboard artboard) {
    // Rive 애니메이션의 'Tour' artboard에서 'State Machine 1'이란 이름의 state machine을 불러오기
    final StateMachineController controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1') as StateMachineController;

    // state machine의 애니매이션 실행
    controller.isActive = true;

    // artboard에 컨트롤러 추가
    artboard.addController(controller);

    setState(() {
      this.controller = controller;

      // controller에서 bool타입의 isActive이란 이름의 input 찾기
      trigger = controller.findInput<bool>('isActive') as SMIBool;
    });
  }

  void toggleLight() {
    if (trigger != null) {
      print(trigger!.value);
      setState(() {
        // bool타입의 input의 값을 반전시키기
        trigger!.change(!trigger!.value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Example')),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(onPressed: () => toggleLight(), child: const Text('Toggle Light')),
        SizedBox(
          height: 400,

          // https://rive.app/community/3902-8169-pathfinder/ <- 예제 애니매이션
          child: RiveAnimation.asset(
            // .riv 파일 가져오기
            'assets/example.riv',
            // riv파일에서 사용할 artboard 이름설정
            artboard: artboard,
            // riv파일에서 사용할 애니메이션 컨트롤러
            // controllers: [...animationController],

            // riv파일에서 사용할 state machine 가져오기
            // stateMachines: const ['State Machine 1'],
            // Rive 위젯이 생성될때 실행될 함수
            onInit: onInit,
          ),
        ),
      ])),
    );
  }
}
