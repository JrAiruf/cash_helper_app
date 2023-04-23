import 'package:flutter/material.dart';

class VisibilityIconComponent extends StatelessWidget {
  const VisibilityIconComponent(
      {super.key,
      required this.forVisibility,
      required this.forHideContent,
      required this.condition,
      this.iconColor,
      this.onTap});

  final IconData forVisibility;
  final IconData forHideContent;
  final bool condition;
  final Color? iconColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        condition == true ? forVisibility : forHideContent,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}
