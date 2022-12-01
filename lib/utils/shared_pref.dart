import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  storeUser(user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', user);
  }

  getUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final key = 'id';
    final value = pref.get(key) ?? 0;
  }

  removeUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('user');
  }
}