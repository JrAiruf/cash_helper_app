import 'package:flutter/material.dart';

import '../../../domain/entities/operator_entity.dart';

class ProfileInformationCard extends StatelessWidget {
  const ProfileInformationCard({
    super.key,
    this.height,
    this.width,
    this.title,
    this.content,
    this.backgroundColor,
    this.borderColor,
    this.items,
  });

  final double? height;
  final double? width;
  final String? title;
  final String? content;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<Widget>? items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: height ?? 10,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.white),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items ?? [],
          ),
        ),
      ),
    );
  }
}
