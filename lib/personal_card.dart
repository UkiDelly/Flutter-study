import 'package:flutter/material.dart';
import 'package:flutter_study/controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

//* Obx, GetX, GetBuilder 차이점

//? Obx
//* Observable(Obs)의 변화를 listen(추적)함
//* Controller 인스턴스가 미리 다른 곳에 initialize 되어 있어야함

//? GetX
//* Observable(Obs)의 변화를 listen(추적)함
//* 자체적으로 Controller 인스턴스를 initialize 할수 있음
//* Obx보다 다양한 기능을 내장하고 있기 때문에 Obx보다 무거움

//? Getbuilder
//* Observable(Obs)의 변화를 listen(추적)하지 않음!
//* 수동으로 UI를 재빌드하기 때문에 반드시 update() 메소드를 호출해야함
//* 자체적으로 Controller 인스턴스를 initialize 할수 있음

class PersonalCard extends StatelessWidget {
  const PersonalCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller instance 생성
    final Controller controller = Get.put(Controller());

    return Scaffold(
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Controller의 updateInfo()를 호출
          controller.updateInfo();
        },
        child: const Icon(Icons.add),
      ),

      //
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff89dad0)),
              child: Center(
                //* Getx
                child: GetX<Controller>(
                    builder: (_) => Text('Name: ${controller.person().name}')),
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff89dad0)),
              child: Center(
                  //* Obx
                  child: Obx(
                () => Text('Age: ${controller.person().age}'),
              )),
            ),

            //
            Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff89dad0)),
              child: Center(
                //* Getx
                child: GetX<Controller>(

                    // init을 통해 바로 Controller 인스턴스를 생성할수 있다.
                    init: Controller(),
                    builder: (_) =>
                        Text('Name: ${Get.find<Controller>().person().name}')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
