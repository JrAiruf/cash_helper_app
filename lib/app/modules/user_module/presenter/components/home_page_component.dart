import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import "package:flutter/material.dart";

import '../../domain/entities/manager_entity.dart';

class HomePageComponent extends StatelessWidget {
  const HomePageComponent(
      {super.key,
      this.height,
      this.width,
      this.operator,
      this.manager,
      this.color});

  final double? height;
  final double? width;
  final OperatorEntity? operator;
  final ManagerEntity? manager;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final operatorName = operator?.operatorName?.split(" ")[0];
    final managerName = manager?.managerName?.split(" ")[0];
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height! * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Olá, ${operatorName ?? managerName ?? ""}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: height! * 0.02),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
