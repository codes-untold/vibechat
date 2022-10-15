import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(10),
        border: InputBorder.none,
        isDense: true,
        isCollapsed: true,
        fillColor: Color(0xfffafbfc),
        filled: true,
        hintText: "Search.",
        hintStyle: TextStyle(fontSize: 14),
        suffixIconConstraints: BoxConstraints.tightFor(width: 30, height: 30),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
