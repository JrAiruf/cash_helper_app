import 'package:flutter/material.dart';

import 'cash_helper_bottom_navigation_bar.dart';

class CashHelperBottomNavigationItem extends StatelessWidget {
  final IconData? icon;
  final String? itemName;
  final Color? itemBackgroundColor;
  final Color? contentColor;
  final BottomNavigationBarPosition? position;
  final void Function()? onTap;

  const CashHelperBottomNavigationItem(
      {super.key,
      this.icon,
      this.itemName,
      this.itemBackgroundColor,
      required this.position,
      this.contentColor,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: itemBackgroundColor ?? Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: contentColor,
              ),
              Text(
                itemName ?? '',
                style: TextStyle(color: contentColor, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
