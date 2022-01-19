import 'package:flutter/material.dart';

class AppImput extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  bool obscureText;
  AppImput({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFff7521),
          ),
        ),
      ),
      child: TextField(
        cursorColor: const Color(0xFFf99321),
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          focusColor: const Color(0xFFf99321),
          fillColor: Colors.white,
          hoverColor: Colors.red,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFf99321),
            ),
          ),
        ),
      ),
    );
  }
}
