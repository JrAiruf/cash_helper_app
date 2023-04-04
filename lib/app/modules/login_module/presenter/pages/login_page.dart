import 'package:cash_helper_app/app/modules/login_module/binds/login_module_routes.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/binds/operator_module_routes.dart';
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
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
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
                SizedBox(height: height * 0.25),
                Stack(
                  children: [
                    Card(
                      color: seccondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: SizedBox(
                        height: height * 0.35,
                        width: width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          child: Form(
                            key: _loginFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CashHelperTextFieldComponent(
                                    isButton: false,
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
                                    isButton: false,
                                    obscureText: true,
                                    validator: (value) => _loginController
                                        .passwordValidate(value),
                                    onSaved: (value) =>
                                        _userLogin.operatorPassword = value,
                                    controller: _loginController.passwordField,
                                    label: 'Senha',
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(),
                                          onPressed: () => Modular.to.pushNamed(
                                              './forgot-password-page'),
                                          child: const Text(
                                            'Esqueci minha senha',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.29),
                      child: Center(
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            Modular.to.pushNamed(LoginModuleRoutes.register);
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Visibility(
                    visible: !_loginController.loadingLoginData,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                    child: CashHelperLoginButton(
                      onPressed: () async {
                        _loginFormKey.currentState!.validate();
                        _loginFormKey.currentState!.save();

                        if (_loginFormKey.currentState!.validate()) {
                          setState(() {
                            _loginController.loadingLoginData = true;
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
                              ? Modular.to.navigate(OperatorModuleRoutes.home,
                                  arguments: loggedUser)
                              : null;
                        }
                        setState(() {
                          _loginController.loadingLoginData = false;
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
