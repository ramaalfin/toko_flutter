import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key, 
    required this.label,
    required this.onPressed
  }) : super(key: key);

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xff29000000),
              offset: Offset(0, 3),
              blurRadius: 12
            )
          ]
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xfffffffff),
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}