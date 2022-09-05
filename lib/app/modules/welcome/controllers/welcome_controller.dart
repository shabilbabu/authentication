import 'dart:convert';
import 'package:authentication/app/data/model/user_model.dart';
import 'package:authentication/app/modules/wraper/views/wraper_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  RxBool showLoading = false.obs;
  final Rx<UserModel?> userModel = UserModel().obs;

  WelcomeController(){
    displayData();
  }

  displayData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('user');
    userModel.value = UserModel.fromJson(jsonDecode(result!));
  }

  logOut() async {
    showLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('user');
    if(result){
      showLoading.value = false;
      Get.offAll(WraperView());

    }else {
      showLoading.value = false;
      Get.snackbar("Error", "please try again later");
      const  Icon(Icons.warning, color: Colors.red);
      SnackPosition.BOTTOM;
    }
  }

}
