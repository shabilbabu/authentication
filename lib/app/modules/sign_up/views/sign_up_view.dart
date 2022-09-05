import 'package:authentication/app/modules/login/controllers/login_controller.dart';
import 'package:authentication/app/modules/login/views/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({Key? key}) : super(key: key);

  final SignUpController signupController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: signupController.globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: signupController.usernameController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.length <= 4
                          ? "username should be more than 6 charecters"
                          : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(), hintText: 'username'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: signupController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => !val!.contains("@gmail.com")
                          ? "Email Id should be Valid"
                          : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(), hintText: 'email'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: signupController.passwordController,
                      keyboardType: TextInputType.text,
                      validator: (val) => val!.length < 6
                          ? "Password should be more than 6 characters"
                          : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(), hintText: 'password'),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: signupController.confirmPasswordController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Field is required";
                        }else if(signupController.passwordController.text.trim()!=signupController.confirmPasswordController.text.trim()){
                          return "Enter the valid password";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.verified),
                          border: OutlineInputBorder(), hintText: 'password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        final validate = signupController.validation();
                        if (validate == true) {
                          signupController.signupFunction(
                            name: signupController.usernameController.text,
                            email: signupController.emailController.text,
                            password: signupController.passwordController.text,
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Center(
                      child: RichText(
                text: TextSpan(
                  text: "Already have an account  ",
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                  children: <TextSpan>[
                      TextSpan(
                        text: 'Sign in',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              ),
                      ),
                  ],
                ),
              ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: signupController.showLoading.value,
                child: const SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
