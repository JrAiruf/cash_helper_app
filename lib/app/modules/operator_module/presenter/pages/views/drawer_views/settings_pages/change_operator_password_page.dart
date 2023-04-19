// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../../login_module/presenter/components/cash_helper_text_field.dart';

class ChangeOperatorPasswordPage extends StatelessWidget {
  ChangeOperatorPasswordPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  final _controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: backgroundContainer),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            decoration: BoxDecoration(color: primaryColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.92,
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
                Padding(
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: height * 0.5,
                      width: width * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.02, width: width),
                          Text(
                            "Alterar Senha:",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(height: height * 0.04, width: width),
                          SingleChildScrollView(
                            child: Form(
                              child: SizedBox(
                                height: height * 0.35,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CashHelperTextFieldComponent(
                                      radius: 15,
                                      validator: (value) =>
                                          _controller.passwordValidate(value),
                                      onSaved: (value) => operatorEntity
                                          .operatorPassword = value,
                                      controller: _controller.passwordField,
                                      label: 'Nova Senha',
                                    ),
                                    CashHelperTextFieldComponent(
                                      radius: 15,
                                      validator: (value) =>
                                          _controller.passwordValidate(value),
                                      onSaved: (value) => operatorEntity
                                          .operatorPassword = value,
                                      controller: _controller.passwordField,
                                      label: 'Confirmar nova senha',
                                    ),
                                    CashHelperTextFieldComponent(
                                      radius: 15,
                                      validator: (value) => _controller
                                          .cashierCodeValidate(value),
                                      onSaved: (value) =>
                                          operatorEntity.operatorCode = value,
                                      controller: _controller.cashierCodeField,
                                      label: 'Código Ops',
                                    ),
                                    CashHelperTextFieldComponent(
                                      radius: 15,
                                      validator: (value) =>
                                          _controller.passwordValidate(value),
                                      onSaved: (value) => operatorEntity
                                          .operatorPassword = value,
                                      controller: _controller.passwordField,
                                      label: 'Senha',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                Positioned(
                  top: height * 0.7,
                  left: width * 0.025,
                  child: Center(
                    child: CashHelperElevatedButton(
                      width: width * 0.95,
                      height: 60,
                      radius: 12,
                      onPressed: () {},
                      buttonName: "Alterar",
                      backgroundColor: tertiaryColor,
                      nameColor: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
