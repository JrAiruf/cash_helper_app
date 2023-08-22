import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RemoveOperatorAccountPage extends StatefulWidget {
  const RemoveOperatorAccountPage({super.key, required this.operatorEntity});

  final OperatorEntity operatorEntity;

  @override
  State<RemoveOperatorAccountPage> createState() =>
      _RemoveOperatorAccountPageState();
}

class _RemoveOperatorAccountPageState extends State<RemoveOperatorAccountPage> {
  final _deleteAccountFormKey = GlobalKey<FormState>();
  final _controller = Modular.get<OperatorController>();

  String? _operatorEmail;
  String? _operatorCode;
  String? _operatorPassword;
  final bool _operatorCodeVisible = false;
  final bool _passwordVisible = false;
  final bool _accountDeleted = false;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final redColor = Theme.of(context).colorScheme.error;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final detailColor = Theme.of(context).colorScheme.background;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return /* Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: backgroundContainer),
        child: SingleChildScrollView(
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
                      "Excluir Conta",
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
                                is DeleteOperatorAccountLoadingState) {
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
                                    "Confirme os dados para excluir a conta:",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(height: height * 0.04, width: width),
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _deleteAccountFormKey,
                                      child: SizedBox(
                                        height: height * 0.29,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CashHelperTextFieldComponent(
                                              radius: 15,
                                              validator: (value) => _controller
                                                  .emailValidate(value),
                                              onSaved: (value) =>
                                                  _operatorEmail = value,
                                              controller:
                                                  _controller.emailField,
                                              label: 'E-mail',
                                            ),
                                            CashHelperTextFieldComponent(
                                              suffixIcon:
                                                  VisibilityIconComponent(
                                                iconColor: detailColor,
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
                                                iconColor: detailColor,
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
                            if (operatorSettingsState is AccountDeletedState) {
                              Modular.to.navigate("/");
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
                    Icons.warning_rounded,
                    size: 85,
                  ),
                ),
                Visibility(
                  visible: !_accountDeleted,
                  child: Positioned(
                    top: height * 0.7,
                    left: width * 0.125,
                    child: Center(
                      child: CashHelperElevatedButton(
                        width: width * 0.75,
                        height: 60,
                        radius: 12,
                        onPressed: () async {
                          _deleteAccountFormKey.currentState?.validate();
                          _deleteAccountFormKey.currentState?.save();
                          if (_deleteAccountFormKey.currentState!.validate()) {
                            if (_controller.validOperatorCredentials(
                                widget.operatorEntity,
                                _operatorCode!,
                                _operatorPassword!,
                                operatorEmail: _operatorEmail)) {
                              _controller.askForAccountDeletion(
                                  context, primaryColor, () async {
                                setState(
                                  () {
                                    _accountDeleted = true;
                                  },
                                );
                                await _operatorStore
                                    .deleteOperatorAccount(
                                        _operatorCode!,
                                        _operatorEmail!,
                                        _operatorPassword!,
                                        widget
                                            .operatorEntity.businessPosition!)
                                    .catchError((e) {
                                  _controller.deletionFailure(context);
                                });
                              });
                            } else {
                              _controller.deletionFailure(context);
                            }
                          }
                        },
                        buttonName: "Excluir Definitivamente",
                        backgroundColor: redColor,
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
