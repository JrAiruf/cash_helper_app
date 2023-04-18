import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class ChangeOperatorPasswordPage extends StatelessWidget {
  ChangeOperatorPasswordPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final redLight = Theme.of(context).colorScheme.error;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: primaryColor),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.816,
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
                  "Minha Conta",
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
                    SizedBox(height: height * 0.02, width: width),
                    Text(
                      "Alterar Senha:",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: height * 0.02, width: width),
                  ],
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
      ),
    );
  }
}
