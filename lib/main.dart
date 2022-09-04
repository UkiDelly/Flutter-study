import 'package:flutter/material.dart';
import 'package:flutter_study/controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter study', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX")),

      //
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Riverpod의 Consumer과 같은 역할의 위젯
          // 타입을 반드시 명시해야한다.
          GetBuilder<Controller>(

              // init에서 해당 타입의 instance를 바로 생성하는 것이 가능하다.
              init: Controller(),
              // 해당 타입의 instanse가 자동으로 parameter에 들어온다.
              builder: (controller) => Column(
                    children: [
                      // Get.find<타입>()를 통해 instance를 찾는 것이 가능하다.
                      Text("Value: ${Get.find<Controller>().x}",
                          style: Theme.of(context).textTheme.headline6),

                      // 이렇게 데이터에 접근하는 것도 가능하다.
                      Text(
                        "Value: ${controller.x}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )),

          ElevatedButton(

              // Get.find<타입>()을 통해 Controller 인스턴스를 찾아내서 increment()를 호출한다.
              onPressed: () => Get.find<Controller>().increment(),
              child: const Text("Add number"))
        ],
      )),
    );
  }
}
