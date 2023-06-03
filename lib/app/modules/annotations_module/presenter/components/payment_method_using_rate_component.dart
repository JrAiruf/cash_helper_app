import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import "package:flutter/material.dart";

import '../../../user_module/presenter/components/cards/annotation_informations_card.dart';
import '../../domain/entities/annotation_entity.dart';

class PaymentMethodUsingRateComponent extends StatelessWidget {
  const PaymentMethodUsingRateComponent({
    super.key,
    this.componentHeight,
    this.componentWidth,
    required this.paymentMethods,
    required this.annotations,
    this.height,
    this.width,
    this.cardBackgroundColor,
    this.textColor,
  });

  final double? componentHeight;
  final double? componentWidth;
  final double? height;
  final double? width;
  final Color? cardBackgroundColor;
  final Color? textColor;
  final List<PaymentMethodEntity> paymentMethods;
  final List<AnnotationEntity> annotations;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 10,
      ),
      child: SizedBox(
        height: componentHeight,
        width: componentWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: paymentMethods.length,
          itemBuilder: (_, i) {
            final paymentMethodName = paymentMethods[i].paymentMethodName;
            final paymentMethodUsingRate = annotations.where((annotation) {
              return annotation.annotationPaymentMethod == paymentMethodName;
            }).toList();
            final usingRate =
                paymentMethodUsingRate.length / annotations.length * 100;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: AnnotationInformationsCard(
                backgroundColor: cardBackgroundColor,
                height: componentHeight,
                width: width,
                items: [
                  Text(
                    paymentMethodName ?? "",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: textColor,
                        ),
                  ),
                  Text(
                    usingRate.isNaN
                        ? "0 %"
                        : "${usingRate.toStringAsFixed(1)} %",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: textColor,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
