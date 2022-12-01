import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/controllers/signupController.dart';
import 'package:pertemuan_10_12/routes.dart';
import 'package:pertemuan_10_12/widgets/customButton.dart';
import 'package:pertemuan_10_12/widgets/customTextField.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({
    Key? key,
  }) : super(key: key);

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<SignupController>(
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(height: 120,),
                  Text(
                    'Toko',
                    style: TextStyle(
                      fontSize: 54,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  const SizedBox(height: 50,),

                  CustomTextField(
                    hint: 'Name', 
                    controller: controller.nameController,
                  ),

                  const SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Email', 
                    controller: controller.emailController
                  ),

                  const SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Password',
                    obsecureText: true,
                    controller: controller.passwordController
                  ),

                  const SizedBox(height: 10,),

                  CustomTextField(
                    hint: 'Confirm Password',
                    obsecureText: true,
                    controller: controller.passwordConfirmController,
                  ),

                  const SizedBox(height: 20,),

                  CustomButton(
                    label: 'Register', 
                    onPressed: (){
                      controller.checkSignup();
                  }),

                  const SizedBox(height: 10,),

                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff949494)
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                        ),
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Get.toNamed(GetRoutes.login);
                            },
                          style: TextStyle(
                            color: Color(0xff6b7afc),
                            fontWeight: FontWeight.w600
                          )
                        )
                      ]
                    ),
                    textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
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