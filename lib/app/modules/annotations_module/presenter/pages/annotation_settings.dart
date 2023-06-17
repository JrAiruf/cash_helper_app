// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/buttons/quick_access_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/themes/cash_helper_themes.dart';
import '../../domain/entities/annotation_entity.dart';
import '../components/cash_helper_information_card.dart';

class AnnotationSettings extends StatelessWidget {
  AnnotationSettings(
      {super.key,
      required this.annotationEntity,
      required this.operatorEntity,
      required this.enterpriseId});

  AnnotationEntity annotationEntity;
  OperatorEntity operatorEntity;
  String enterpriseId;
  final _annotationsController = Modular.get<AnnotationsController>();
  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    _annotationsController.annotationId = annotationEntity.annotationId!;
    _annotationsController.enterpriseId = enterpriseId;
    return AnimatedBuilder(
        animation: _annotationsController.annotationLoadingState,
        builder: (context, _) {
          return Visibility(
            visible: !_annotationsController.annotationLoadingState.value,
            replacement: Center(
              child: CircularProgressIndicator(
                color: appTheme.indicatorColor(context),
              ),
            ),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: appTheme.primaryColor(context),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: height * 0.7,
                    width: width,
                    decoration: BoxDecoration(
                      color: appTheme.backgroundColor(context),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      height: height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CashHelperInformationCard(
                            height: height * 0.15,
                            width: width,
                            radius: 15,
                            spacing: 0.15,
                            backgroundColor: appTheme.violetColor(context),
                            cardIcon: Icons.house_outlined,
                            iconSize: 55,
                            informationTitle: "Endereço:",
                            information:
                                "${annotationEntity.annotationClientAddress}",
                            complementInformationTitle: "Horário:",
                            complementInformation:
                                "${annotationEntity.annotationSaleTime}",
                          ),
                          CashHelperInformationCard(
                            height: height * 0.15,
                            width: width,
                            radius: 15,
                            spacing: 0.154,
                            backgroundColor: appTheme
                                .redColor(context)
                                .withBlue(90)
                                .withOpacity(0.7),
                            cardIcon: Icons.monetization_on_outlined,
                            iconSize: 55,
                            informationTitle: "Valor:",
                            information:
                                "${annotationEntity.annotationSaleValue}",
                            complementInformationTitle: "Pagamento:",
                            complementInformation:
                                "${annotationEntity.annotationPaymentMethod}",
                          ),
                          SizedBox(
                            height: height * 0.24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QuickAccessButton(
                                  border: true,
                                  radius: 20,
                                  backgroundColor:
                                      appTheme.primaryColor(context),
                                  height: height * 0.1,
                                  width: width * 0.42,
                                  itemsColor: appTheme.surfaceColor(context),
                                  onPressed: () =>
                                      _annotationsController.finishAnnotation(
                                          context, operatorEntity),
                                  items: [
                                    Icon(
                                      Icons.done,
                                      color: appTheme.surfaceColor(context),
                                    ),
                                    Text(
                                      "Finalizar",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color:
                                                appTheme.surfaceColor(context),
                                          ),
                                    ),
                                  ],
                                ),
                                QuickAccessButton(
                                  border: true,
                                  radius: 20,
                                  backgroundColor:
                                      appTheme.primaryColor(context),
                                  height: height * 0.1,
                                  width: width * 0.42,
                                  itemsColor: appTheme.surfaceColor(context),
                                  onPressed: () =>
                                      _annotationsController.deleteAnnotation(
                                          context, operatorEntity),
                                  items: [
                                    Icon(
                                      Icons.delete,
                                      color: appTheme.surfaceColor(context),
                                    ),
                                    Text(
                                      "Excluir",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color:
                                                appTheme.surfaceColor(context),
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
                  Positioned(
                    top: sizeFrame ? height * 0.05 : 0.1,
                    left: width * 0.07,
                    child: Icon(
                      Icons.settings,
                      size: 55,
                      color: appTheme.surfaceColor(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
