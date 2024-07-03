import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../service/product_service.dart';
import 'home_screen.dart';
import 'product_detail_screen.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    ProductService productService = Get.put(ProductService());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Obx(
        () => productController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: productService.fav.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemBuilder: (BuildContext context, int index) {
                    Widget fav = Obx(
                      () => Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            productController
                                .removeFav(productService.fav[index]);
                          },
                          color: Colors.red,
                          icon: Icon(productService.fav
                                  .contains(productService.fav[index])
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
                          title: productController.dataList[index].title ?? "",
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                  ),
                ),
              ),
      ),
    );
  }
}
