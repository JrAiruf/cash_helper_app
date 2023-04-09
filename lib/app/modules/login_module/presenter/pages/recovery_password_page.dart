import "package:flutter/material.dart";
import 'package:flutter_modular/flutter_modular.dart';

import '../../../operator_module/domain/entities/operator_entity.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';
import '../controllers/login_controller.dart';
import '../stores/login_store.dart';

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _recoveryPasswordFormKey = GlobalKey<FormState>();
  final _loginController = Modular.get<LoginController>();
  final _loginStore = Modular.get<LoginStore>();
  final _operatorEntity = OperatorEntity();
  String? confirmationPassword;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
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
            child: Visibility(
              visible: !_loginController.loadingLoginData,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: LinearProgressIndicator(
                      color: seccondaryColor,
                    ),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.1),
                  Text(
                    "Recuperar Senha",
                    style: Theme.of(context).textTheme.displayMedium,
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
                            radius: 15,
                            validator: (value) =>
                                _loginController.passwordValidate(value),
                            onSaved: (value) => _operatorEntity
                                .operatorPassword = value?.trim(),
                            controller: _loginController.passwordField,
                            label: 'Nova Senha',
                          ),
                          SizedBox(height: height * 0.03),
                          CashHelperTextFieldComponent(
                            radius: 15,
                            validator: (value) => _loginController
                                .confirmationPasswordValidate(value),
                            onSaved: (value) =>
                                confirmationPassword = value?.trim(),
                            controller:
                                _loginController.confirmationPasswordField,
                            label: 'Confirmar Nova Senha',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  CashHelperElevatedButton(
                    onPressed: () async {
                      _recoveryPasswordFormKey.currentState!.validate();
                      _recoveryPasswordFormKey.currentState!.save();
                      if (_recoveryPasswordFormKey.currentState!.validate()) {
                        setState(() {
                          _loginController.loadingLoginData = true;
                        });
                        if (_operatorEntity.operatorPassword ==
                            confirmationPassword) {
                          await _loginStore.resetOperatorPassword(
                              widget.operatorEntity.operatorEmail!,
                              widget.operatorEntity.operatorNumber!,
                              _operatorEntity.operatorPassword!);
                          final recoveredOperator = await _loginStore
                              .login(widget.operatorEntity.operatorEmail,
                                  _operatorEntity.operatorPassword, "operator")
                              ?.then((currentOperator) => currentOperator)
                              .catchError((e) {
                            _loginController.onFail(context);
                          });
                          if (recoveredOperator != null) {
                            Modular.to.navigate("/operator-module/",
                                arguments: recoveredOperator);
                          } else {
                            return;
                          }
                          setState(() {
                            _loginController.loadingLoginData = false;
                          });
                        } else {
                          _loginController.recoveryTrialFail(context);
                        }
                        setState(() {
                          _loginController.loadingLoginData = false;
                        });
                      }
                    },
                    radius: 12,
                    width: width,
                    height: 65,
                    buttonName: 'Próximo',
                    fontSize: 20,
                    nameColor: Colors.white,
                    backgroundColor: seccondaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
