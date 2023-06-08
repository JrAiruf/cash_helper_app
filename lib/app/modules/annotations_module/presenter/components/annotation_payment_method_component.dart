import "package:flutter/material.dart";

import '../../../user_module/presenter/components/cards/annotation_informations_card.dart';

class AnnotationPaymentMethodComponent extends StatelessWidget {
  const AnnotationPaymentMethodComponent(
      {super.key,
      this.cardBackgroundColor,
      this.textColor,
      this.height,
      this.width});

  final Color? cardBackgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnnotationInformationsCard(
            backgroundColor: cardBackgroundColor,
            height: height,
            width: width,
            items: [
              Text(
                "Dinheiro:",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
              Text(
                "25%",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
            ],
          ),
          AnnotationInformationsCard(
            backgroundColor: cardBackgroundColor,
            height: height,
            width: width,
            items: [
              Text(
                "Dinheiro:",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
              Text(
                "25%",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
            ],
          ),
          AnnotationInformationsCard(
            backgroundColor: cardBackgroundColor,
            height: height,
            width: width,
            items: [
              Text(
                "Dinheiro:",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
              Text(
                "25%",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
            ],
          ),
          AnnotationInformationsCard(
            backgroundColor: cardBackgroundColor,
            height: height,
            width: width,
            items: [
              Text(
                "Dinheiro:",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
              Text(
                "25%",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
