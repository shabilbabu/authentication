import 'dart:developer';

import 'package:authentication/app/data/services/authentication/authentication.dart';
import 'package:authentication/app/modules/welcome/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
    RxBool showLoading = false.obs;

    bool validation(){
      final form = globalFormKey.currentState;
      if(form!.validate()){
        form.save();
        return true;
      }
      return false;
    }

    clearText(){
      emailController.clear();
      passwordController.clear();
    }

    loginFunction({
      required String email,required String password,
    }) async {
      showLoading.value == true;
      try{
        final response = await ApiServices().login(email: email, password: password);
        if(response == 'e'){
          showLoading.value =false;
          Get.snackbar("Server Error", "can't login right now, please try again later",
          icon: const Icon(Icons.error_outline, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,);
        }
        if(response.statusCode == 204){
          showLoading.value = false;
          Get.snackbar(
          " Warning",
          "User not Found ,please enter existing account",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
        } else if (response.statusCode == 200){
          showLoading.value = false;
        Get.snackbar(
          " Warning",
          "wrong password, please enter valid password",
          icon: const Icon(Icons.warning, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
        );
        } else if(response.statusCode == 201){
          try{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final result = await prefs.setString("user", response.body);
            showLoading.value = false;
            clearText();
            result == true ? Get.offAll(WelcomeView()) : null;
          } catch (e){
            showLoading.value =false;
            Get.snackbar(" Local error",
            "Account created , please try again later",
            icon: const Icon(Icons.warning, color: Colors.red),
            snackPosition: SnackPosition.BOTTOM,);
          }
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
