import 'package:cash_helper_app/app/modules/login_module/presenter/components/visibility_icon_component.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../user_module/domain/entities/operator_entity.dart';
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
bool _passwordVisible = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.onSurface;
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
                                    primaryColor: surfaceColor,
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
                                    primaryColor: surfaceColor,
                                    suffixIcon: VisibilityIconComponent(
                                        iconColor: surfaceColor,
                                        onTap: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        forVisibility: Icons.visibility,
                                        forHideContent: Icons.visibility_off,
                                        condition: _passwordVisible),
                                    radius: 15,
                                    obscureText:
                                        _passwordVisible == true ? false : true,
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
                          child: Text(
                            'Criar conta',
                            style: Theme.of(context).textTheme.displaySmall,
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
                      onPressed: () {
                        _loginFormKey.currentState!.validate();
                        _loginFormKey.currentState!.save();

                        if (_loginFormKey.currentState!.validate()) {
                          setState(() {
                            _loginController.loadingData = true;
                          });
                          _loginStore
                              .login(
                                  _userLogin.operatorEmail,
                                  _userLogin.operatorPassword,
                                  "",
                                  _userLogin.businessPosition ?? "operator")
                              ?.then((value) => value)
                              .catchError((e) {
                            _loginController.onFail(context);
                          });
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
                      nameColor: surfaceColor,
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
