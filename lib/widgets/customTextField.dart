import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key, 
    required this.hint, 
    this.obsecureText = false, 
    this.controller, 
    this.keyboardType = TextInputType.text
  }) : super(key: key);

  final String hint;
  final bool obsecureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0,3),
            blurRadius: 12
          )
        ]
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xff949494)
          ),
        ),
      )
    );
  }
}