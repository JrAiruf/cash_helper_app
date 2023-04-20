import 'package:flutter/material.dart';

class QuickAccessButton extends StatelessWidget {
  const QuickAccessButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.backgroundColor,
    required this.border,
    this.itemsColor,
    this.onPressed,
    this.items,
  });

  final double? height;
  final double? width;
  final double? radius;
  final Color? backgroundColor;
  final bool border;
  final Color? itemsColor;
  final void Function()? onPressed;
  final List<Widget>? items;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 5)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color:
                      border ? itemsColor ?? Colors.white : Colors.transparent,
                  width: 0.9),
              borderRadius: BorderRadius.circular(radius ?? 5),
            ),
            fixedSize: Size(width ?? 105, height ?? 45)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items ?? [],
          ),
        ),
      ),
    );
  }
}
