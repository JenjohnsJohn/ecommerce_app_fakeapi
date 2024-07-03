import 'package:ecommerce_app_fakeapi/controller/login_controller.dart';
import 'package:ecommerce_app_fakeapi/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            height: 400,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: controller.usernameController,
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        validator: controller.validator,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: controller.validator,
                        obscureText: true,
                      ),
                      // MaterialButton(
                      //   child: Text('Login'),
                      //   onPressed: controller.login,
                      // )

                      Obx(() => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller
                                    .login, // Disable button while loading
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Login'),
                          )),

                      Obx(() => Text(controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red))),

                      ElevatedButton(
                        onPressed: () => Get.to(() => RegisterScreen()),
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
