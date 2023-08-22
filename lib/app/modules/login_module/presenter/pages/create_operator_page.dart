// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_operator_bloc/create_operator_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/registration_loading_page.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../enterprise_module/domain/entities/enterprise_entity.dart';
import '../components/cash_helper_text_field.dart';
import '../components/visibility_icon_component.dart';
import '../controllers/login_controller.dart';

class CreateOperatorPage extends StatefulWidget {
  const CreateOperatorPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<CreateOperatorPage> createState() => _CreateOperatorPageState();
}

class _CreateOperatorPageState extends State<CreateOperatorPage> {
  final _loginController = Modular.get<LoginController>();
  @override
  void initState() {
    super.initState();
    _loginController.enterpriseId = widget.enterpriseEntity.enterpriseId!;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer(
          listener: (context, state) {
            if (state is CreateOperatorSuccessState) {
              Modular.to.navigate("${UserRoutes.operatorHomePage}${_loginController.enterpriseId}", arguments: state.operatorEntity);
            }
          },
          bloc: _loginController.createOperatorBloc,
          builder: (_, state) {
            if (state is RedirectingOperatorState) {
              return const RegistrationLoadingPage();
            }
            if (state is CreateOperatorInitialState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: height * 0.05,
                        ),
                        child: Text('Crie sua Conta', style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.6,
                              width: width * 0.95,
                              child: Card(
                                color: appThemes.purpleColor(context),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Form(
                                  key: _loginController.createOperatorFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.cashierNameValidate,
                                          onSaved: (value) => _loginController.operatorEntity.operatorName = value,
                                          controller: _loginController.cashierNameField,
                                          label: 'Nome',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.emailValidate,
                                          onSaved: (value) => _loginController.operatorEntity.operatorEmail = value,
                                          controller: _loginController.newOperatorEmailField,
                                          label: 'Email',
                                        ),
                                        AnimatedBuilder(
                                            animation: _loginController.operatorPasswordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                textColor: appThemes.surface(context),
                                                primaryColor: appThemes.surface(context),
                                                suffixIcon: VisibilityIconComponent(
                                                    onTap: () {
                                                      setState(() {
                                                        _loginController.operatorPasswordVisible.value = !_loginController.operatorPasswordVisible.value;
                                                      });
                                                    },
                                                    forVisibility: Icons.visibility,
                                                    forHideContent: Icons.visibility_off,
                                                    condition: _loginController.operatorPasswordVisible.value),
                                                radius: 15,
                                                obscureText: _loginController.operatorPasswordVisible.value ? false : true,
                                                validator: _loginController.passwordValidate,
                                                onSaved: (value) => _loginController.operatorEntity.operatorPassword = value,
                                                controller: _loginController.newOperatorPasswordField,
                                                label: 'Senha',
                                              );
                                            }),
                                        AnimatedBuilder(
                                            animation: _loginController.operatorConfirmationPasswordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                textColor: appThemes.surface(context),
                                                primaryColor: appThemes.surface(context),
                                                suffixIcon: VisibilityIconComponent(
                                                    onTap: () {
                                                      setState(() {
                                                        _loginController.operatorConfirmationPasswordVisible.value = !_loginController.operatorConfirmationPasswordVisible.value;
                                                      });
                                                    },
                                                    forVisibility: Icons.visibility,
                                                    forHideContent: Icons.visibility_off,
                                                    condition: _loginController.operatorConfirmationPasswordVisible.value),
                                                radius: 15,
                                                obscureText: _loginController.operatorConfirmationPasswordVisible.value ? false : true,
                                                validator: _loginController.passwordValidate,
                                                onSaved: (value) => _loginController.operatorConfirmationPassword = value,
                                                controller: _loginController.newOperatorPasswordField,
                                                label: 'Confirmar senha',
                                              );
                                            }),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.cashierNumberValidate,
                                          onSaved: (value) => _loginController.operatorEntity.operatorNumber = int.tryParse(value!),
                                          label: 'Número do caixa',
                                          controller: _loginController.cashierNumberField,
                                          input: TextInputType.phone,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Abertura de caixa',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              Switch(
                                                activeColor: appThemes.greenColor(context),
                                                value: (_loginController.enabledOperator),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _loginController.enabledOperator = value;
                                                    _loginController.operatorEntity.operatorEnabled = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: CashHelperElevatedButton(
                          onPressed: () {
                            _loginController.createOperator(context);
                          },
                          width: width,
                          height: 65,
                          buttonName: 'Registrar',
                          fontSize: 20,
                          nameColor: Colors.white,
                          backgroundColor: appThemes.purpleColor(context),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is CreateOperatorErrorState) {
              return Container(
                decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                height: height,
                child: Center(
                  child: Text(
                    state.error,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }
}


/* 


 */