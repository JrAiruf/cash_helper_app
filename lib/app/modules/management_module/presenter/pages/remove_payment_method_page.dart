import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/visibility_icon_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../user_module/domain/entities/manager_entity.dart';
import '../../../user_module/presenter/controller/payment_methods_controller.dart';
import '../controller/management_controller.dart';
import '../stores/management_store.dart';

class RemovePaymentMethodPage extends StatefulWidget {
  const RemovePaymentMethodPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<RemovePaymentMethodPage> createState() =>
      _RemovePaymentMethodPageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];
final _managementController = Modular.get<ManagementController>();
final _managementStore = Modular.get<ManagementStore>();
final _paymentMethodController = Modular.get<PaymentMethodsController>();
final _removePaymentMethodFormKey = GlobalKey<FormState>();
String? _managerCode;
bool _managementCodeVisible = true;
String _paymentMethodId = "";

class _RemovePaymentMethodPageState extends State<RemovePaymentMethodPage> {
  @override
  void initState() {
    _paymentMethodController.getPaymentMethodsInformations(_enterpriseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final errorColor = Theme.of(context).colorScheme.errorContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
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
                        "Remover método:",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SizedBox(
                        height: height * 0.2,
                        child: Form(
                          key: _removePaymentMethodFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedBuilder(
                                animation: _paymentMethodController,
                                builder: (_, __) {
                                  return DropdownButtonFormField<
                                          PaymentMethodEntity>(
                                      validator: _managementController
                                          .paymentMethodValidate,
                                      onSaved: (value) => _paymentMethodId =
                                          value?.paymentMethodId ?? "",
                                      onChanged: (value) => _paymentMethodId =
                                          value?.paymentMethodId ?? "",
                                      hint: Text(
                                        "Selecione o método a ser removido",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(color: surfaceColor),
                                      ),
                                      items: _paymentMethodController.value
                                          .map(
                                            (paymentMethod) => DropdownMenuItem(
                                              value: paymentMethod,
                                              child: Text(
                                                paymentMethod
                                                        .paymentMethodName ??
                                                    "Parangaricutirimicuaro",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                        color: surfaceColor),
                                              ),
                                            ),
                                          )
                                          .toList());
                                },
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
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    CashHelperElevatedButton(
                      radius: 10,
                      onPressed: () {
                        _removePaymentMethodFormKey.currentState?.validate();
                        _removePaymentMethodFormKey.currentState?.save();
                        if (_removePaymentMethodFormKey.currentState!
                            .validate()) {
                          if (_managerCode ==
                              widget.managerEntity.managerCode) {
                            _managementStore.removePaymentMethod(
                                _enterpriseId, _paymentMethodId);
                            _managementController.paymentMethodRemovedSnackBar(
                                context,
                                message: "Método removido com sucesso");
                            Modular.to.navigate(
                                "${UserRoutes.managerHomePage}$_enterpriseId",
                                arguments: widget.managerEntity);
                          } else {
                            _managementController.noMatchingCodes(context,
                                message:
                                    "Opss... Código Administrativo Inválido!");
                          }
                        }
                      },
                      border: true,
                      backgroundColor: errorColor,
                      height: 50,
                      width: width * 0.7,
                      buttonName: "Remover",
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
    );
  }
}
