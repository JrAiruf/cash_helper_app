// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/tiles/operator_infortmations_tile.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store_states.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../../../domain/entities/operator_entity.dart';
import '../../../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorOppeningPage extends StatefulWidget {
  const OperatorOppeningPage({super.key, required this.operatorEntity, required this.position, required this.enterpriseId, required this.pageController});

  final OperatorEntity operatorEntity;
  final BottomNavigationBarPosition position;
  final String enterpriseId;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _OperatorOppeningPageState();
}

final operatorController = Modular.get<OperatorController>();
final operatorStore = Modular.get<OperatorStore>();

class _OperatorOppeningPageState extends State<OperatorOppeningPage> {
  @override
  void initState() {
    super.initState();
    operatorStore.setOperatorState(widget.operatorEntity);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final operatorPageController = PageController();
    final dateValue = DateValues();
    final appThemes = CashHelperThemes();
    operatorController.operatorEntity = widget.operatorEntity;
    operatorController.enterpriseId = widget.enterpriseId;
    String oppeningTime = operatorController.operatorEntity?.operatorOppening == "Pendente" ? "Pendente" : operatorController.operatorEntity?.operatorOppening ?? "";
    String operatorStatus = operatorController.operatorEntity!.operatorEnabled! ? "Ativo" : "Inativo";
    return ValueListenableBuilder(
        valueListenable: operatorStore,
        builder: (_, storeValue, __) {
          if (storeValue is LoadingCashState) {
            return Container(
              decoration: BoxDecoration(
                color: appThemes.backgroundColor(context),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: appThemes.indicatorColor(context),
                ),
              ),
            );
          } else if (storeValue is ClosedCashState) {
            return Container(
              decoration: BoxDecoration(
                color: appThemes.backgroundColor(context),
              ),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width,
                    decoration: BoxDecoration(
                      color: appThemes.primaryColor(context),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.person,
                            size: 55,
                          ),
                          Text(
                            widget.operatorEntity.operatorName ?? "",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: appThemes.surfaceColor(context),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: sizeFrame ? height * 0.23 : height * 0.22,
                    child: SizedBox(
                      height: sizeFrame ? height * 0.65 : height * 0.75,
                      width: width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: sizeFrame ? height * 0.1 : height * 0.09,
                                decoration: BoxDecoration(
                                  color: appThemes.primaryColor(context),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OperatorInformationsTile(
                                        content: operatorStatus,
                                        icon: Icons.power_settings_new_rounded,
                                      ),
                                      OperatorInformationsTile(
                                        content: oppeningTime,
                                        icon: Icons.access_time,
                                      ),
                                      OperatorInformationsTile(
                                        content: "${widget.operatorEntity.operatorNumber}",
                                        icon: Icons.monitor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: sizeFrame ? height * 0.09 : height * 0.08),
                              Form(
                                key: operatorController.operatorCodeFormKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CashHelperTextFieldComponent(
                                        primaryColor: appThemes.surfaceColor(context),
                                        radius: 15,
                                        validator: operatorController.cashierCodeValidate,
                                        onSaved: (value) => operatorController.operatorCode = value ?? "",
                                        controller: operatorController.cashierCodeField,
                                        label: 'Código Ops.',
                                      ),
                                      SizedBox(height: sizeFrame ? height * 0.05 : height * 0.04),
                                    ],
                                  ),
                                ),
                              ),
                              CashHelperElevatedButton(
                                onPressed: () {
                                  operatorController.operatorCodeFormKey.currentState!.validate();
                                  if (operatorController.operatorCodeFormKey.currentState!.validate()) {
                                    operatorController.operatorCodeFormKey.currentState!.save();
                                    operatorController.operatorEntity?.operatorOppening = dateValue.operatorOppening;
                                    operatorController.openOperatorCash(context);
                                  } else {
                                    operatorController.wrongCodeSnackbar(context);
                                  }
                                },
                                border: true,
                                radius: 12,
                                width: width * 0.7,
                                height: 50,
                                buttonName: 'Abrir Caixa',
                                fontSize: 15,
                                backgroundColor: appThemes.greenColor(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (storeValue is OpenedCashState) {
            return Container(
              decoration: BoxDecoration(
                color: appThemes.backgroundColor(context),
              ),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width,
                    decoration: BoxDecoration(
                      color: appThemes.primaryColor(context),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.person,
                            size: 55,
                          ),
                          Text(
                            widget.operatorEntity.operatorName ?? "",
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: appThemes.surfaceColor(context),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: sizeFrame ? height * 0.23 : height * 0.22,
                    child: SizedBox(
                      height: height * 0.65,
                      width: width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: sizeFrame ? height * 0.1 : height * 0.09,
                                decoration: BoxDecoration(
                                  color: appThemes.primaryColor(context),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OperatorInformationsTile(
                                        content: operatorStatus,
                                        icon: Icons.beenhere_outlined,
                                      ),
                                      OperatorInformationsTile(
                                        content: oppeningTime,
                                        icon: Icons.access_time,
                                      ),
                                      OperatorInformationsTile(
                                        content: "${widget.operatorEntity.operatorNumber}",
                                        icon: Icons.monitor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: sizeFrame ? height * 0.1 : height * 0.09),
                              Center(
                                child: Text(
                                  "Caixa Aberto!",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: appThemes.surfaceColor(context),
                                      ),
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
            );
          } else {
            return Container();
          }
        });
  }
}
