import 'package:flutter/material.dart';

import 'cash_helper_bottom_navigation_item.dart';

class CashHelperBottomNavigationBar extends StatelessWidget {
  const CashHelperBottomNavigationBar(
      {super.key,
      required this.items,
      this.height,
      this.width,
      this.radius,
      this.borderColor,
      this.backgroundColor,
      this.pageController,
      this.position});

  final List<CashHelperBottomNavigationItem?>? items;
  final double? height;
  final double? width;
  final double? radius;
  final Color? borderColor;
  final Color? backgroundColor;
  final PageController? pageController;
  final BottomNavigationBarPosition? position;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius ?? 4),
        topRight: Radius.circular(radius ?? 4),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items!
              .map(
                (bottomNavigationItem) => Expanded(
                  child: CashHelperBottomNavigationItem(
                    pageController: pageController,
                    onTap: bottomNavigationItem?.onTap,
                    contentColor: bottomNavigationItem?.position == position
                        ? Colors.white
                        : backgroundColor,
                    itemBackgroundColor:
                        bottomNavigationItem?.position == position
                            ? backgroundColor
                            : Colors.white,
                    icon: bottomNavigationItem?.icon,
                    itemName: bottomNavigationItem?.itemName,
                    position: bottomNavigationItem?.position,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

enum BottomNavigationBarPosition {
  operatorHome(position: 0),
  operatorOptions(position: 1),
  operatorOppening(position: 2);

  final int position;
  const BottomNavigationBarPosition({required this.position});
}
