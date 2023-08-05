import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

class AnnotationsListViewComponent extends StatelessWidget {
  const AnnotationsListViewComponent({required this.annotations, super.key, this.backgroundColor, this.borderColor, this.seccundaryColor, this.itemHeight, this.itemWidth});

  final List<AnnotationEntity?> annotations;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? seccundaryColor;
  final double? itemHeight;
  final double? itemWidth;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: annotations.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: Container(
            height: itemHeight,
            width: itemWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: backgroundColor ?? Colors.white,
              border: Border.all(color: borderColor ?? Colors.white, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    annotations[index]?.annotationClientAddress ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      color: seccundaryColor ?? Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: itemHeight ?? 180 * 0.1),
                  Container(
                    height: 35,
                    width: itemWidth! * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: backgroundColor,
                      border: Border.all(color: borderColor ?? Colors.white, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        annotations[index]?.annotationSaleValue ?? '',
                        style: TextStyle(
                          color: seccundaryColor ?? Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: itemHeight ?? 180 * 0.1),
                  Text(
                    annotations[index]?.annotationPaymentMethod ?? '',
                    style: TextStyle(color: seccundaryColor ?? Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: itemHeight ?? 180 * 0.07,
                  ),
                  Icon(
                    annotations[index]?.annotationConcluied ?? false ? Icons.verified_outlined : Icons.warning,
                    color: seccundaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
