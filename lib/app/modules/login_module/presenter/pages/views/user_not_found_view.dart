import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_close_page.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../enterprise_module/domain/entities/enterprise_business_position.dart';
import '../../../../enterprise_module/domain/entities/enterprise_entity.dart';
import '../../components/buttons/cash_helper_login_button.dart';
import '../../components/cash_helper_text_field.dart';
import '../../components/visibility_icon_component.dart';
import '../../controllers/login_controller.dart';
import '../../stores/login_states.dart';
import 'auth_error_view.dart';

class UserNotFoundView extends StatefulWidget {
  const UserNotFoundView({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<UserNotFoundView> createState() => _UserNotFoundViewState();
}

final _loginController = Modular.get<LoginController>();
bool _passwordVisible = false;
bool _managerUser = false;
late EnterpriseBusinessPosition businessPosition;

class _UserNotFoundViewState extends State<UserNotFoundView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    final userBusinessPosition = _managerUser ? "Gerente" : "Operador";
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
        }
        if (state is LoginNoUserErrorState) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: appThemes.primaryColor(context)),
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
                      Text(
                        "Selecione sua área de ocupação",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surface(context)),
                      ),
                      const SizedBox(height: 25),
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
                      /* 
                      Row(
                        children: [
                          Switch(
                              activeColor: appThemes.greenColor(context),
                              value: _managerUser,
                              onChanged: (value) {
                                _managerUser = !_managerUser;
                                setState(() {
                                  businessPosition = _managerUser ? EnterpriseBusinessPosition.manager : EnterpriseBusinessPosition.cashOperator;
                                });
                              }),
                          const SizedBox(width: 25),
                          Text(
                            userBusinessPosition,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: appThemes.surface(context)),
                          ),
                          const SizedBox(width: 35),
                        ],
                      ), */
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
                                          primaryColor: appThemes.surfaceColor(context),
                                          radius: 15,
                                          validator: _loginController.emailValidate,
                                          onSaved: (value) => _loginController.emailField.text = value ?? "",
                                          controller: _loginController.emailField,
                                          label: 'Email',
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CashHelperTextFieldComponent(
                                          primaryColor: appThemes.surfaceColor(context),
                                          suffixIcon: VisibilityIconComponent(
                                              iconColor: appThemes.surfaceColor(context),
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                              forVisibility: Icons.visibility,
                                              forHideContent: Icons.visibility_off,
                                              condition: _passwordVisible),
                                          radius: 15,
                                          obscureText: _passwordVisible == true ? false : true,
                                          validator: _loginController.passwordValidate,
                                          onSaved: (value) => _loginController.passwordField.text = value ?? "",
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
                                  child: Text('Esqueci minha senha', style: Theme.of(context).textTheme.displaySmall),
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
                              color: appThemes.indicatorColor(context),
                            ),
                          ),
                          child: CashHelperElevatedButton(
                            onPressed: _loginController.login,
                            radius: 12,
                            width: width,
                            height: 65,
                            buttonName: 'Entrar',
                            fontSize: 20,
                            nameColor: appThemes.surfaceColor(context),
                            backgroundColor: appThemes.purpleColor(context),
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
        if (state is LoginSuccessState) {
          final enterpriseId = widget.enterpriseEntity.enterpriseId;
          final operatorEntity = state.operatorEntity;
          Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId", arguments: operatorEntity);
          return Container(
            decoration: BoxDecoration(
              color: appThemes.primaryColor(context),
            ),
          );
        }
        if (state is ManagerLoginSuccessState) {
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
        }
        if (state is LoginAuthErrorState) {
          return AuthErrorView(enterpriseEntity: widget.enterpriseEntity);
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
