import 'package:cash_helper_app/app/modules/enterprise_module/presenter/controller/enterprise_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../user_module/domain/entities/operator_entity.dart';

class CreateEnterprisePage extends StatefulWidget {
  const CreateEnterprisePage({super.key});

  @override
  State<CreateEnterprisePage> createState() => _CreateEnterprisePageState();
}

class _CreateEnterprisePageState extends State<CreateEnterprisePage> {
  final _createOperatorFormKey = GlobalKey<FormState>();
  // final _loginStore = Modular.get<EnterpriseStore>();
  // final _loginStore = Modular.get<LoginStore>();
  final _enterpriseController = Modular.get<EnterpriseController>();
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
    final surface = Theme.of(context).colorScheme.surface;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;

    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
        visible: _enterpriseController.loadingData,
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
                    horizontal: 15,
                    vertical: height * 0.015,
                  ),
                  child: Text('Cash Helper',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Dados Empresariais',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: surface)),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: height * 0.65,
                        width: width * 0.95,
                        child: Card(
                          color: seccondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Form(
                            key: _createOperatorFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _enterpriseController
                                            .cnpjValidate(value),
                                    onSaved: (value) =>
                                        _cashierOperator.operatorName = value,
                                    controller: _enterpriseController
                                        .cnpjField,
                                    label: 'CNPJ',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _enterpriseController
                                            .enterpriseNameValidate(value),
                                    onSaved: (value) =>
                                        _cashierOperator.operatorEmail = value,
                                    controller: _enterpriseController
                                        .enterpriseNameField,
                                    label: 'Nome da Empresa',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    obscureText:
                                        _passwordVisible == true ? false : true,
                                    validator: (value) =>
                                        _enterpriseController
                                            .cityValidate(value),
                                    onSaved: (value) => _cashierOperator
                                        .operatorPassword = value,
                                    controller: _enterpriseController
                                        .cityField,
                                    label: 'Cidade',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    obscureText:
                                        _confirmationPasswordVisible == true
                                            ? false
                                            : true,
                                    validator: (value) =>
                                        _enterpriseController
                                            .cepValidate(value),
                                    onSaved: (value) =>
                                        _confirmationPassword = value,
                                    controller: _enterpriseController
                                        .cepField,
                                    label: 'CEP',
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    obscureText:
                                        _passwordVisible == true ? false : true,
                                    validator: (value) =>
                                        _enterpriseController
                                            .stateValidate(value),
                                    onSaved: (value) => _cashierOperator
                                        .operatorPassword = value,
                                    controller: _enterpriseController
                                        .stateField,
                                    label: 'Estado',
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CashHelperTextFieldComponent(
                                          textColor: onSurface,
                                          primaryColor: onSurface,
                                          radius: 15,
                                          obscureText:
                                              _confirmationPasswordVisible ==
                                                      true
                                                  ? false
                                                  : true,
                                          validator: (value) =>
                                              _enterpriseController
                                                  .streetValidate(value),
                                          onSaved: (value) =>
                                              _confirmationPassword = value,
                                          controller: _enterpriseController
                                              .streetField,
                                          label: 'Rua',
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: CashHelperTextFieldComponent(
                                          textColor: onSurface,
                                          primaryColor: onSurface,
                                          radius: 15,
                                          obscureText:
                                              _confirmationPasswordVisible ==
                                                      true
                                                  ? false
                                                  : true,
                                          validator: (value) =>
                                              _enterpriseController
                                                  .addressNumberValidate(value),
                                          onSaved: (value) =>
                                              _confirmationPassword = value,
                                          controller: _enterpriseController
                                              .addressNumberField,
                                          label: 'Número',
                                        ),
                                      ),
                                    ],
                                  ),
                                  CashHelperTextFieldComponent(
                                    textColor: onSurface,
                                    primaryColor: onSurface,
                                    radius: 15,
                                    validator: (value) =>
                                        _enterpriseController
                                            .phoneNumberValidate(value),
                                    onSaved: (value) => _cashierOperator
                                        .operatorNumber = int.tryParse(value!),
                                    label: 'Telefone',
                                    controller: _enterpriseController
                                        .enterpriseEmailField,
                                    input: TextInputType.phone,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: CashHelperElevatedButton(
                    onPressed: () async {},
                    width: width,
                    height: 65,
                    buttonName: 'Próximo',
                    fontSize: 15,
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
