import 'package:flutter/material.dart';

class AnnotationInformationsCard extends StatelessWidget {
  const AnnotationInformationsCard({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.items,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<Widget>? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.white, width: 0.5),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items ?? [],
      ),
    );
  }
}
