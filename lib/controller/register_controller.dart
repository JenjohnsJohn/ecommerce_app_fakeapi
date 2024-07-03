import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = Get.find();

  // ... TextControllers for email, username, password, etc.
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final phoneController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage

    super.onInit();
  }

  void register() async {
    // Validate form fields
    if (!isValidForm()) return;

    try {
      isLoading(true);
      errorMessage('');
      final response = await _authService.register(UserModel(
        // ... (create UserModel instance from the form fields)
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
        name: Name(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
        ),
        address: Address(
          city: cityController.text,
          street: streetController.text,
          number:
              int.tryParse(numberController.text) ?? 0, // Handle parsing errors
          zipcode: zipcodeController.text,
          geolocation: Geolocation(
            lat: latController.text,
            long: longController.text,
          ),
        ),
        phone: phoneController.text,
      ));

      if (response != null) {
        Get.back();
        Get.snackbar(
          'Success',
          'Registered successfully, Please Login !',
        );
      } else {
        throw Exception('Registration failed');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  bool isValidForm() {
    // ... your form validation logic
    return true; // Assuming valid for now
  }
}
