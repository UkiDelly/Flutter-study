import 'package:get/get.dart';

import '../model/product.dart';

class ShoppingController extends GetxController {
  // product 리스트를 구독 가능한 변수로 만든다.
  List<Product> products = <Product>[].obs;

  // Controller가 생성될떄 실행할 메소드
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    List<Product> productData = [
      Product(
          id: 1,
          productName: 'Monitor',
          productDescription: 'monitor for pc',
          price: 30),
      Product(
          id: 2,
          productName: 'Desktop',
          productDescription: 'the important part of the computer setup',
          price: 700),
      Product(
          id: 3,
          productName: 'Mouse',
          productDescription: 'need to move the cursor',
          price: 45)
    ];

    // products에 데이터 전부 넣기
    products.assignAll(productData);
  }
}
