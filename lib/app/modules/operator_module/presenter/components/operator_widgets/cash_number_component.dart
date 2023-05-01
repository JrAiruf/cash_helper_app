// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class CashNumberComponent extends StatelessWidget {
  CashNumberComponent(
      {required this.operatorEntity,
      required this.backgroundColor,
      required this.radius,
      super.key});

  OperatorEntity operatorEntity;
  Color backgroundColor;
  double radius;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.person,
          size: 55,
        ),
        const SizedBox(width: 15),
        CircleAvatar(
          maxRadius: radius,
          backgroundColor: backgroundColor,
          child: Text(
            "${operatorEntity.operatorNumber}",
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: primaryColor),
          ),
        )
      ],
    );
  }
}
