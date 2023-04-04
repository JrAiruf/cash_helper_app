import 'package:flutter/material.dart';

class CashHelperLoginButton extends StatelessWidget {
  const CashHelperLoginButton(
      {super.key,
      this.onPressed,
      this.buttonName,
      this.backgroundColor,
      this.nameColor,
      this.radius,
      this.height,
      this.width,
      this.fontSize});

  final void Function()? onPressed;
  final String? buttonName;
  final Color? backgroundColor;
  final Color? nameColor;
  final double? radius;
  final double? fontSize;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
          ),
          fixedSize: Size(width ?? 105, height ?? 45)),
      onPressed: onPressed,
      child: Text(
        buttonName ?? '',
        style: TextStyle(color: nameColor, fontSize: fontSize ?? 20),
      ),
    );
  }
}
