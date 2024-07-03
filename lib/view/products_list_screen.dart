import 'package:ecommerce_app_fakeapi/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../service/auth_service.dart';
import '../service/product_service.dart';
import 'home_screen.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({super.key});

  final ProductController productController = Get.put(ProductController());
  final AuthService authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Obx(
          () => productController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: productController.dataList.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    itemBuilder: (BuildContext context, int index) {
                      ProductService productService = Get.put(ProductService());
                      Widget fav = Obx(
                        () => Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              if (productService.fav.contains(
                                  productController.dataList[index])) {
                                productController.removeFav(
                                    productController.dataList[index]);
                              } else {
                                productController
                                    .addFav(productController.dataList[index]);
                              }
                            },
                            color: Colors.red,
                            icon: Icon(productService.fav
                                    .contains(productController.dataList[index])
                                ? Icons.favorite
                                : Icons.favorite_border),
                          ),
                        ),
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            Get.to(ProductDetailScreen(
                              product: productController.dataList[index],
                            ));
                          },
                          child: ProductTile(
                            title:
                                productController.dataList[index].title ?? "",
                            price: productController.dataList[index].price
                                    .toString() ??
                                "",
                            image: productController.dataList[index].image ??
                                "assets/images/product1.jpg",
                            product: productController.dataList[index],
                            fav: fav,
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .7,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
