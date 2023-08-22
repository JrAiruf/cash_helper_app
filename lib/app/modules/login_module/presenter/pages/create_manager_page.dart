// ignore_for_file: unused_element

import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/views/registration_loading_page.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';
import '../components/visibility_icon_component.dart';

class CreateManagerPage extends StatefulWidget {
  const CreateManagerPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<CreateManagerPage> createState() => _CreateManagerPageState();
}

final _loginController = Modular.get<LoginController>();

class _CreateManagerPageState extends State<CreateManagerPage> {
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

    return BlocConsumer(
        bloc: _loginController.createManagerBloc,
        listener: (context, state) {
          if (state is CreateManagerSuccessState) {
            final enterpriseId = widget.enterpriseEntity.enterpriseId;
            Modular.to.navigate("${UserRoutes.managerHomePage}$enterpriseId", arguments: state.manager);
          }
        },
        builder: (_, state) {
          if (state is RedirectingManagerState) {
            return const RegistrationLoadingPage();
          }
          if (state is CreateManagerInitialState) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text('Cash Helper', style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Dados Empresariais',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: appThemes.surface(context),
                                    ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: height * 0.7,
                              width: width * 0.95,
                              child: Card(
                                color: appThemes.purpleColor(context),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Form(
                                  key: _loginController.createManagerFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.cashierNameValidate,
                                          onSaved: (value) => _loginController.managerEntity.managerName = value,
                                          controller: _loginController.cashierNameField,
                                          label: 'Nome Completo',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.cpfValidate,
                                          onSaved: (value) => _loginController.managerEntity.managerCpf = value,
                                          controller: _loginController.managerCpfField,
                                          label: 'CPF',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.rgValidate,
                                          onSaved: (value) => _loginController.managerEntity.managerRg = value,
                                          controller: _loginController.managerRgField,
                                          label: 'RG',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.phoneValidate,
                                          onSaved: (value) => _loginController.managerEntity.managerPhone = value,
                                          controller: _loginController.managerPhoneField,
                                          label: 'Telefone',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: appThemes.surface(context),
                                          primaryColor: appThemes.surface(context),
                                          radius: 15,
                                          validator: _loginController.emailValidate,
                                          onSaved: (value) => _loginController.managerEntity.managerEmail = value,
                                          controller: _loginController.emailField,
                                          label: 'E-mail',
                                        ),
                                        AnimatedBuilder(
                                            animation: _loginController.managerPasswordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                textColor: appThemes.surface(context),
                                                primaryColor: appThemes.surface(context),
                                                radius: 15,
                                                suffixIcon: VisibilityIconComponent(
                                                    iconColor: appThemes.surface(context),
                                                    onTap: () => _loginController.managerPasswordVisible.value = !_loginController.managerPasswordVisible.value,
                                                    forVisibility: Icons.visibility,
                                                    forHideContent: Icons.visibility_off,
                                                    condition: _loginController.managerPasswordVisible.value),
                                                validator: _loginController.passwordValidate,
                                                onSaved: (value) => _loginController.managerEntity.managerPassword = value,
                                                controller: _loginController.newManagerPasswordField,
                                                label: 'Senha',
                                                obscureText: _loginController.managerPasswordVisible.value ? false : true,
                                              );
                                            }),
                                        AnimatedBuilder(
                                          animation: _loginController.managerConfirmationPasswordVisible,
                                          builder: (_, __) {
                                            return CashHelperTextFieldComponent(
                                              textColor: appThemes.surface(context),
                                              primaryColor: appThemes.surface(context),
                                              radius: 15,
                                              suffixIcon: VisibilityIconComponent(
                                                  iconColor: appThemes.surface(context),
                                                  onTap: () => _loginController.managerConfirmationPasswordVisible.value = !_loginController.managerConfirmationPasswordVisible.value,
                                                  forVisibility: Icons.visibility,
                                                  forHideContent: Icons.visibility_off,
                                                  condition: _loginController.managerConfirmationPasswordVisible.value),
                                              validator: _loginController.confirmationPasswordValidate,
                                              onSaved: (value) => _loginController.confirmartionPassword = value,
                                              controller: _loginController.confirmationPasswordField,
                                              label: 'Confirmar Senha',
                                              obscureText: _loginController.managerConfirmationPasswordVisible.value ? false : true,
                                            );
                                          },
                                        ),
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
                            _loginController.createManager(context);
                          },
                          width: width,
                          height: 65,
                          buttonName: 'Registrar',
                          fontSize: 15,
                          nameColor: Colors.white,
                          backgroundColor: appThemes.purpleColor(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
