import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

class PendencyFinishingWidget extends StatelessWidget {
  const PendencyFinishingWidget({super.key, required this.annotation, required this.height, required this.width});

  final AnnotationEntity annotation;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    return SizedBox(
      height: height * 0.29,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              annotation.annotationClientAddress ?? "",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              annotation.annotationSaleValue ?? "",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Valor",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              annotation.annotationSaleTime ?? "",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hora da Compra",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: appThemes.surfaceColor(context),
                      ),
                ),
                Text(
                  annotation.annotationPaymentMethod ?? "",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: appThemes.surfaceColor(context),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
