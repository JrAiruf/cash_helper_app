import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/cash_helper_text_field.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _checkOperatorDataFormKey = GlobalKey<FormState>();
  final _operatorEntity = OperatorEntity();
  final _loginController = Modular.get<LoginController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
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
            child: Visibility(
              visible: !_loginController.loadingAuthData,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 35),
                    child: Center(
                      child: LinearProgressIndicator(
                        color: tertiaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.1),
                  Text(
                    "Recuperar Senha",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: surfaceColor),
                  ),
                  SizedBox(height: height * 0.1),
                  Text("Informe os dados necessários:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: surfaceColor,
                          ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Form(
                      key: _checkOperatorDataFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CashHelperTextFieldComponent(
                            radius: 15,
                            validator: (value) =>
                                _loginController.emailValidate(value),
                            onSaved: (value) =>
                                _operatorEntity.operatorEmail = value,
                            controller: _loginController.emailField,
                            label: 'Email',
                          ),
                          SizedBox(height: height * 0.03),
                          CashHelperTextFieldComponent(
                            obscureText: true,
                            radius: 15,
                            validator: (value) =>
                                _loginController.cashierCodeValidate(value),
                            onSaved: (value) =>
                                _operatorEntity.operatorCode = value,
                            controller: _loginController.cashierCodeField,
                            label: 'Código Ops.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  CashHelperElevatedButton(
                    onPressed: () async {
                      /* _checkOperatorDataFormKey.currentState!.validate();
                      _checkOperatorDataFormKey.currentState!.save();
                      if (_checkOperatorDataFormKey.currentState!.validate()) {
                        setState(() {
                          _loginController.loadingAuthData = true;
                        });
                        final checkedInformation = await _loginStore
                            .checkOperatorDataForResetPassword(
                              _operatorEntity.operatorEmail!,
                              _operatorEntity.operatorCode!,
                              "operator",
                            )!
                            .then((value) => value)
                            .catchError((e) {
                          _loginController.checkInformationTrialFail(context);
                          return false;
                        });

                        if (checkedInformation) {
                          Modular.to.pushNamed("/recovery-password-page",
                              arguments: _operatorEntity);
                        }
                        setState(() {
                          _loginController.loadingAuthData = false;
                        });
                      } */
                    },
                    radius: 12,
                    width: width,
                    height: 65,
                    buttonName: 'Próximo',
                    fontSize: 20,
                    nameColor: Colors.white,
                    backgroundColor: secondaryColor,
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


/* 
if (recoveryPageState is LoginInitialState) {}
 */