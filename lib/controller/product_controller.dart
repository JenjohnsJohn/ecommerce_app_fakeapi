import 'package:ecommerce_app_fakeapi/model/product.dart';
import 'package:ecommerce_app_fakeapi/service/api_service.dart';
import 'package:ecommerce_app_fakeapi/service/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ApiService _apiService = Get.find();
  ProductService productService = Get.find();

  var isLoading = true.obs;
  var dataList = <Product>[].obs;
  var categoryList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var data = await _apiService.fetchProducts();
      dataList(data);
    } finally {
      isLoading(false);
    }
  }

  void fetchCategory() async {
    try {
      isLoading(true);
      var data = await _apiService.fetchCtegories();

      categoryList(data);
    } finally {
      isLoading(false);
    }
  }

  void addFav(Product product) {
    productService.fav.add(product);
  }

  void removeFav(Product product) {
    productService.fav.remove(product);
  }
}
