import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class OperatorStatusComponent extends StatelessWidget {
  const OperatorStatusComponent(
      {super.key,
      required this.topPosition,
      required this.sidePosition,
      required this.borderColor,
      required this.activeColor,
      required this.inactiveColor,
      required this.textColor,
      required this.operatorEntity});

  final double topPosition;
  final double sidePosition;
  final Color borderColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color textColor;
  final OperatorEntity operatorEntity;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      right: sidePosition,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 30,
            child: CircleAvatar(
              backgroundColor:
                  operatorEntity.operatorEnabled! ? activeColor : inactiveColor,
              maxRadius: 29,
              child: const Icon(
                color: Colors.white,
                Icons.person,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 25),
          Text(
            operatorEntity.operatorEnabled! ? "Ativo" : "Inativo",
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
