import 'package:flutter/material.dart';

class OptionsPageMenuComponent extends StatelessWidget {
  const OptionsPageMenuComponent(
      {super.key,
      this.itemColor,
      this.borderColor,
      this.onTap,
      this.height,
      this.width,
      this.elevation,
      this.radius,
      this.icon,
      this.itemName});

  final Color? itemColor;
  final Color? borderColor;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final double? elevation;
  final double? radius;
  final IconData? icon;
  final String? itemName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 70,
        width: width ?? 70,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.white, width: 0.5),
              borderRadius: BorderRadius.circular(radius ?? 4)),
          color: itemColor ?? Colors.white,
          elevation: elevation ?? 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 35,
              ),
              Text(
                itemName ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
