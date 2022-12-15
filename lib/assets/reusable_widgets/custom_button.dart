import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double height;
  double width;
  String buttonText;
  Color buttonTextColor;
  Color buttonColor;
  void Function()? onPressed;
  double fontSize;

  CustomButton({
    required this.height,
    required this.width,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonColor,
    required this.onPressed,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      height: height,
      minWidth: width,
      color: buttonColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: fontSize,
          color: buttonTextColor,
        ),
      ),
    );
  }
}
