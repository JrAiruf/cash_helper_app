import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/components/cash_helper_information_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user_module/domain/entities/operator_entity.dart';

class AnnotationPage extends StatefulWidget {
  const AnnotationPage({Key? key}) : super(key: key);
  @override
  State<AnnotationPage> createState() => _AnnotationPageState();
}

final AnnotationEntity annotationEntity = Modular.args.data["annotationEntity"];
final OperatorEntity operatorEntity = Modular.args.data["operatorEntity"];

class _AnnotationPageState extends State<AnnotationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height * 0.75,
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
                child: Column(
                  children: [
                    CashHelperInformationCard(
                        height: height * 0.15,
                        width: width,
                        radius: 15,
                        backgroundColor: tertiaryColor,
                        cardIcon: Icons.house_outlined,
                        iconSize: 65,
                        informationTitle: "Endereço:",
                        information:
                            "${annotationEntity.annotationClientAddress}",
                        complementInformationTitle: "Horário:",
                        complementInformation:
                            "${annotationEntity.annotationSaleTime}"),
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
