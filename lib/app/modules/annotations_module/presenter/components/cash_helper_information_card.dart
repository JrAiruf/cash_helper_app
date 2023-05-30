import 'package:flutter/material.dart';

class CashHelperInformationCard extends StatelessWidget {
  const CashHelperInformationCard(
      {super.key,
      required this.height,
      required this.width,
      required this.radius,
      required this.spacing,
      required this.backgroundColor,
      required this.cardIcon,
      required this.iconSize,
      required this.informationTitle,
      required this.information,
      this.complementInformationTitle,
      this.complementInformation});

  final double height;
  final double width;
  final double radius;
  final double spacing;
  final Color backgroundColor;
  final IconData cardIcon;
  final double iconSize;
  final String informationTitle;
  final String information;
  final String? complementInformationTitle;
  final String? complementInformation;
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
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
              color: surfaceColor,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  informationTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: surfaceColor),
                ),
                Text(
                  information,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: surfaceColor),
                ),
              ],
            ),
            SizedBox(width: spacing),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complementInformationTitle ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: surfaceColor),
                ),
                Text(
                  complementInformation ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: surfaceColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
