// ignore_for_file: use_build_context_synchronously

import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/cash_helper_text_field.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_states.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../login_module/presenter/components/visibility_icon_component.dart';
import '../../controller/management_controller.dart';

class CreatePaymentMethodPage extends StatefulWidget {
  const CreatePaymentMethodPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<CreatePaymentMethodPage> createState() => _CreatePaymentMethodPageState();
}

final _managementController = Modular.get<ManagementController>();

class _CreatePaymentMethodPageState extends State<CreatePaymentMethodPage> {
  @override
  void initState() {
    super.initState();
    _managementController.manager = widget.managerEntity;
    _managementController.enterpriseId = Modular.args.params["enterpriseId"];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<PaymentMethodsBloc, PaymentMethodStates>(
            bloc: _managementController.paymentMethodsBloc,
            listener: (_, state) {
              if (state is PaymentMethodSuccessState) {
                Modular.to.navigate(
                  "${UserRoutes.managementPage}${_managementController.enterpriseId}",
                  arguments: widget.managerEntity,
                );
              }
            },
            builder: (_, state) {
              if (state is PaymentMethodLoadingState) {
                return Container(
                  height: height,
                  decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: appThemes.indicatorColor(context),
                    ),
                  ),
                );
              }
              if (state is PaymentMethodErrorState) {
                return Container(
                    decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                    child: Text(
                      state.error,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ));
              }
              if (state is PaymentMethodInitialState) {
                return Container(
                  height: height,
                  decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: appThemes.primaryColor(context),
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
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              SizedBox(
                                height: height * 0.27,
                                child: Form(
                                  key: _managementController.paymentMethodFormKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CashHelperTextFieldComponent(
                                        label: "Nome",
                                        controller: _managementController.paymentMethodNameField,
                                        validator: _managementController.paymentMethodNameValidate,
                                        onSaved: (value) => _managementController.newPaymentMethod.paymentMethodName = value,
                                      ),
                                      CashHelperTextFieldComponent(
                                        label: "Descrição",
                                        controller: _managementController.paymentMethodNameField,
                                        onSaved: (value) => _managementController.newPaymentMethod.paymentMethodDescription = value,
                                      ),
                                      AnimatedBuilder(
                                          animation: _managementController.managementCodeVisible,
                                          builder: (_, __) {
                                            return CashHelperTextFieldComponent(
                                              suffixIcon: VisibilityIconComponent(
                                                onTap: () {
                                                  _managementController.managementCodeVisible.value = !_managementController.managementCodeVisible.value;
                                                },
                                                iconColor: appThemes.surfaceColor(context),
                                                forVisibility: Icons.visibility,
                                                forHideContent: Icons.visibility_off,
                                                condition: _managementController.managementCodeVisible.value,
                                              ),
                                              obscureText: _managementController.managementCodeVisible.value ? false : true,
                                              label: "Código Administrativo",
                                              controller: _managementController.paymentMethodNameField,
                                              validator: _managementController.paymentMethodNameValidate,
                                              onSaved: (value) => _managementController.managerCode = value,
                                            );
                                          }),
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
                                        _managementController.createPaymentMethod(context);
                                      },
                                      border: true,
                                      backgroundColor: appThemes.greenColor(context),
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
                                        Modular.to.navigate("${UserRoutes.managementPage}${_managementController.enterpriseId}", arguments: widget.managerEntity);
                                      },
                                      border: true,
                                      backgroundColor: appThemes.primaryColor(context),
                                      nameColor: appThemes.surfaceColor(context),
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
                );
              }
              return Container();
            }),
      ),
    );
  }
}
