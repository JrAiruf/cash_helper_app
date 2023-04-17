import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

import '../../../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorAccountPage extends StatelessWidget {
  OperatorAccountPage(
      {super.key,
      this.position,
      required this.operatorEntity,
      this.controller});

  OperatorEntity operatorEntity;
  BottomNavigationBarPosition? position;
  PageController? controller;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.75,
              decoration: BoxDecoration(
                color: backgroundContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Text(
                "Privacidade",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Positioned(
            top: height * 0.03,
            left: width * 0.05,
            child: const Icon(
              Icons.settings,
              size: 85,
            ),
          ),
        ],
      ),
    );
  }
}
