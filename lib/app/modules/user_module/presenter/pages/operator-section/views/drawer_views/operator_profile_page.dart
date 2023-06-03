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
import '../../../../components/operator_widgets/operator_status_component.dart';
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
    widget.operatorEntity.operatorEnabled = false;
    return Scaffold(
      appBar: AppBar(),
      drawer: CashHelperDrawer(
        backgroundColor: appTheme.primaryColor(context),
        radius: 20,
        width: width,
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
            OperatorStatusComponent(
              textColor: appTheme.surfaceColor(context),
              activeColor: appTheme.greenColor(context),
              borderColor: appTheme.backgroundColor(context),
              inactiveColor: appTheme.purpleColor(context),
              operatorEntity: widget.operatorEntity,
              sidePosition: 25,
              topPosition: height * 0.12,
            ),
            SizedBox(
              height: height * 0.7,
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

/* Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.82,
                decoration: BoxDecoration(
                  color: appTheme.backgroundColor(context),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.04,
              left: width * 0.36,
              child: Text(
                widget.operatorEntity.operatorName ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Positioned(
              top: height * 0.02,
              left: width * 0.05,
              child: const Icon(
                Icons.person,
                size: 85,
              ),
            ),
            Positioned(
              top: height * 0.2,
              left: width * 0.01,
              child: SizedBox(
                height: height * 0.55,
                width: width * 0.98,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: appTheme.primaryColor(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        OperatorCardComponent(
                            height: height * 0.15,
                            width: width,
                            /* backgroundColor: secondaryColor, */
                            operatorEntity: widget.operatorEntity),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProfileInformationCard(
                                    /* backgroundColor: secondaryColor, */
                                    height: height * 0.165,
                                    width: width * 0.35,
                                    items: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: appTheme.surfaceColor(context),
                                      ),
                                      Text("Abertura:", style: fontSize),
                                      Text(
                                        widget.operatorEntity
                                                .operatorOppening ??
                                            "",
                                        style: fontSize,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ProfileInformationCard(
                                    height: height * 0.165,
                                    width: width * 0.35,
                                    /* backgroundColor: secondaryColor, */
                                    items: [
                                      Text("Código Ops.", style: fontSize),
                                      Text(
                                        showOperatorCode
                                            ? widget.operatorEntity
                                                    .operatorCode ??
                                                ""
                                            : "......",
                                        style: fontSize,
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          setState(() {
                                            showOperatorCode =
                                                !showOperatorCode;
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
                              const SizedBox(width: 10),
                              AnnotationsStatusCardComponent(
                                height: height * 0.34,
                                width: width * 0.54,
                                /* backgroundColor: secondaryColor, */
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ), */
