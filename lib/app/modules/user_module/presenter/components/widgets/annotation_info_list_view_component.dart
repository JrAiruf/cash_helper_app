import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

class AnnotationInfoListViewComponent extends StatelessWidget {
  const AnnotationInfoListViewComponent({super.key, required this.annotations});

  final List<AnnotationEntity> annotations;
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: ListView.builder(
        itemCount: annotations.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    annotations[index].annotationClientAddress ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    annotations[index].annotationSaleValue ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    "Venda em:",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    annotations[index]
                            .annotationSaleDate
                            ?.replaceAll("/", "-") ??
                        "",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
