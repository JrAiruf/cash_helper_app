import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../user_module/domain/entities/manager_entity.dart';
import '../components/buttons/cash_helper_login_button.dart';
import '../components/cash_helper_text_field.dart';

class CreateManagerPage extends StatefulWidget {
  const CreateManagerPage({super.key, required this.enterpriseEntity});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<CreateManagerPage> createState() => _CreateManagerPageState();
}

final _createManagerFormKey = GlobalKey<FormState>();
final _enterpriseController = Modular.get<LoginController>();
final _loginStore = Modular.get<LoginStore>();
final _managerEntity = ManagerEntity();
String? _confirmartionPassword = "";

class _CreateManagerPageState extends State<CreateManagerPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final surface = Theme.of(context).colorScheme.surface;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: primaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text('Cash Helper',
                    style: Theme.of(context).textTheme.bodyLarge),
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
                      child: Text('Dados Empresariais',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: surface)),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: height * 0.7,
                      width: width * 0.95,
                      child: Card(
                        color: seccondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _createManagerFormKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CashHelperTextFieldComponent(
                                  textColor: onSurface,
                                  primaryColor: onSurface,
                                  radius: 15,
                                  validator: (value) => _enterpriseController
                                      .cashierNameValidate(value),
                                  onSaved: (value) =>
                                      _managerEntity.managerName = value,
                                  controller:
                                      _enterpriseController.cashierNameField,
                                  label: 'Nome Completo',
                                ),
                                CashHelperTextFieldComponent(
                                  textColor: onSurface,
                                  primaryColor: onSurface,
                                  radius: 15,
                                  validator: (value) =>
                                      _enterpriseController.cpfValidate(value),
                                  onSaved: (value) =>
                                      _managerEntity.managerCpf = value,
                                  controller:
                                      _enterpriseController.managerCpfField,
                                  label: 'CPF',
                                ),
                                CashHelperTextFieldComponent(
                                  textColor: onSurface,
                                  primaryColor: onSurface,
                                  radius: 15,
                                  onSaved: (value) =>
                                      _managerEntity.managerRg = value,
                                  validator: (value) =>
                                      _enterpriseController.rgValidate(value),
                                  controller:
                                      _enterpriseController.managerRgField,
                                  label: 'RG',
                                ),
                                CashHelperTextFieldComponent(
                                  textColor: onSurface,
                                  primaryColor: onSurface,
                                  radius: 15,
                                  validator: (value) => _enterpriseController
                                      .phoneValidate(value),
                                  onSaved: (value) =>
                                      _managerEntity.managerPhone = value,
                                  controller:
                                      _enterpriseController.managerPhoneField,
                                  label: 'Telefone',
                                ),
                                CashHelperTextFieldComponent(
                                  textColor: onSurface,
                                  primaryColor: onSurface,
                                  radius: 15,
                                  validator: (value) => _enterpriseController
                                      .emailValidate(value),
                                  onSaved: (value) =>
                                      _managerEntity.managerEmail = value,
                                  controller: _enterpriseController.emailField,
                                  label: 'E-mail',
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CashHelperTextFieldComponent(
                                        textColor: onSurface,
                                        primaryColor: onSurface,
                                        radius: 15,
                                        validator: (value) =>
                                            _enterpriseController
                                                .passwordValidate(value),
                                        onSaved: (value) => _managerEntity
                                            .managerPassword = value,
                                        controller: _enterpriseController
                                            .newManagerPasswordField,
                                        label: 'Senha',
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: CashHelperTextFieldComponent(
                                        textColor: onSurface,
                                        primaryColor: onSurface,
                                        radius: 15,
                                        validator: (value) =>
                                            _enterpriseController
                                                .confirmationPasswordValidate(
                                                    value),
                                        onSaved: (value) =>
                                            _confirmartionPassword = value,
                                        controller: _enterpriseController
                                            .confirmationPasswordField,
                                        label: 'Número',
                                      ),
                                    ),
                                  ],
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
                  onPressed: () {
                    _createManagerFormKey.currentState?.validate();
                    _createManagerFormKey.currentState?.save();
                    _managerEntity.businessPosition = "";
                    if (_createManagerFormKey.currentState!.validate()) {
                      _loginStore.registerManager(
                          _managerEntity,
                          widget.enterpriseEntity.enterpriseId!,
                          _managerEntity.businessPosition!);
                    }
                  },
                  width: width,
                  height: 65,
                  buttonName: 'Registrar',
                  fontSize: 15,
                  nameColor: Colors.white,
                  backgroundColor: seccondaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
