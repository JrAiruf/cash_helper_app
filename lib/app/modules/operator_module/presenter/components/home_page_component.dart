import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import "package:flutter/material.dart";

class HomePageComponent extends StatelessWidget {
  const HomePageComponent(
      {super.key, this.height, this.width, required this.operator, this.color});

  final double? height;
  final double? width;
  final OperatorEntity operator;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dateTimeMonth = DateTime.now().month;
    final dateTimeDay = DateTime.now().day;
    final currentDateTime =
        '${dateTimeDay >= 10 ? dateTimeDay : '0$dateTimeDay'}/${dateTimeMonth >= 10 ? dateTimeMonth : '0$dateTimeMonth'}';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height! * 0.06),
                Text(
                  "${operator.operatorName}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: height! * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.calendar_month),
                    Text(
                      currentDateTime,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            maxRadius: 50,
          ),
        ),
        Positioned(
          top: 32,
          left: 12,
          child: CircleAvatar(
            backgroundColor: color,
            maxRadius: 48,
          ),
        ),
        const Positioned(
          top: 60,
          left: 42,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
