import 'package:ecommerce_app_fakeapi/controller/login_controller.dart';
import 'package:ecommerce_app_fakeapi/controller/product_controller.dart';
import 'package:ecommerce_app_fakeapi/model/product.dart';
import 'package:ecommerce_app_fakeapi/service/auth_service.dart';
import 'package:ecommerce_app_fakeapi/service/product_service.dart';
import 'package:ecommerce_app_fakeapi/view/fav_screen.dart';
import 'package:ecommerce_app_fakeapi/view/login_screen.dart';
import 'package:ecommerce_app_fakeapi/view/product_detail_screen.dart';
import 'package:ecommerce_app_fakeapi/view/products_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<LoginController> {
  HomeScreen({super.key});

  final ProductController productController = Get.put(ProductController());
  final AuthService authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => authService.isLogin.value
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Ecommerce App"),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const FavScreen());
                  },
                  icon: const Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag),
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/slider.jpg"),
                          radius: 50,
                        ),
                        Text("Jenjohns"),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text("Favorites"),
                    onTap: () {
                      Get.to(() => const FavScreen());
                    },
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: SizedBox(
                      height: 200.0,
                      width: double.maxFinite,
                      child: Image.asset(
                        "assets/images/slider.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Obx(
                    () => productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            itemCount: productController.categoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryTile(
                                iconData: Icons.fastfood,
                                name:
                                    productController.categoryList[index].title,
                              );
                            },
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                          ),
                  ),
                  InkWell(
                      onTap: () => Get.to(() => ProductsListScreen()),
                      child: const SectionHeading(
                          title: "Products", button_title: "View All")),
                  Obx(
                    () => productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productController.dataList.length,
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              itemBuilder: (BuildContext context, int index) {
                                ProductService productService =
                                    Get.put(ProductService());
                                Widget fav = Obx(
                                  () => Positioned(
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        if (productService.fav.contains(
                                            productController
                                                .dataList[index])) {
                                          productController.removeFav(
                                              productController
                                                  .dataList[index]);
                                        } else {
                                          productController.addFav(
                                              productController
                                                  .dataList[index]);
                                        }
                                      },
                                      color: Colors.red,
                                      icon: Icon(productService.fav.contains(
                                              productController.dataList[index])
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                    ),
                                  ),
                                );
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(ProductDetailScreen(
                                        product:
                                            productController.dataList[index],
                                      ));
                                    },
                                    child: ProductTile(
                                      title: productController
                                              .dataList[index].title ??
                                          "",
                                      price: productController
                                              .dataList[index].price
                                              .toString() ??
                                          "",
                                      image: productController
                                              .dataList[index].image ??
                                          "assets/images/product1.jpg",
                                      product:
                                          productController.dataList[index],
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
                  InkWell(
                    onTap: () => Get.to(() => ProductsListScreen()),
                    child: const SectionHeading(
                        title: "Featured Products", button_title: "View All"),
                  ),
                  Obx(
                    () => productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 250,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: productController.dataList.length,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              itemBuilder: (BuildContext context, int index) {
                                ProductService productService =
                                    Get.put(ProductService());
                                Widget fav = Obx(
                                  () => Positioned(
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        if (productService.fav.contains(
                                            productController
                                                .dataList[index])) {
                                          productController.removeFav(
                                              productController
                                                  .dataList[index]);
                                        } else {
                                          productController.addFav(
                                              productController
                                                  .dataList[index]);
                                        }
                                      },
                                      color: Colors.red,
                                      icon: Icon(productService.fav.contains(
                                              productController.dataList[index])
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                    ),
                                  ),
                                );
                                return SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(ProductDetailScreen(
                                          product:
                                              productController.dataList[index],
                                        ));
                                      },
                                      child: ProductTile(
                                        title: productController
                                                .dataList[index].title ??
                                            "",
                                        price: productController
                                                .dataList[index].price
                                                .toString() ??
                                            "",
                                        image: productController
                                                .dataList[index].image ??
                                            "assets/images/product1.jpg",
                                        product:
                                            productController.dataList[index],
                                        fav: fav,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => ProductsListScreen()),
                    child: const SectionHeading(
                      title: "Popular Products",
                      button_title: "View All",
                    ),
                  ),
                  Obx(
                    () => productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 250,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: productController.dataList.length,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              itemBuilder: (BuildContext context, int index) {
                                ProductService productService =
                                    Get.put(ProductService());
                                Widget fav = Obx(
                                  () => Positioned(
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        if (productService.fav.contains(
                                            productController
                                                .dataList[index])) {
                                          productController.removeFav(
                                              productController
                                                  .dataList[index]);
                                        } else {
                                          productController.addFav(
                                              productController
                                                  .dataList[index]);
                                        }
                                      },
                                      color: Colors.red,
                                      icon: Icon(productService.fav.contains(
                                              productController.dataList[index])
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                    ),
                                  ),
                                );
                                return SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(ProductDetailScreen(
                                          product:
                                              productController.dataList[index],
                                        ));
                                      },
                                      child: ProductTile(
                                        title: productController
                                                .dataList[index].title ??
                                            "",
                                        price: productController
                                                .dataList[index].price
                                                .toString() ??
                                            "",
                                        image: productController
                                                .dataList[index].image ??
                                            "assets/images/product1.jpg",
                                        product:
                                            productController.dataList[index],
                                        fav: fav,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          )
        : const LoginScreen());
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.product,
    required this.fav,
  });
  final String title;
  final String price;
  final String image;

  final Product product;
  final Widget fav;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                    width: double.maxFinite,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Text(
                    "USD " + price,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          fav
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    required this.button_title,
  });
  final String title;
  final String button_title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            button_title,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.iconData,
    required this.name,
  });
  final IconData iconData;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(iconData),
            ),
            Expanded(
              child: Text(
                name.toUpperCase(),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
