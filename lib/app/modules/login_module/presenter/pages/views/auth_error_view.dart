import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enterprise_module/domain/entities/enterprise_business_position.dart';
import '../../components/buttons/cash_helper_login_button.dart';
import '../../components/cash_helper_text_field.dart';
import '../../components/visibility_icon_component.dart';
import '../../controllers/login_controller.dart';
import '../../stores/login_store.dart';

class AuthErrorView extends StatefulWidget {
  const AuthErrorView({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<AuthErrorView> createState() => _AuthErrorViewState();
}

final _loginFormKey = GlobalKey<FormState>();
final _loginStore = Modular.get<LoginStore>();
final _loginController = Modular.get<LoginController>();
bool _passwordVisible = false;
bool _managerUser = false;
late EnterpriseBusinessPosition businessPosition;

class _AuthErrorViewState extends State<AuthErrorView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.onSurface;
    final surface = Theme.of(context).colorScheme.surface;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final userBusinessPosition = _managerUser ? "Gerente" : "Operador";
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
                SizedBox(height: height * 0.16),
                Row(
                  children: [
                    Switch(
                        activeColor: tertiaryColor,
                        value: _managerUser,
                        onChanged: (value) {
                          _managerUser = !_managerUser;
                          setState(() {
                            businessPosition = _managerUser
                                ? EnterpriseBusinessPosition.manager
                                : EnterpriseBusinessPosition.cashOperator;
                          });
                        }),
                    const SizedBox(width: 25),
                    Text(
                      userBusinessPosition,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: surface),
                    ),
                    const SizedBox(width: 35),
                  ],
                ),
                Stack(
                  children: [
                    Card(
                      color: secondaryColor,
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
                                    onSaved: (value) => _loginController
                                        .emailField.text = value ?? "",
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
                                    onSaved: (value) => _loginController
                                        .passwordField.text = value ?? "",
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
                    visible: !_loginController.loadingData.value,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        color: indicatorColor,
                      ),
                    ),
                    child: CashHelperElevatedButton(
                      onPressed: () {
                        setState(() {
                          businessPosition = _managerUser
                              ? EnterpriseBusinessPosition.manager
                              : EnterpriseBusinessPosition.cashOperator;
                        });
                        _loginFormKey.currentState!.validate();
                        _loginFormKey.currentState!.save();

                        if (_loginFormKey.currentState!.validate()) {
                          _loginStore
                              .login(
                                  _loginController.emailField.text,
                                  _loginController.passwordField.text,
                                  widget.enterpriseEntity.enterpriseId,
                                  businessPosition.position)
                              ?.catchError((e) {
                            _loginController.onFail(context);
                          });
                        }
                      },
                      radius: 12,
                      width: width,
                      height: 65,
                      buttonName: 'Entrar',
                      fontSize: 20,
                      nameColor: surfaceColor,
                      backgroundColor: secondaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "E-mail ou senha inválidos. Login não realizado!",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surface),
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
