import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

class AnnoationsListViewComponent extends StatelessWidget {
  const AnnoationsListViewComponent(
      {required this.annotations,
      super.key,
      this.backgroundColor,
      this.borderColor,
      this.seccundaryColor,
      this.itemWidth});

  final List<AnnotationEntity?> annotations;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? seccundaryColor;

  final double? itemWidth;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: annotations.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        return Container(
          height: height * 0.15,
          width: itemWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor ?? Colors.white,
            border: Border.all(color: borderColor ?? Colors.white, width: 0.9),
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
                SizedBox(height: height * 0.015),
                Container(
                  height: 35,
                  width: itemWidth! * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: backgroundColor,
                    border: Border.all(
                        color: borderColor ?? Colors.white, width: 0.9),
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
                const SizedBox(height: 45),
                Text(
                  annotations[index]?.annotationPaymentMethod ?? '',
                  style: TextStyle(
                      color: seccundaryColor ?? Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Icon(
                  annotations[index]?.annotationConcluied ?? false
                      ? Icons.verified_outlined
                      : Icons.warning,
                  color: seccundaryColor,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
