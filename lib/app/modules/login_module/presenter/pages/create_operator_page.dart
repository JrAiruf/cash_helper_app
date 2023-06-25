// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:flutter/material.dart';
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
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
          animation: _loginController.loadingData,
          builder: (_, __) {
            return Visibility(
              visible: _loginController.loadingData.value,
              replacement: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(color: primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: height * 0.05,
                        ),
                        child: Text('Crie sua Conta',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.6,
                              width: width * 0.95,
                              child: Card(
                                color: seccondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Form(
                                  key: _loginController.createOperatorFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CashHelperTextFieldComponent(
                                          textColor: onSurface,
                                          primaryColor: onSurface,
                                          radius: 15,
                                          validator: _loginController
                                              .cashierNameValidate,
                                          onSaved: (value) => _loginController
                                              .operatorEntity
                                              .operatorName = value,
                                          controller:
                                              _loginController.cashierNameField,
                                          label: 'Nome',
                                        ),
                                        CashHelperTextFieldComponent(
                                          textColor: onSurface,
                                          primaryColor: onSurface,
                                          radius: 15,
                                          validator:
                                              _loginController.emailValidate,
                                          onSaved: (value) => _loginController
                                              .operatorEntity
                                              .operatorEmail = value,
                                          controller: _loginController
                                              .newOperatorEmailField,
                                          label: 'Email',
                                        ),
                                        AnimatedBuilder(
                                            animation: _loginController
                                                .operatorPasswordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                textColor: onSurface,
                                                primaryColor: onSurface,
                                                suffixIcon:
                                                    VisibilityIconComponent(
                                                        onTap: () {
                                                          setState(() {
                                                            _loginController
                                                                    .operatorPasswordVisible
                                                                    .value =
                                                                !_loginController
                                                                    .operatorPasswordVisible
                                                                    .value;
                                                          });
                                                        },
                                                        forVisibility:
                                                            Icons.visibility,
                                                        forHideContent: Icons
                                                            .visibility_off,
                                                        condition: _loginController
                                                            .operatorPasswordVisible
                                                            .value),
                                                radius: 15,
                                                obscureText: _loginController
                                                        .operatorPasswordVisible
                                                        .value
                                                    ? false
                                                    : true,
                                                validator: (value) =>
                                                    _loginController
                                                        .passwordValidate(
                                                            value),
                                                onSaved: (value) =>
                                                    _loginController
                                                            .operatorEntity
                                                            .operatorPassword =
                                                        value,
                                                controller: _loginController
                                                    .newOperatorPasswordField,
                                                label: 'Senha',
                                              );
                                            }),
                                        AnimatedBuilder(
                                            animation: _loginController
                                                .operatorConfirmationPasswordVisible,
                                            builder: (_, __) {
                                              return CashHelperTextFieldComponent(
                                                textColor: onSurface,
                                                primaryColor: onSurface,
                                                suffixIcon:
                                                    VisibilityIconComponent(
                                                        onTap: () {
                                                          setState(() {
                                                            _loginController
                                                                    .operatorConfirmationPasswordVisible
                                                                    .value =
                                                                !_loginController
                                                                    .operatorConfirmationPasswordVisible
                                                                    .value;
                                                          });
                                                        },
                                                        forVisibility:
                                                            Icons.visibility,
                                                        forHideContent: Icons
                                                            .visibility_off,
                                                        condition: _loginController
                                                            .operatorConfirmationPasswordVisible
                                                            .value),
                                                radius: 15,
                                                obscureText: _loginController
                                                        .operatorConfirmationPasswordVisible
                                                        .value
                                                    ? false
                                                    : true,
                                                validator: (value) =>
                                                    _loginController
                                                        .passwordValidate(
                                                            value),
                                                onSaved: (value) => _loginController
                                                        .operatorConfirmationPassword =
                                                    value,
                                                controller: _loginController
                                                    .newOperatorPasswordField,
                                                label: 'Confirmar senha',
                                              );
                                            }),
                                        CashHelperTextFieldComponent(
                                          textColor: onSurface,
                                          primaryColor: onSurface,
                                          radius: 15,
                                          validator: (value) => _loginController
                                              .cashierNumberValidate(value),
                                          onSaved: (value) => _loginController
                                                  .operatorEntity
                                                  .operatorNumber =
                                              int.tryParse(value!),
                                          label: 'Número do caixa',
                                          controller: _loginController
                                              .cashierNumberField,
                                          input: TextInputType.phone,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Abertura de caixa',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Switch(
                                                activeColor: tertiaryColor,
                                                value: (_loginController
                                                    .enabledOperator),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _loginController
                                                            .enabledOperator =
                                                        value;
                                                    _loginController
                                                            .operatorEntity
                                                            .operatorEnabled =
                                                        value;
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: CashHelperElevatedButton(
                          onPressed: () =>
                              _loginController.registerOperator(context),
                          width: width,
                          height: 65,
                          buttonName: 'Registrar',
                          fontSize: 20,
                          nameColor: Colors.white,
                          backgroundColor: seccondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(color: primaryColor),
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
