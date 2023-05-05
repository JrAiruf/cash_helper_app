import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/stores/enterprise_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../controller/enterprise_controller.dart';
import '../stores/enterprise_store.dart';

class CreateEnterprisePage extends StatefulWidget {
  const CreateEnterprisePage({required this.enterpriseEntity, super.key});

  final EnterpriseEntity enterpriseEntity;
  @override
  State<CreateEnterprisePage> createState() => _CreateEnterprisePageState();
}

class _CreateEnterprisePageState extends State<CreateEnterprisePage> {
  final _createEnterpriseFormKey = GlobalKey<FormState>();
  final _enterpriseController = Modular.get<EnterpriseController>();
  final _enterpriseStore = Modular.get<EnterpriseStore>();
  String? _confirmationPassword = "";
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
      body: ValueListenableBuilder(
        valueListenable: _enterpriseStore,
        builder: (_, state, __) {
          if (state is LoadingState) {
            return Container(
              decoration: BoxDecoration(color: primaryColor),
              height: height,
              width: width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            );
          } else if (state is EnterpriseStoreInitialState) {
            return SingleChildScrollView(
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
                            height: height * 0.35,
                            width: width * 0.95,
                            child: Card(
                              color: seccondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Form(
                                key: _createEnterpriseFormKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CashHelperTextFieldComponent(
                                        textColor: onSurface,
                                        primaryColor: onSurface,
                                        radius: 15,
                                        validator: (value) =>
                                            _enterpriseController
                                                .enterpriseEmailValidate(value),
                                        onSaved: (value) => widget
                                            .enterpriseEntity
                                            .enterpriseEmail = value,
                                        controller: _enterpriseController
                                            .enterpriseEmailField,
                                        label: 'E-mail empresarial',
                                      ),
                                      Text('E-mail para uso na aplicação',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const SizedBox(height: 15),
                                      CashHelperTextFieldComponent(
                                        textColor: onSurface,
                                        primaryColor: onSurface,
                                        radius: 15,
                                        validator: (value) =>
                                            _enterpriseController
                                                .passwordValidate(value),
                                        onSaved: (value) => widget
                                            .enterpriseEntity
                                            .enterprisePassword = value,
                                        controller: _enterpriseController
                                            .newEnterprisePasswordField,
                                        label: 'Senha',
                                      ),
                                      CashHelperTextFieldComponent(
                                        textColor: onSurface,
                                        primaryColor: onSurface,
                                        radius: 15,
                                        validator: (value) =>
                                            _enterpriseController
                                                .passwordValidate(value),
                                        onSaved: (value) =>
                                            _confirmationPassword = value,
                                        controller:
                                            _enterpriseController.cityField,
                                        label: 'Confirmar Senha',
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
                    SizedBox(height: height * 0.3),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: CashHelperElevatedButton(
                        onPressed: () async {
                          _createEnterpriseFormKey.currentState?.validate();
                          _createEnterpriseFormKey.currentState?.save();
                          if (_createEnterpriseFormKey.currentState!
                              .validate()) {
                            if (_confirmationPassword ==
                                widget.enterpriseEntity.enterprisePassword) {
                              _enterpriseStore.createEnterpriseAccount(
                                  widget.enterpriseEntity);
                            } else {
                              _enterpriseController.noMatchingPasswords(context,
                                  message: "As senhas não correspondem");
                            }
                          }
                        },
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
            );
          } else if (state is CreatedEnterpriseState) {
            final enterprise = state.enterprise;
            Modular.to.pushReplacementNamed(EnterpriseRoutes.enterpriseCreated,
                arguments: enterprise);
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
