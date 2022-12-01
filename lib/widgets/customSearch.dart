import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    required this.onChanged
  }) : super(key: key);

  final Function(String) onChanged;

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
        onChanged: (String val){
          onChanged(val);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'search',
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xff949494)
          ),
        ),
      )
    );
  }
}