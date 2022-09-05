import 'package:authentication/app/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  WelcomeView({Key? key}) : super(key: key);

  WelcomeController welcomeController = Get.put(WelcomeController());
  final SignUpController signupController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Center(
          child:  Text(
            'Welcome View',
            style: TextStyle(color: Colors.white,),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const SizedBox(height: 10,),
              Text(
                "name : ${welcomeController.userModel.value?.name ?? "couldn't find"}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10,),
              Text(
               "email : ${ welcomeController.userModel.value?.email ?? "couldn't find"}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
             const   SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  welcomeController.logOut();
                  signupController.signupClear();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration:  BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Center(child:  Text('Logout',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),)),
              
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
