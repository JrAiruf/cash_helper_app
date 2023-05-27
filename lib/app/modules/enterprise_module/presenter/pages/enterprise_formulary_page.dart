import 'package:cash_helper_app/app/modules/enterprise_module/presenter/controller/enterprise_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';

class EnterpriseFormularyPage extends StatefulWidget {
  const EnterpriseFormularyPage({super.key});

  @override
  State<EnterpriseFormularyPage> createState() =>
      _EnterpriseFormularyPageState();
}

class _EnterpriseFormularyPageState extends State<EnterpriseFormularyPage> {
  final _enterpriseController = Modular.get<EnterpriseController>();

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
      body: SizedBox(
        height: height,
        width: width,
        child: Visibility(
          visible: _enterpriseController.loadingData,
          replacement: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      'Cash Helper',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
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
                          height: height * 0.85,
                          width: width * 0.95,
                          child: Card(
                            color: seccondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Form(
                              key: _enterpriseController.enterpriseFormKey,
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
                                      validator:
                                          _enterpriseController.cnpjValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterpriseCnpj = value,
                                      controller:
                                          _enterpriseController.cnpjField,
                                      label: 'CNPJ',
                                    ),
                                    CashHelperTextFieldComponent(
                                      textColor: onSurface,
                                      primaryColor: onSurface,
                                      radius: 15,
                                      validator: _enterpriseController
                                          .enterpriseNameValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterpriseName = value,
                                      controller: _enterpriseController
                                          .enterpriseNameField,
                                      label: 'Nome da Empresa',
                                    ),
                                    CashHelperTextFieldComponent(
                                      textColor: onSurface,
                                      primaryColor: onSurface,
                                      radius: 15,
                                      validator:
                                          _enterpriseController.cityValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterpriseCity = value,
                                      controller:
                                          _enterpriseController.cityField,
                                      label: 'Cidade',
                                    ),
                                    CashHelperTextFieldComponent(
                                      textColor: onSurface,
                                      primaryColor: onSurface,
                                      radius: 15,
                                      validator:
                                          _enterpriseController.cepValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterpriseCep = value,
                                      controller:
                                          _enterpriseController.cepField,
                                      label: 'CEP',
                                    ),
                                    CashHelperTextFieldComponent(
                                      textColor: onSurface,
                                      primaryColor: onSurface,
                                      radius: 15,
                                      validator:
                                          _enterpriseController.stateValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterpriseState = value,
                                      controller:
                                          _enterpriseController.stateField,
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
                                            validator: _enterpriseController
                                                .streetValidate,
                                            onSaved: (value) =>
                                                _enterpriseController
                                                        .enterpriseEntity
                                                        .enterpriseAddressStreet =
                                                    value,
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
                                            validator: _enterpriseController
                                                .addressNumberValidate,
                                            onSaved: (value) =>
                                                _enterpriseController
                                                        .enterpriseEntity
                                                        .enterpriseAddressNumber =
                                                    int.tryParse(value ?? "0"),
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
                                      validator: _enterpriseController
                                          .phoneNumberValidate,
                                      onSaved: (value) => _enterpriseController
                                          .enterpriseEntity
                                          .enterprisePhoneNumber = value,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 40),
                    child: CashHelperElevatedButton(
                      radius: 15,
                      onPressed: _enterpriseController.nextRegistrationStep,
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
      ),
    );
  }
}
