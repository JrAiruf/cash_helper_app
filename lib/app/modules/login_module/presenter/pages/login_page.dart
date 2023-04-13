// ignore_for_file: unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../operator_module/domain/entities/operator_entity.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _loginFormKey = GlobalKey<FormState>();
final _loginStore = Modular.get<LoginStore>();
final _loginController = Modular.get<LoginController>();
final _userLogin = OperatorEntity();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: primaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Text('Cash Helper',
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: height * 0.2),
                Stack(
                  children: [
                    Card(
                      color: seccondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: SizedBox(
                        height: height * 0.4,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          child: Form(
                            key: _loginFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CashHelperTextFieldComponent(
                                    radius: 15,
                                    validator: (value) =>
                                        _loginController.emailValidate(value),
                                    onSaved: (value) =>
                                        _userLogin.operatorEmail = value,
                                    controller: _loginController.emailField,
                                    label: 'Email',
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CashHelperTextFieldComponent(
                                    radius: 15,
                                    obscureText: true,
                                    validator: (value) => _loginController
                                        .passwordValidate(value),
                                    onSaved: (value) =>
                                        _userLogin.operatorPassword = value,
                                    controller: _loginController.passwordField,
                                    label: 'Senha',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.35),
                      child: Center(
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            Modular.to.pushNamed("./create-new-operator");
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(),
                            onPressed: () {
                              Modular.to.pushNamed("/forgot-password-page");
                            },
                            child: Text('Esqueci minha senha',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Visibility(
                    visible: !_loginController.loadingData,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: indicatorColor,
                      ),
                    ),
                    child: CashHelperElevatedButton(
                      onPressed: () async {
                        _loginFormKey.currentState!.validate();
                        _loginFormKey.currentState!.save();

                        if (_loginFormKey.currentState!.validate()) {
                          setState(() {
                            _loginController.loadingData = true;
                          });
                          final loggedUser = await _loginStore
                              .login(
                                  _userLogin.operatorEmail,
                                  _userLogin.operatorPassword,
                                  _userLogin.operatorOcupation ?? "operator")
                              ?.then((value) => value)
                              .catchError((e) {
                            _loginController.onFail(context);
                          });
                          loggedUser != null
                              ? Modular.to.navigate("/operator-module/",
                                  arguments: loggedUser)
                              : null;
                        }
                        setState(() {
                          _loginController.loadingData = false;
                        });
                      },
                      radius: 12,
                      width: width,
                      height: 65,
                      buttonName: 'Entrar',
                      fontSize: 20,
                      nameColor: Colors.white,
                      backgroundColor: seccondaryColor,
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
