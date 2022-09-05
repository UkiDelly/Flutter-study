import 'package:flutter/material.dart';
import 'package:flutter_study/controller/cart_controller.dart';
import 'package:flutter_study/controller/shopping_controller.dart';
import 'package:get/get.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  // controller instance 생성
  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          GetX<ShoppingController>(builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.products[index].productName,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                Text(controller
                                    .products[index].productDescription)
                              ],
                            ),
                            Text(
                              '\$${controller.products[index].price}',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                        ElevatedButton(

                            // controller의 product 리스트의 index에 해당하는 product를 cartController의 addItem() 메소를 통해 카트에 해당 product를 추가한다.
                            onPressed: () => cartController
                                .addItem(controller.products[index]),
                            child: const Text('Add to Cart'))
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(
            height: 30,
          ),
          GetX<CartController>(builder: (controller) {
            return Text(
              '\$${controller.totalPrice}',
              style: const TextStyle(fontSize: 25, color: Colors.white),
            );
          })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<CartController>(builder: (controller) {
          return Text(
            // count 값 불러오기
            controller.count.toString(),
            style: const TextStyle(fontSize: 20),
          );
        }),
        icon: const Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.black,
      ),
    );
  }
}
