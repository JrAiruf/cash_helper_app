import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class OperatorCardComponent extends StatelessWidget {
  const OperatorCardComponent({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    required this.operatorEntity,
  });
  final OperatorEntity operatorEntity;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
                  Text(operatorEntity.operatorOcupation ?? "", style: fontSize),
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
            ],
          ),
        ),
      ),
    );
  }
}
