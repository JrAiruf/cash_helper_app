// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/login_module/presenter/components/cash_helper_text_field.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../../../login_module/presenter/components/visibility_icon_component.dart';

class ChangeOperatorEmailPage extends StatefulWidget {
  ChangeOperatorEmailPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;

  @override
  State<ChangeOperatorEmailPage> createState() =>
      _ChangeOperatorEmailPageState();
}

class _ChangeOperatorEmailPageState extends State<ChangeOperatorEmailPage> {
  final _controller = Modular.get<OperatorController>();
  final _changeEmailFormKey = GlobalKey<FormState>();
  final _operatorStore = Modular.get<OperatorStore>();

  String? _confirmationEmail;
  String? _operatorPassword;
  String? _operatorCode;
  bool _emailChanged = false;

  bool _operatorCodeVisible = false;
  bool _passwordVisible = false;
  @override
  void initState() {
    _operatorStore.restartOperatorSettingsPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          builder: (_, operatorSettingsState, __) {
                            if (operatorSettingsState
                                is ChangeEmailLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: tertiaryColor,
                                ),
                              );
                            }
                            if (operatorSettingsState
                                is OperatorSettingsInitialState) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.02, width: width),
                                  Text(
                                    "Alterar E-mail:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(height: height * 0.04, width: width),
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _changeEmailFormKey,
                                      child: SizedBox(
                                        height: height * 0.38,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CashHelperTextFieldComponent(
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .emailValidate(value),
                                              onSaved: (value) => widget
                                                  .operatorEntity
                                                  .operatorEmail = value,
                                              controller:
                                                  _controller.emailField,
                                              label: 'Novo E-mail',
                                            ),
                                            CashHelperTextFieldComponent(
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .emailValidate(value),
                                              onSaved: (value) =>
                                                  _confirmationEmail = value,
                                              controller:
                                                  _controller.emailField,
                                              label: 'Confirmar E-mail',
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
                            if (operatorSettingsState
                                is OperatorModifiedEmailState) {
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
                  visible: !_emailChanged,
                  child: Positioned(
                    top: height * 0.7,
                    left: width * 0.025,
                    child: Center(
                      child: CashHelperElevatedButton(
                        width: width * 0.95,
                        height: 60,
                        radius: 12,
                        onPressed: () async {
                          _changeEmailFormKey.currentState?.validate();
                          _changeEmailFormKey.currentState?.save();
                          if (_changeEmailFormKey.currentState!.validate()) {
                            if (_confirmationEmail ==
                                    widget.operatorEntity.operatorEmail &&
                                _controller.validOperatorCredentials(
                                    widget.operatorEntity,
                                    _operatorCode!,
                                    _operatorPassword!)) {
                              setState(
                                () {
                                  _emailChanged = true;
                                },
                              );
                              await _operatorStore
                                  .changeOperatorEmail(
                                      widget.operatorEntity.operatorEmail!,
                                      _operatorCode!,
                                      _operatorPassword!,
                                      widget.operatorEntity.businessPosition!)
                                  .catchError((e) {
                                _controller.modificationEmailFailure(context);
                              });
                              widget.operatorEntity.operatorEmail =
                                  _confirmationEmail;
                            } else {
                              _controller.modificationEmailFailure(context);
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
    );
  }
}
