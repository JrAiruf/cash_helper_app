import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

class AnnotationInfoListViewComponent extends StatelessWidget {
  const AnnotationInfoListViewComponent({super.key, required this.annotations});

  final List<AnnotationEntity> annotations;
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: ListView.builder(
        itemCount: annotations.isNotEmpty ? annotations.length : 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: annotations.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          annotations[index].annotationClientAddress ?? "",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          annotations[index].annotationSaleValue ?? "",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          "Data da venda:",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          annotations[index].annotationSaleDate?.replaceAll("/", "-") ?? "",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                      ],
                    )
                  : Text(
                      "Nenhuma anotação encontrada",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: appThemes.surfaceColor(context),
                          ),
                    ),
            )),
      ),
    );
  }
}
