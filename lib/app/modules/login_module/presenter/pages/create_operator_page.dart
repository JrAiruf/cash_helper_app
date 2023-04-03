import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../operator_module/domain/entities/operator_entity.dart';
import '../components/cash_helper_text_field.dart';
import '../controllers/login_controller.dart';
import '../stores/login_controller.dart';

class CreateOperatorPage extends StatefulWidget {
  CreateOperatorPage({super.key});

  @override
  State<CreateOperatorPage> createState() => _CreateOperatorPageState();
}

class _CreateOperatorPageState extends State<CreateOperatorPage> {
  final _createOperatorFormKey = GlobalKey<FormState>();

  final _loginStore = Modular.get<LoginStore>();

  final _createOperatorController = Modular.get<LoginController>();

  bool? startWithEnabledOperator;

  final cashierOperator = OperatorEntity();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final backgroundColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: height,
        width: width,
        child: Visibility(
          visible: _loginStore.loadingData,
          replacement: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                children: [
                  SizedBox(height: height * 0.08),
                  Text('Godinho \nSupermercado',
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: height * 0.08),
                  SizedBox(
                    height: height * 0.6,
                    width: width * 0.9,
                    child: Card(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Form(
                        key: _createOperatorFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CashHelperTextFieldComponent(
                                isButton: false,
                                validator: (value) => _createOperatorController
                                    .cashierNameValidate(value),
                                onSaved: (value) =>
                                    cashierOperator.operatorName = value,
                                controller:
                                    _createOperatorController.cashierNameField,
                                label: 'Nome',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CashHelperTextFieldComponent(
                                isButton: false,
                                validator: (value) => _createOperatorController
                                    .emailValidate(value),
                                onSaved: (value) =>
                                    cashierOperator.operatorEmail = value,
                                controller: _createOperatorController
                                    .newOperatorEmailField,
                                label: 'Email',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CashHelperTextFieldComponent(
                                isButton: false,
                                obscureText: true,
                                validator: (value) => _createOperatorController
                                    .passwordValidate(value),
                                onSaved: (value) =>
                                    cashierOperator.operatorPassword = value,
                                controller: _createOperatorController
                                    .newOperatorPasswordField,
                                label: 'Senha',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CashHelperTextFieldComponent(
                                isButton: false,
                                validator: (value) => _createOperatorController
                                    .cashierNumberValidate(value),
                                onSaved: (value) => cashierOperator
                                    .operatorNumber = int.tryParse(value!),
                                label: 'Número do caixa',
                                controller:
                                    _createOperatorController.cashierNumberField,
                                input: TextInputType.phone,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Abertura de caixa',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Switch(
                                    activeColor: backgroundColor,
                                    value: (startWithEnabledOperator ?? false),
                                    onChanged: (value) {
                                      setState(() {
                                        startWithEnabledOperator = value;
                                        cashierOperator.operatorEnabled = value;
                                      });
                                    },
                                  ),
                                ],
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
          ),
          child: Container(
            decoration: BoxDecoration(color: primaryColor),
            height: height,
            width: width,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
