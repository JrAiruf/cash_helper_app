import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_business_position.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/visibility_icon_component.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/auth_error_view.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/user_not_found_view.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _loginStore = Modular.get<LoginStore>();
final _loginController = Modular.get<LoginController>();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _loginStore.restartLoginStoreState();
    _loginController.enterpriseId = widget.enterpriseEntity.enterpriseId!;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();

    return ValueListenableBuilder(
      valueListenable: _loginController.loginStore,
      builder: (_, state, __) {
        if (state is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        } else if (state is LoginInitialState) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: appThemes.primaryColor(context),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.1),
                      Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: height * 0.2),
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _loginController.managerUser,
                            builder: (_, __) {
                              return Switch(
                                activeColor: appThemes.greenColor(context),
                                value: _loginController.userStatus,
                                onChanged: (value) {
                                  _loginController.userStatus = value;
                                  _loginController.userBusinessPosition = value ? EnterpriseBusinessPosition.manager.position : EnterpriseBusinessPosition.cashOperator.position;
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 25),
                          AnimatedBuilder(
                            animation: _loginController.businessPosition,
                            builder: (_, __) {
                              return Text(
                                _loginController.userBusinessPosition,
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: appThemes.surfaceColor(context)),
                              );
                            },
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Card(
                            color: appThemes.purpleColor(context),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: height * 0.4,
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                                child: Form(
                                  key: _loginController.loginFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CashHelperTextFieldComponent(
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: (value) => _loginController.emailValidate(value),
                                          onSaved: (value) => _loginController.emailField.text = value ?? "",
                                          controller: _loginController.emailField,
                                          label: 'Email',
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        AnimatedBuilder(
                                            animation: _loginController.passwordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                primaryColor: appThemes.surface(context),
                                                suffixIcon: VisibilityIconComponent(
                                                    iconColor: appThemes.surface(context),
                                                    onTap: () {
                                                      _loginController.passwordVisible.value = !_loginController.passwordVisible.value;
                                                    },
                                                    forVisibility: Icons.visibility,
                                                    forHideContent: Icons.visibility_off,
                                                    condition: _loginController.passwordVisible.value),
                                                radius: 15,
                                                obscureText: _loginController.passwordVisible.value == true ? false : true,
                                                validator: _loginController.passwordValidate,
                                                onSaved: (value) => _loginController.passwordField.text = value ?? "",
                                                controller: _loginController.passwordField,
                                                label: 'Senha',
                                              );
                                            }),
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
                                onPressed: () => Modular.to.pushNamed("./create-new-operator", arguments: widget.enterpriseEntity),
                                child: Text(
                                  'Criar conta',
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(),
                                  onPressed: () {
                                    Modular.to.pushNamed("/forgot-password-page");
                                  },
                                  child: Text('Esqueci minha senha', style: Theme.of(context).textTheme.displaySmall),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: CashHelperElevatedButton(
                          onPressed: _loginController.login,
                          radius: 12,
                          width: width,
                          height: 65,
                          buttonName: 'Entrar',
                          fontSize: 20,
                          nameColor: appThemes.surface(context),
                          backgroundColor: appThemes.purpleColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is LoginSuccessState) {
          final enterpriseId = widget.enterpriseEntity.enterpriseId;
          final operatorEntity = state.operatorEntity;
          Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId", arguments: operatorEntity);
          return Container(
            decoration: BoxDecoration(
              color: appThemes.primaryColor(context),
            ),
          );
        } else if (state is ManagerLoginSuccessState) {
          final enterpriseId = widget.enterpriseEntity.enterpriseId;
          final managerEntity = state.managerEntity;
          Modular.to.navigate("${UserRoutes.managerHomePage}$enterpriseId", arguments: managerEntity);
          return Container(
            decoration: BoxDecoration(
              color: appThemes.primaryColor(context),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        } else if (state is LoginAuthErrorState) {
          return AuthErrorView(enterpriseEntity: widget.enterpriseEntity);
        } else if (state is LoginNoUserErrorState) {
          return UserNotFoundView(enterpriseEntity: widget.enterpriseEntity);
        }
        return Container(
          decoration: BoxDecoration(
            color: appThemes.primaryColor(context),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: appThemes.indicatorColor(context),
            ),
          ),
        );
      },
    );
  }
}
