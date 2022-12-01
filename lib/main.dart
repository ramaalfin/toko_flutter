import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertemuan_10_12/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: GetRoutes.login,
      getPages: GetRoutes.routes
    );
  }
}