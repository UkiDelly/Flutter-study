import 'package:get/get_state_manager/get_state_manager.dart';

class Controller extends GetxController {
  int _x = 0;

  int get x => _x;

  void increment() {
    _x++;
    // state가 바뀌었음을 알리기 위해 update()를 반드시 호출해야한다.
    update();
  }
}
