import 'package:get/get.dart';

import 'model.dart';

class Controller extends GetxController {
  // .obs를 추가함으로써, 이 instance를 observable로 만든다. 즉 구독 가능한 변수로 만든다.
  final person = Person().obs;

  void updateInfo() {
    // GetBuilder의 업데이트와 달리, instance의 value에 접근이 가능하다.
    person.update((person) {
      person?.age++;
      person?.name = 'Dae Hyeon';
    });
  }
}
