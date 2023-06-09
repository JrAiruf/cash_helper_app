// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorAccountPage extends StatelessWidget {
  OperatorAccountPage(
      {super.key,
      this.position,
      required this.operatorEntity,
      this.controller});

  OperatorEntity operatorEntity;
  BottomNavigationBarPosition? position;
  PageController? controller;
  final _controller = Modular.get<OperatorController>();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final redLight = Theme.of(context).colorScheme.error;
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
                borderRadius: const BorderRadius.only(
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
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: height * 0.5,
              width: width * 0.84,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.01, width: width),
                  Text(
                    "Informações:",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: surfaceColor),
                  ),
                  SizedBox(height: height * 0.05, width: width),
                  Text(
                    "E-mail:",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  SizedBox(height: height * 0.03, width: width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        operatorEntity.operatorEmail ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: surfaceColor),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tertiaryColor),
                          ),
                        ),
                        onPressed: () {
                          Modular.to.pushNamed("./change-operator-email",
                              arguments: operatorEntity);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 25),
                          child: Text(
                            "Alterar",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.06, width: width),
                  Text(
                    "Senha:",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  SizedBox(height: height * 0.03, width: width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "........",
                        style: TextStyle(fontSize: 35, color: surfaceColor),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tertiaryColor),
                          ),
                        ),
                        onPressed: () {
                          Modular.to.pushNamed("./change-operator-password",
                              arguments: operatorEntity);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 25),
                          child: Text(
                            "Alterar",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.06, width: width),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.03,
            left: width * 0.05,
            child: const Icon(
              Icons.person_search_outlined,
              size: 85,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: redLight),
                  backgroundColor: Colors.white,
                  fixedSize: Size(width * 0.7, 30),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: redLight),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                onPressed: () {
                  _controller.removeAccountWarning(context, primaryColor, () {
                    Modular.to.pop();
                    Modular.to.pushNamed("./remove-operator-account",
                        arguments: operatorEntity);
                  });
                },
                child: Text(
                  "RemoverConta",
                  style: TextStyle(color: redLight),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
