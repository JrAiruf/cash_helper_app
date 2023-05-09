import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    this.width,
    this.icon,
    this.title,
    this.itemColor,
    this.onTap,
  });
  final double? width;
  final IconData? icon;
  final String? title;
  final Color? itemColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: primaryColor)),
        width: width,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: itemColor,
            ),
            const SizedBox(width: 35),
            Text(
              title ?? "",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: itemColor),
            )
          ],
        ),
      ),
    );
  }
}
