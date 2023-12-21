import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_business_position.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/visibility_icon_component.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/auth_error_view.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/user_not_found_view.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';
import '../../../user_module/presenter/blocs/manager_bloc/manager_events.dart';
import '../../../user_module/presenter/blocs/operator_bloc/operator_events.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _loginController = Modular.get<LoginController>();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _loginController.entepriseEntity = widget.enterpriseEntity;
    _loginController.authBloc.add(InitialAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return BlocConsumer<AuthBloc, AuthStates?>(
      bloc: _loginController.authBloc,
      listener: (context, state) {
        if (state is AuthOperatorSuccessState) {
          _loginController.operatorBloc.add(GetOperatorByIdEvent(widget.enterpriseEntity.enterpriseId!, state.cashOperator.operatorId!, state.cashOperator.businessPosition!));
          Modular.to.navigate("${UserRoutes.operatorHomePage}${widget.enterpriseEntity.enterpriseId}", arguments: state.cashOperator);
        }
        if (state is AuthManagerSuccessState) {
          _loginController.managerBloc.add(GetManagerByIdEvent(widget.enterpriseEntity.enterpriseId!, state.manager.managerId!, state.manager.businessPosition!));
          Modular.to.navigate("${UserRoutes.managerHomePage}${widget.enterpriseEntity.enterpriseId}", arguments: state.manager);
        }
      },
      builder: (_, state) {
        if (state is AuthErrorState) {
          return AuthErrorView(enterpriseEntity: widget.enterpriseEntity);
        }
        if (state is AuthBusinessPositionErrorState) {
          return UserNotFoundView(enterpriseEntity: widget.enterpriseEntity);
        }
        if (state is AuthLoadingState) {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        }
        if (state is AuthInitialState) {
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
                                inactiveThumbColor: appThemes.greenColor(context),
                                inactiveTrackColor: appThemes.greenColor(context),
                                activeColor: appThemes.blueColor(context),
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
                                onPressed: () {
                                  _loginController.showUserOptionsDialog(context, appThemes.purpleColor(context));
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
                            bottom: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(),
                                  onPressed: () {
                                    Modular.to.pushNamed("/user-redirection-page/${_loginController.entepriseEntity}");
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
