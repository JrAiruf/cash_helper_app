import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/buttons/manager_view_button.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

class OperatorPendencyCard extends StatelessWidget {
  const OperatorPendencyCard({
    required this.annotation,
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.cardHeight,
    this.cardWidth,
  });

  final AnnotationEntity annotation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? cardHeight;
  final double? cardWidth;
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? Colors.white,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              annotation.annotationClientAddress ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
                border: Border.all(
                  color: borderColor ?? Colors.white,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  annotation.annotationSaleValue ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: appThemes.surfaceColor(context),
                      ),
                ),
              ),
            ),
            Text(
              annotation.annotationSaleTime ?? "",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            Text(
              annotation.annotationPaymentMethod ?? "",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            ManagerViewButton(
              onPressed: () {},
              text: "Finalizar",
            )
          ],
        ),
      ),
    );
  }
}