import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';

import '../components/cash_helper_information_card.dart';

class AnnotationHome extends StatelessWidget {
  AnnotationHome({super.key, required this.annotationEntity});

  AnnotationEntity annotationEntity;
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final redColor = Theme.of(context).colorScheme.errorContainer;
    final red = Theme.of(context).colorScheme.onError;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;
    final greenColor = Theme.of(context).colorScheme.tertiaryContainer;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: height * 0.7,
            width: width,
            decoration: BoxDecoration(
              color: backgroundColor,
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
                    spacing: width * 0.2,
                    backgroundColor: tertiaryColor,
                    cardIcon: Icons.house_outlined,
                    iconSize: 55,
                    informationTitle: "Endereço:",
                    information: "${annotationEntity.annotationClientAddress}",
                    complementInformationTitle: "Horário:",
                    complementInformation:
                        "${annotationEntity.annotationSaleTime}",
                  ),
                  CashHelperInformationCard(
                    height: height * 0.15,
                    width: width,
                    radius: 15,
                    spacing: width * 0.24,
                    backgroundColor: redColor.withBlue(90).withOpacity(0.7),
                    cardIcon: Icons.monetization_on_outlined,
                    iconSize: 55,
                    informationTitle: "Valor:",
                    information: "${annotationEntity.annotationSaleValue}",
                    complementInformationTitle: "Pagamento:",
                    complementInformation:
                        "${annotationEntity.annotationPaymentMethod}",
                  ),
                  CashHelperInformationCard(
                    height: height * 0.15,
                    width: width,
                    radius: 15,
                    spacing: width * 0.03,
                    backgroundColor: annotationEntity.annotationConcluied!
                        ? greenColor.withOpacity(0.7)
                        : red,
                    cardIcon: Icons.monetization_on_outlined,
                    iconSize: 55,
                    informationTitle: "Status:",
                    information: annotationEntity.annotationConcluied!
                        ? "Finalizada"
                        : "Não Finalizada",
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Criada em :",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        "${annotationEntity.annotationSaleDate}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: height * 0.1,
              left: width * 0.07,
              child: Icon(
                Icons.library_books_outlined,
                size: 55,
                color: surfaceColor,
              ))
        ],
      ),
    );
  }
}
