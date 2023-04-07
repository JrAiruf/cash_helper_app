import 'package:flutter/material.dart';

class CashHelperElevatedButton extends StatelessWidget {
  const CashHelperElevatedButton(
      {super.key,
      this.onPressed,
      this.buttonName,
      this.backgroundColor,
      this.nameColor,
      this.border = false,
      this.radius,
      this.height,
      this.width,
      this.fontSize});

  final void Function()? onPressed;
  final String? buttonName;
  final Color? backgroundColor;
  final Color? nameColor;
  final bool border;
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
            side: BorderSide(
                color: border ? nameColor ?? Colors.white : Colors.transparent,
                width: 0.9),
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
