// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/login_module/presenter/components/visibility_icon_component.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../../../login_module/presenter/components/cash_helper_text_field.dart';

class ChangeOperatorPasswordPage extends StatefulWidget {
  ChangeOperatorPasswordPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;

  @override
  State<ChangeOperatorPasswordPage> createState() =>
      _ChangeOperatorPasswordPageState();
}

class _ChangeOperatorPasswordPageState
    extends State<ChangeOperatorPasswordPage> {
  final _controller = Modular.get<OperatorController>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  String? _newPassword = "";
  String? _confirmationPassword = "";
  String? _operatorCode = "";
  String? _operatorPassword = "";

  bool _passwordChanged = false;

  bool _newPasswordVisible = false;
  bool _confirmationPasswordVisible = false;
  bool _operatorCodeVisible = false;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return /* Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: backgroundContainer),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            decoration: BoxDecoration(color: primaryColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.915,
                    decoration: BoxDecoration(
                      color: backgroundContainer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Text(
                      "Minha Conta",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.15),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: height * 0.65,
                      width: width * 0.9,
                      child: ValueListenableBuilder(
                          valueListenable: _operatorStore,
                          builder: (_, state, __) {
                            if (state is ChangePasswordLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: tertiaryColor,
                                ),
                              );
                            }
                            if (state is OperatorSettingsInitialState) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.02, width: width),
                                  Text(
                                    "Alterar Senha:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(height: height * 0.04, width: width),
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _changePasswordFormKey,
                                      child: SizedBox(
                                        height: height * 0.38,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CashHelperTextFieldComponent(
                                              suffixIcon:
                                                  VisibilityIconComponent(
                                                onTap: () {
                                                  setState(() {
                                                    _newPasswordVisible =
                                                        !_newPasswordVisible;
                                                  });
                                                },
                                                condition: _newPasswordVisible,
                                                forVisibility: Icons.visibility,
                                                forHideContent:
                                                    Icons.visibility_off,
                                              ),
                                              obscureText:
                                                  _newPasswordVisible == true
                                                      ? false
                                                      : true,
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .passwordValidate(value),
                                              onSaved: (value) =>
                                                  _newPassword = value,
                                              controller:
                                                  _controller.passwordField,
                                              label: 'Nova Senha',
                                            ),
                                            CashHelperTextFieldComponent(
                                              suffixIcon:
                                                  VisibilityIconComponent(
                                                onTap: () {
                                                  setState(() {
                                                    _confirmationPasswordVisible =
                                                        !_confirmationPasswordVisible;
                                                  });
                                                },
                                                condition:
                                                    _confirmationPasswordVisible,
                                                forVisibility: Icons.visibility,
                                                forHideContent:
                                                    Icons.visibility_off,
                                              ),
                                              obscureText:
                                                  _confirmationPasswordVisible ==
                                                          true
                                                      ? false
                                                      : true,
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .passwordValidate(value),
                                              onSaved: (value) =>
                                                  _confirmationPassword = value,
                                              controller:
                                                  _controller.passwordField,
                                              label: 'Confirmar nova senha',
                                            ),
                                            CashHelperTextFieldComponent(
                                              suffixIcon:
                                                  VisibilityIconComponent(
                                                onTap: () {
                                                  setState(() {
                                                    _operatorCodeVisible =
                                                        !_operatorCodeVisible;
                                                  });
                                                },
                                                condition: _operatorCodeVisible,
                                                forVisibility: Icons.visibility,
                                                forHideContent:
                                                    Icons.visibility_off,
                                              ),
                                              obscureText:
                                                  _operatorCodeVisible == true
                                                      ? false
                                                      : true,
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .cashierCodeValidate(value),
                                              onSaved: (value) =>
                                                  _operatorCode = value,
                                              controller:
                                                  _controller.cashierCodeField,
                                              label: 'Código Ops',
                                            ),
                                            CashHelperTextFieldComponent(
                                              suffixIcon:
                                                  VisibilityIconComponent(
                                                onTap: () {
                                                  setState(() {
                                                    _passwordVisible =
                                                        !_passwordVisible;
                                                  });
                                                },
                                                condition: _passwordVisible,
                                                forVisibility: Icons.visibility,
                                                forHideContent:
                                                    Icons.visibility_off,
                                              ),
                                              obscureText:
                                                  _passwordVisible == true
                                                      ? false
                                                      : true,
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .passwordValidate(value),
                                              onSaved: (value) =>
                                                  _operatorPassword = value,
                                              controller:
                                                  _controller.passwordField,
                                              label: 'Senha',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is OperatorModifiedPasswordState) {
                              Modular.to.navigate("./",
                                  arguments: widget.operatorEntity);
                              return Container();
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.03,
                  left: width * 0.05,
                  child: const Icon(
                    Icons.settings,
                    size: 85,
                  ),
                ),
                Visibility(
                  visible: !_passwordChanged,
                  child: Positioned(
                    top: height * 0.7,
                    left: width * 0.025,
                    child: Center(
                      child: CashHelperElevatedButton(
                        width: width * 0.95,
                        height: 60,
                        radius: 12,
                        onPressed: () {
                          _changePasswordFormKey.currentState!.validate();
                          _changePasswordFormKey.currentState!.save();
                          if (_changePasswordFormKey.currentState!.validate()) {
                            if (_controller.validOperatorCredentials(
                                    widget.operatorEntity,
                                    _operatorCode!,
                                    _operatorPassword!) &&
                                _newPassword == _confirmationPassword) {
                              setState(
                                () {
                                  _passwordChanged = true;
                                },
                              );
                              _operatorStore
                                  .changeOperatorPassword(
                                      _newPassword!,
                                      _operatorCode!,
                                      _operatorPassword!,
                                      widget.operatorEntity.businessPosition!)
                                  .catchError(
                                (e) {
                                  _controller.modificationEmailFailure(context);
                                  _operatorStore.restartOperatorSettingsPage();
                                },
                              );
                              widget.operatorEntity.operatorPassword =
                                  _newPassword;
                            } else {
                              _controller.modificationPasswordFailure(context);
                            }
                          }
                        },
                        buttonName: "Alterar",
                        backgroundColor: tertiaryColor,
                        nameColor: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ) */ Container();
  }
}
