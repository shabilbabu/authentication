import 'package:authentication/app/modules/sign_up/views/sign_up_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: loginController.globalFormKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: loginController.emailController,
                        validator: (value) => !value!.contains("@gmail.com")
                            ? "Email Id should be valid"
                            : null,
                        decoration: const InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: loginController.passwordController,
                        validator: (value) => value!.length < 6
                            ? "Password should be more than 6 charecter"
                            : null,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock)),
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          final validate = loginController.validation();
                          if (validate == true) {
                            loginController.loginFunction(
                              email: loginController.emailController.text,
                              password: loginController.passwordController.text,
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
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
                        text: 'Sign up',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignUpView()),
                              ),
                    ),
                  ],
                ),
              ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: loginController.showLoading.value,
                    child: const SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: ColoredBox(
                        color: Colors.black38,
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
        ),
      ),
    );
  }
}
