// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

class AnnotationListTile extends StatelessWidget {
  AnnotationListTile({super.key,required this.onTap, required this.annotationEntity});

  AnnotationEntity annotationEntity;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    final tileHeight = MediaQuery.of(context).size.height * 0.13;
    final tileWidth = MediaQuery.of(context).size.width;
    final appTheme = CashHelperThemes();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: appTheme.surfaceColor(context),
          ),
        ),
        height: tileHeight,
        width: tileWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Endereço:",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                  Text(
                    annotationEntity.annotationClientAddress ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Valor:",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                  Text(
                    annotationEntity.annotationSaleValue ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pagamento:",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                  Text(
                    annotationEntity.annotationPaymentMethod ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appTheme.surfaceColor(context),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
