import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/models/user.dart';
import 'package:pertemuan_10_12/routes.dart';
import 'package:pertemuan_10_12/utils/baseurl.dart';
import 'package:pertemuan_10_12/utils/shared_pref.dart';
import 'package:pertemuan_10_12/widgets/customSnackbar.dart';
import 'package:pertemuan_10_12/widgets/Loader.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  late TextEditingController emailController, passwordController;

  @override
  void onInit(){
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose(){
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  checkLogin(){
    if (emailController.text.isEmpty || GetUtils.isEmail(emailController.text) == false) {
      customSnackbar("error", "A valid email is required", "error");
      return;
    } else if (passwordController.text.isEmpty){
      customSnackbar("error", "Password is required", "error");
      return;
    } else {
      Get.showOverlay(asyncFunction: ()=>login(), loadingWidget: const Loader());
    }
  }

  login() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final token = prefs.get(key) ?? 0;

    var response = await http.post(Uri.parse(loginUrl),
    headers: {
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    },
    body: {
      "email" : emailController.text,
      "password" : passwordController.text,
    });

    var res = await json.decode(response.body);

    if (response.statusCode == 200) {
      customSnackbar("Success", res['message'], "success");
      User user = User.fromJson(res['user']);
      await SharedPrefs().storeUser(json.encode(user));
      _save(res["token"]);
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

