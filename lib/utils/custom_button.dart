import 'package:emedoc/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  Color? color;
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color ?? appBarColor),
        child: Text(
          text,
          style: const TextStyle(
            color: textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
