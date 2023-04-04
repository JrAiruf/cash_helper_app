import 'package:flutter/material.dart';

class HomePageCardComponent extends StatelessWidget {
  const HomePageCardComponent(
      {super.key,
      this.itemColor,
      this.seccondaryColor,
      this.height,
      this.width,
      this.fontSize,
      this.elevation,
      this.radius,
      this.icon,
      this.itemName});

  final Color? itemColor;
  final Color? seccondaryColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? elevation;
  final double? radius;
  final IconData? icon;
  final String? itemName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 70,
      width: width ?? 70,
      child: Card(
        shape: RoundedRectangleBorder(
            side:
                BorderSide(color: seccondaryColor ?? Colors.white, width: 0.9),
            borderRadius: BorderRadius.circular(radius ?? 4)),
        color: itemColor?.withOpacity(0.9) ?? Colors.white,
        elevation: elevation ?? 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: seccondaryColor ?? Colors.white,
            ),
            Text(
              itemName ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: seccondaryColor ?? Colors.white,
                  fontSize: fontSize ?? 13),
            ),
          ],
        ),
      ),
    );
  }
}
