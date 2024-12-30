import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 0,
    this.height = 52,
  });

  final VoidCallback? onPressed;
  final String text;
  final double fontSize;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double height;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:  onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
        ),
        minimumSize: Size(double.infinity, height),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1.5,
        ),
      )
    );
  }
}
