import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/cash_helper_text_field.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login_module/presenter/components/visibility_icon_component.dart';
import '../controller/management_controller.dart';
import '../stores/management_store.dart';

class CreatePaymentMethodPage extends StatefulWidget {
  const CreatePaymentMethodPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<CreatePaymentMethodPage> createState() =>
      _CreatePaymentMethodPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];
final _managementStore = Modular.get<ManagementStore>();
final _managementController = Modular.get<ManagementController>();
final _paymentMethodFormKey = GlobalKey<FormState>();
final _newPaymentMethod = PaymentMethodEntity();
String? _managerCode;
bool _managementCodeVisible = true;

class _CreatePaymentMethodPageState extends State<CreatePaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final errorColor = Theme.of(context).colorScheme.errorContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    child: Text(
                      "Métodos de Pagamento",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.08,
                      ),
                      Text(
                        "Criar novo método:",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SizedBox(
                        height: height * 0.27,
                        child: Form(
                          key: _paymentMethodFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CashHelperTextFieldComponent(
                                label: "Nome",
                                controller: _managementController
                                    .paymentMethodNameField,
                                validator: _managementController
                                    .paymentMethodNameValidate,
                                onSaved: (value) =>
                                    _newPaymentMethod.paymentMethodName = value,
                              ),
                              CashHelperTextFieldComponent(
                                label: "Descrição",
                                controller: _managementController
                                    .paymentMethodNameField,
                                onSaved: (value) => _newPaymentMethod
                                    .paymentMethodDescription = value,
                              ),
                              CashHelperTextFieldComponent(
                                suffixIcon: VisibilityIconComponent(
                                  onTap: () {
                                    setState(
                                      () {
                                        _managementCodeVisible =
                                            !_managementCodeVisible;
                                      },
                                    );
                                  },
                                  iconColor: surfaceColor,
                                  forVisibility: Icons.visibility,
                                  forHideContent: Icons.visibility_off,
                                  condition: _managementCodeVisible,
                                ),
                                obscureText:
                                    _managementCodeVisible ? false : true,
                                label: "Código Administrativo",
                                controller: _managementController
                                    .paymentMethodNameField,
                                validator: _managementController
                                    .paymentMethodNameValidate,
                                onSaved: (value) => _managerCode = value,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Center(
                        child: Column(
                          children: [
                            CashHelperElevatedButton(
                              radius: 10,
                              onPressed: () {
                                _paymentMethodFormKey.currentState?.validate();
                                _paymentMethodFormKey.currentState?.save();
                                if (_paymentMethodFormKey.currentState!
                                    .validate()) {
                                  if (_managerCode ==
                                      widget.managerEntity.managerCode) {
                                    _newPaymentMethod.paymentMethodUsingRate =
                                        0;
                                    _managementStore.createNewPaymentMethod(
                                        _enterpriseId, _newPaymentMethod);
                                    _managementController
                                        .paymentMethodAddedSnackBar(
                                      context,
                                      message:
                                          "Novo método de pagamento adicionado!",
                                    );
                                    Modular.to.navigate(
                                      "${UserRoutes.managerHomePage}$_enterpriseId",
                                      arguments: widget.managerEntity,
                                    );
                                  } else {
                                    _managementController.noMatchingCodes(
                                      context,
                                      message:
                                          "Código Administrativo Inválido!",
                                    );
                                  }
                                }
                              },
                              border: true,
                              backgroundColor: tertiaryColor,
                              height: 50,
                              width: width * 0.7,
                              buttonName: "Salvar",
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CashHelperElevatedButton(
                              radius: 10,
                              onPressed: () {
                                Modular.to.navigate(
                                    "${UserRoutes.managementPage}$_enterpriseId",
                                    arguments: widget.managerEntity);
                              },
                              border: true,
                              backgroundColor: primaryColor,
                              nameColor: surfaceColor,
                              height: 50,
                              width: width * 0.7,
                              buttonName: "Voltar",
                              fontSize: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
