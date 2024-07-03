import 'dart:ffi';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_app_fakeapi/controller/product_controller.dart';
import 'package:ecommerce_app_fakeapi/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    ProductService productService = Get.put(ProductService());
    ProductController productController = Get.put(ProductController());
    Widget fav = Obx(
      () => Positioned(
        right: 0,
        child: IconButton(
          onPressed: () {
            if (productService.fav.contains(product)) {
              productController.removeFav(product);
            } else {
              productController.addFav(product);
            }
          },
          color: Colors.red,
          icon: Icon(productService.fav.contains(product)
              ? Icons.favorite
              : Icons.favorite_border),
        ),
      ),
    );
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.white,
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                fav,
                Center(
                  child: Image.network(product.image!),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(
              product.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "USD " + product.price!.toString(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  RatingBar.readOnly(
                    isHalfAllowed: true,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    initialRating: product.rating!.rate!,
                    size: 20,
                    maxRating: 5,
                  ),
                  Text("(${product.rating!.count!})")
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.category_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  product.category!.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              product.description!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
