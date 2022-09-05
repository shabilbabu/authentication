import 'package:authentication/app/modules/login/views/login_view.dart';
import 'package:authentication/app/modules/welcome/views/welcome_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wraper_controller.dart';

class WraperView extends GetView<WraperController> {
   WraperView({Key? key}) : super(key: key);

  final WraperController wraperController = Get.put(WraperController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: wraperController.checkInAuthentication(),
      builder: ((context, dynamic snapshot) {
        if(snapshot == null){
          return const CircularProgressIndicator();
        } else if (snapshot.data == true){
          return WelcomeView();
        }
        return LoginView();
      })
      );
  }
}
