import 'package:flutter/material.dart';

class CashHelperInformationCard extends StatelessWidget {
  const CashHelperInformationCard(
      {super.key,
      this.height,
      this.width,
      this.radius,
      this.spacing,
      this.backgroundColor,
      this.cardIcon,
      this.iconSize,
      this.informationTitle,
      this.information,
      this.complementInformationTitle,
      this.complementInformation});

  final double? height;
  final double? width;
  final double? radius;
  final double? spacing;
  final Color? backgroundColor;
  final IconData? cardIcon;
  final double? iconSize;
  final String? informationTitle;
  final String? information;
  final String? complementInformationTitle;
  final String? complementInformation;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius ??4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              cardIcon,
              size: iconSize,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    informationTitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    information ?? "",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complementInformationTitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    complementInformation ?? "",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
