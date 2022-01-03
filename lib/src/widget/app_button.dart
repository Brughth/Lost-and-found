import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Color firstColor;
  Color secondColor;
  VoidCallback? onTap;
  AppButton({
    Key? key,
    required this.text,
    required this.firstColor,
    required this.secondColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 320,

      // margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            firstColor,
            secondColor,
            //Color(0xFFffb421),
            //Color(0xFFff7521),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
