import 'dart:developer';

import 'package:authentication/app/modules/welcome/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/authentication/authentication.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  RxBool showLoading = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool validation() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  signupClear(){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  signupFunction(
      {required String name,
      required String email,
      required String password}) async {
    try {
      showLoading.value = true;
      final response = await ApiServices()
          .signUp(username: name, email: email, password: password);
          log(response.toString());
      if (response.statusCode == 200) {
        showLoading.value = false;
        Get.snackbar(
          "warning",
          "User already existing ,Please enter another account",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 201) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final result = await prefs.setString('user', response.body);
          showLoading.value = false;
          result == true ? Get.offAll(WelcomeView()) : null;
        } catch (e) {
          showLoading.value = false;
          Get.snackbar(
            "Local Error",
            "Account created ,Please try again later",
            icon: const Icon(Icons.warning, color: Colors.red),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else if (response == 'e') {
        showLoading.value = false;
        Get.snackbar(
          "Server error",
          "can't login right now, please try again later",
          icon: const Icon(Icons.error_outline, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      showLoading.value = false;
       Get.snackbar(
        "Server error",
        "can't login right now, please try again later",
        icon: const Icon(Icons.error_outline, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
