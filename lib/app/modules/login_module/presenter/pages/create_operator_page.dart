// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../user_module/domain/entities/operator_entity.dart';
import '../components/cash_helper_text_field.dart';
import '../components/visibility_icon_component.dart';
import '../controllers/login_controller.dart';
import '../stores/login_store.dart';

class CreateOperatorPage extends StatefulWidget {
  const CreateOperatorPage({super.key});

  @override
  State<CreateOperatorPage> createState() => _CreateOperatorPageState();
}

class _CreateOperatorPageState extends State<CreateOperatorPage> {
  final _createOperatorFormKey = GlobalKey<FormState>();
  final _loginStore = Modular.get<LoginStore>();
  final _createOperatorController = Modular.get<LoginController>();
  bool? startWithEnabledOperator;
  final _cashierOperator = OperatorEntity();
  String? _confirmationPassword;
  bool _passwordVisible = false;
  bool _confirmationPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final minutesDateTime = DateTime.now().minute;
    final hoursDateTime = DateTime.now().hour;
    final cashierOppeningTime =
        '${hoursDateTime >= 10 ? hoursDateTime : '0$hoursDateTime'}:${minutesDateTime >= 10 ? minutesDateTime : '0$minutesDateTime'}';
    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
        visible: _createOperatorController.loadingData,
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
                            key: _createOperatorFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _createOperatorController
                                            .cashierNameValidate(value),
                                    onSaved: (value) =>
                                        _cashierOperator.operatorName = value,
                                    controller: _createOperatorController
                                        .cashierNameField,
                                    label: 'Nome',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _createOperatorController
                                            .emailValidate(value),
                                    onSaved: (value) =>
                                        _cashierOperator.operatorEmail = value,
                                    controller: _createOperatorController
                                        .newOperatorEmailField,
                                    label: 'Email',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    suffixIcon: VisibilityIconComponent(
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
                                    validator: (value) =>
                                        _createOperatorController
                                            .passwordValidate(value),
                                    onSaved: (value) => _cashierOperator
                                        .operatorPassword = value,
                                    controller: _createOperatorController
                                        .newOperatorPasswordField,
                                    label: 'Senha',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    suffixIcon: VisibilityIconComponent(
                                        onTap: () {
                                          setState(() {
                                            _confirmationPasswordVisible =
                                                !_confirmationPasswordVisible;
                                          });
                                        },
                                        forVisibility: Icons.visibility,
                                        forHideContent: Icons.visibility_off,
                                        condition: _passwordVisible),
                                    radius: 15,
                                    obscureText:
                                        _confirmationPasswordVisible == true
                                            ? false
                                            : true,
                                    validator: (value) =>
                                        _createOperatorController
                                            .passwordValidate(value),
                                    onSaved: (value) =>
                                        _confirmationPassword = value,
                                    controller: _createOperatorController
                                        .newOperatorPasswordField,
                                    label: 'Confirmar senha',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _createOperatorController
                                            .cashierNumberValidate(value),
                                    onSaved: (value) => _cashierOperator
                                        .operatorNumber = int.tryParse(value!),
                                    label: 'Número do caixa',
                                    controller: _createOperatorController
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
                                          value: (startWithEnabledOperator ??
                                              false),
                                          onChanged: (value) {
                                            setState(() {
                                              startWithEnabledOperator = value;
                                              _cashierOperator.operatorEnabled =
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: CashHelperElevatedButton(
                    onPressed: () async {
                      _createOperatorFormKey.currentState!.validate();
                      _createOperatorFormKey.currentState!.save();
                      _cashierOperator.operatorClosing = 'Pendente';
                      _cashierOperator.operatorOcupation = "operator";
                      _cashierOperator.operatorEnabled =
                          startWithEnabledOperator ?? false ? true : false;
                      _cashierOperator.operatorOppening =
                          _cashierOperator.operatorEnabled == true
                              ? cashierOppeningTime
                              : 'Pendente';
                      if (_createOperatorFormKey.currentState!.validate()) {
                        if (_cashierOperator.operatorPassword ==
                            _confirmationPassword) {
                          setState(() {
                            _createOperatorController.loadingData = true;
                          });
                          final newOperator = await _loginStore
                              .register(_cashierOperator,
                                  _cashierOperator.operatorOcupation!)
                              ?.then((value) => value)
                              .catchError((e) {
                            if (e.toString().contains("already-in-use")) {
                              _createOperatorController.registrationFail(
                                  context,
                                  message: "Email já utilizado");
                            } else {
                              const String message = "Erro desconhecido";
                              _createOperatorController
                                  .registrationFail(context, message: message);
                            }
                          });
                          if (newOperator != null) {
                            _createOperatorController
                                .operatorCreatedSucessfully(context);
                            Modular.to.navigate("/operator-module/",
                                arguments: newOperator);
                          } else {
                            _createOperatorController.onFail(context);
                          }
                        } else {
                          _createOperatorController.noMatchingPasswords(context,
                              message: "As senhas não correspondem");
                        }
                      }
                      setState(() {
                        _createOperatorController.loadingData = false;
                      });
                    },
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
      ),
    );
  }
}
