import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/controllers/loginController.dart';
import 'package:pertemuan_10_12/routes.dart';
import 'package:pertemuan_10_12/widgets/customButton.dart';
import 'package:pertemuan_10_12/widgets/customTextField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  final loginController = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<LoginController>(
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(height: 120,),
                  const Text(
                    'Toko',
                    style: TextStyle(
                      fontSize: 54,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  const SizedBox(height: 50,),

                  CustomTextField(
                    hint: 'Email', 
                    controller: controller.emailController,
                  ),

                  const SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Password',
                    obsecureText: true,
                    controller: controller.passwordController,
                  ),

                  const SizedBox(height: 20,),

                  CustomButton(
                    label: 'Login', 
                    onPressed: (){
                      controller.checkLogin();
                  }),

                  const SizedBox(height: 10,),

                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff949494)
                      ),
                      children: [
                        const TextSpan(
                          text: 'Don\'t have any account? ',
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Get.toNamed(GetRoutes.signup);
                            },
                          style: const TextStyle(
                            color: Color(0xff6b7afc),
                            fontWeight: FontWeight.w600
                          )
                        )
                      ]
                    ),
                    textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                    softWrap: false,
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}