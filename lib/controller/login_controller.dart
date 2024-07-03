import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();

  final loginFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage
    usernameController.text = 'johnd';
    passwordController.text = "m38rmF\$";
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void login() async {
    try {
      isLoading(true);
      errorMessage(''); // Clear any previous error messages
      final response = await _authService.login(
        usernameController.text,
        passwordController.text,
      );

      if (response != null) {
        // Successfully logged in, handle the response (e.g., store token)
        Get.snackbar('Success', 'Logged in successfully');
      } else {
        throw Exception('Login failed'); // Handle other cases if needed
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Api Simulation
  Future<bool> checkUser(String user, String password) {
    if (user == 'foo@foo.com' && password == '123') {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
