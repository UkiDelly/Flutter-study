import 'package:get/get.dart';

import '../model/product.dart';

class CartController extends GetxController {
  // cart 리스트를 생성
  List<Product> cartItems = <Product>[].obs;

  // fold 메소드
  // initialValue(0)부터 끝까지 product.price 값을 더한다.
  double get totalPrice => cartItems.fold(0,
      (double previousValue, Product product) => previousValue + product.price);

  //
  int get count => cartItems.length;

  // cart에 item 추가
  void addItem(Product product) {
    cartItems.add(product);
  }
}
