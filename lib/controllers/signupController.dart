import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/routes.dart';
import 'package:pertemuan_10_12/utils/baseurl.dart';
import 'package:pertemuan_10_12/widgets/customSnackbar.dart';
import 'package:pertemuan_10_12/widgets/Loader.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController{
  late TextEditingController 
  nameController,
  emailController,
  passwordController,
  passwordConfirmController;

  @override
  void onInit(){
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void onClose(){
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  checkSignup(){
    if (nameController.text.isEmpty) {
      customSnackbar("Error", "Name is required", "error");
      return;
    } 
    else if (emailController.text.isEmpty || GetUtils.isEmail(emailController.text) == false){
      customSnackbar("Error", "A valid email is required", "error");
      return;
    } else if (passwordController.text.isEmpty){
      customSnackbar("Error", "Password is required", "error");
      return;
    } else if (passwordController.text != passwordConfirmController.text){
      customSnackbar("Error", "Password confirmation does not match", "error");
      return;
    } else {
      Get.showOverlay(asyncFunction: ()=>signup(), loadingWidget: const Loader());
    }
  }

  signup() async{
    var response = await http.post(Uri.parse(registerUrl),
    headers: {'Accept' : 'application/json'},
    body: {
      "name" : nameController.text,
      "email" : emailController.text,
      "password" : passwordController.text,
      "password_confirmation" : passwordConfirmController.text
    });

    var res = await json.decode(response.body);
    if (response.statusCode == 200) {
      customSnackbar("Success", res['message'], "success");
      _save(res['token']);
      Get.offAllNamed(GetRoutes.home);
    } else {
      customSnackbar("Error", res['message'], "error");
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
}
