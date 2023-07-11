import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cards/close_page_informations_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../routes/app_routes.dart';
import '../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../domain/entities/operator_entity.dart';
import '../../../../components/tiles/operator_infortmations_tile.dart';

class OperatorClosePage extends StatefulWidget {
  const OperatorClosePage({super.key, required this.operatorEntity});

  final OperatorEntity operatorEntity;

  @override
  State<OperatorClosePage> createState() => _OperatorClosePageState();
}

final enterpriseId = Modular.args.params["enterpriseId"];
final operatorController = Modular.get<OperatorController>();
final dateValues = DateValues();

class _OperatorClosePageState extends State<OperatorClosePage> {
  @override
  void initState() {
    super.initState();
    operatorController.annotationsListStore.getAllAnnotations(
      enterpriseId,
    );
    operatorController.enterpriseId = enterpriseId;
    operatorController.operatorEntity = widget.operatorEntity;
    operatorController.operatorEntity?.operatorClosing = dateValues.operatorClosing;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    String oppeningTime = operatorController.operatorEntity?.operatorOppening == "Pendente" ? "Pendente" : operatorController.operatorEntity?.operatorOppening ?? "";
    String operatorStatus = operatorController.operatorEntity!.operatorEnabled! ? "Ativo" : "Inativo";
    final annotations = operatorController.annotationsListStore.value.where((annotation) => annotation.annotationCreatorId == widget.operatorEntity.operatorId).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Modular.to.navigate(
            "${UserRoutes.operatorHomePage}$enterpriseId",
            arguments: operatorController.operatorEntity!,
          ),
        ),
      ),
      body: Container(
        height: height,
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
                      operatorController.operatorEntity?.operatorName ?? "",
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
                                  content: "${operatorController.operatorEntity?.operatorNumber}",
                                  icon: Icons.monitor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrame ? height * 0.05 : height * 0.04,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Anotações:",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: appThemes.surfaceColor(context),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFrame ? height * 0.035 : height * 0.025,
                        ),
                        ClosePageInformationsComponent(
                          annotations: annotations,
                        ),
                        SizedBox(
                          height: sizeFrame ? height * 0.045 : height * 0.035,
                        ),
                        Center(
                          child: CashHelperElevatedButton(
                            border: true,
                            height: 50,
                            width: width * 0.7,
                            radius: 12,
                            onPressed: () {
                              operatorController.closeOperatorCash(
                                context,
                                appThemes.purpleColor(context),
                              );
                            },
                            buttonName: "Fechar Caixa",
                            backgroundColor: appThemes.greenColor(context),
                            fontSize: 16,
                          ),
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
    );
  }
}
