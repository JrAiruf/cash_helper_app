// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/annotations_module/presenter/components/payment_method_using_rate_component.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../login_module/presenter/controllers/login_controller.dart';
import '../../../../../../management_module/presenter/controller/management_controller.dart';
import '../../../../components/cards/operator_card_component.dart';
import '../../../../components/cards/profile_informations_card.dart';
import '../../../../components/widgets/cash_helper_drawer.dart';

class OperatorProfilePage extends StatefulWidget {
  OperatorProfilePage({
    super.key,
    required this.operatorEntity,
  });

  OperatorEntity operatorEntity;
  @override
  State<OperatorProfilePage> createState() => _OperatorProfilePageState();
}

final _enterpriseId = Modular.args.params["enterpriseId"];
DrawerPagePosition? drawerPosition;
bool showOperatorCode = false;
final _annotationController = Modular.get<AnnotationsController>();
final _managementController = Modular.get<ManagementController>();

class _OperatorProfilePageState extends State<OperatorProfilePage> {
  @override
  void initState() {
    super.initState();
    _annotationController.getAllAnnotations();
    _managementController.getAllPaymentMethods(_enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 750.0;
    return Scaffold(
      appBar: AppBar(),
      drawer: CashHelperDrawer(
        backgroundColor: appTheme.primaryColor(context),
        radius: 20,
        width: width * 0.75,
        pagePosition: DrawerPagePosition.profile,
        operator: widget.operatorEntity,
        enterpriseId: _enterpriseId,
      ),
      body: Container(
        height: height,
        decoration: BoxDecoration(color: appTheme.primaryColor(context)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height * 0.75,
              decoration: BoxDecoration(
                color: appTheme.backgroundColor(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: height * 0.06,
              child: Center(
                child: Text(
                  widget.operatorEntity.operatorName ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: appTheme.surfaceColor(context)),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.71,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informações:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appTheme.surfaceColor(context),
                          ),
                    ),
                    OperatorCardComponent(
                      height: height * 0.18,
                      width: width,
                      backgroundColor: appTheme.primaryColor(context),
                      operatorEntity: widget.operatorEntity,
                      annotationsList: _annotationController.annotationsList,
                    ),
                    Text(
                      "Anotações nesta semana:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appTheme.surfaceColor(context),
                          ),
                    ),
                    AnimatedBuilder(
                      animation: _managementController.paymentMethods,
                      builder: (_, __) {
                        return PaymentMethodUsingRateComponent(
                          cardBackgroundColor: appTheme.primaryColor(context),
                          textColor: appTheme.surfaceColor(context),
                          height: height * 0.001,
                          width: width * 0.2,
                          componentHeight: height * 0.12,
                          componentWidth: width,
                          paymentMethods:
                              _managementController.paymentMethods.value,
                          annotations: _annotationController.annotationsList,
                        );
                      },
                    ),
                    Text(
                      "Informações do Operador:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: appTheme.surfaceColor(context),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileInformationCard(
                            backgroundColor: appTheme.primaryColor(context),
                            height: height * 0.165,
                            width: width * 0.35,
                            items: [
                              Icon(
                                Icons.access_time_rounded,
                                color: appTheme.surfaceColor(context),
                              ),
                              Text("Abertura:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        color: appTheme.surfaceColor(context),
                                      )),
                              Text(
                                widget.operatorEntity.operatorOppening ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: appTheme.surfaceColor(context),
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ProfileInformationCard(
                            height: height * 0.165,
                            width: width * 0.35,
                            backgroundColor: appTheme.primaryColor(context),
                            items: [
                              Text("Código Ops.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        color: appTheme.surfaceColor(context),
                                      )),
                              Text(
                                showOperatorCode
                                    ? widget.operatorEntity.operatorCode!
                                    : "......",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: appTheme.surfaceColor(context),
                                    ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    showOperatorCode = !showOperatorCode;
                                  });
                                }),
                                child: Icon(
                                  showOperatorCode
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: appTheme.surfaceColor(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
