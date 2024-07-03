import 'package:dio/dio.dart';
import 'package:ecommerce_app_fakeapi/model/category.dart';
import 'package:ecommerce_app_fakeapi/model/product.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> fetchCtegories() async {
    try {
      final response =
          await _dio.get('https://fakestoreapi.com/products/categories');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((title) => CategoryModel(title: title.toString()))
            .toList(); // create instances of CategoryModel directly from the response
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
