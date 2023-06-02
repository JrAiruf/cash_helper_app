import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

import '../../../../annotations_module/domain/entities/annotation_entity.dart';

class OperatorCardComponent extends StatelessWidget {
  const OperatorCardComponent({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    required this.operatorEntity,
    required this.annotationsList,
  });
  final OperatorEntity operatorEntity;
  final List<AnnotationEntity> annotationsList;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final dateValue = DateValues();
    final fontSize = Theme.of(context).textTheme.bodySmall;
    final dailyAnnotations = annotationsList.where((annotation) {
      return annotation.annotationSaleDate!.split("/").first ==
          dateValue.currentDay;
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: height ?? 10,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.white),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ocupação:", style: fontSize),
                  Text("Operador", style: fontSize),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Número do Caixa:", style: fontSize),
                  Text("${operatorEntity.operatorNumber}", style: fontSize),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("E-mail:", style: fontSize),
                  Text(operatorEntity.operatorEmail ?? "", style: fontSize),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Anotações Hoje:", style: fontSize),
                  Text("${dailyAnnotations.length}", style: fontSize),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
