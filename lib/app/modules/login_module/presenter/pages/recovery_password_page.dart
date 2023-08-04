// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user_module/domain/entities/operator_entity.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';
import '../controllers/login_controller.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _recoveryPasswordFormKey = GlobalKey<FormState>();
  final _loginController = Modular.get<LoginController>();
  final _operatorEntity = OperatorEntity();
  String? confirmationPassword;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: primaryColor),
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Text(
                  "Recuperar Senha",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: surfaceColor),
                ),
                SizedBox(height: height * 0.1),
                Text(
                  "Digite sua nova senha:",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: Form(
                    key: _recoveryPasswordFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CashHelperTextFieldComponent(
                          obscureText: true,
                          radius: 15,
                          validator: (value) => _loginController.passwordValidate(value),
                          onSaved: (value) => _operatorEntity.operatorPassword = value?.trim(),
                          controller: _loginController.passwordField,
                          label: 'Nova Senha',
                        ),
                        SizedBox(height: height * 0.03),
                        CashHelperTextFieldComponent(
                          obscureText: true,
                          radius: 15,
                          validator: (value) => _loginController.confirmationPasswordValidate(value),
                          onSaved: (value) => confirmationPassword = value?.trim(),
                          controller: _loginController.confirmationPasswordField,
                          label: 'Confirmar Nova Senha',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.15),
                CashHelperElevatedButton(
                  onPressed: () async {},
                  radius: 12,
                  width: width,
                  height: 65,
                  buttonName: 'Próximo',
                  fontSize: 20,
                  nameColor: Colors.white,
                  backgroundColor: tertiaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
