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
    return SizedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: itemColor,
            ),
            SizedBox(
              width: width! * 0.05,
            ),
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
