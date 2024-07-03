import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_fakeapi/controller/register_controller.dart';
import 'package:ecommerce_app_fakeapi/view/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../model/user_model.dart';

class AuthService extends GetxService {
  final Dio _dio = Dio();
  final _secureStorage = const FlutterSecureStorage();
  var isLogin = false.obs;

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://fakestoreapi.com/auth/login',
        data: jsonEncode({
          'username': username,
          'password': password,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        isLogin.value = true;
        final responseData = response.data;
        final token =
            responseData['token']; // Assuming the token is under a 'token' key
        await _secureStorage.write(key: 'authToken', value: token);
        print(response.data);
        return response.data;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>?> register(UserModel user) async {
    try {
      final response = await _dio.post(
        'https://fakestoreapi.com/users',
        data: jsonEncode(user.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Function to fetch and return the token from secure storage
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'authToken');
  }

  // Function to delete the token from secure storage
  Future<void> logout() async {
    await _secureStorage.delete(key: 'authToken');
    // Optionally, navigate to the login screen
    Get.offAll(() => HomeScreen());
  }
}
