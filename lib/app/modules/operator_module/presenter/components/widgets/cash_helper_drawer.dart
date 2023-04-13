import 'package:flutter/material.dart';

class CashHelperDrawer extends StatelessWidget {
  CashHelperDrawer({
    required this.backgroundColor,
    required this.drawerTitle,
    required this.height,
    required this.width,
    required this.drawerItems,
  });
  final Color? backgroundColor;
  final String? drawerTitle;
  final double? height;
  final double? width;
  final List<Widget> drawerItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height! * 0.15),
                Text(drawerTitle ?? "",
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: height! * 0.15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: drawerItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
