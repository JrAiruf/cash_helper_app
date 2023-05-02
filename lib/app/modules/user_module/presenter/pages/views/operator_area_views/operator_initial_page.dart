import 'package:cash_helper_app/app/modules/user_module/presenter/components/operator_widgets/cash_number_component.dart';
import 'package:flutter/material.dart';

import '../../../../../annotations_module/domain/entities/annotation_entity.dart';
import '../../../../domain/entities/operator_entity.dart';
import '../../../components/cash_helper_bottom_navigation_bar.dart';
import '../../../components/widgets/annotations_list_view_component.dart';

class OperatorInitialPage extends StatefulWidget {
  const OperatorInitialPage(
      {super.key,
      required this.operatorEntity,
      this.position,
      required this.pageController});
  final OperatorEntity operatorEntity;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  @override
  State<OperatorInitialPage> createState() => _OperatorInitialtate();
}

class _OperatorInitialtate extends State<OperatorInitialPage> {
  bool _doneAnnotations = true;
  final _listTypeController = PageController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;

    final annotationzinha = AnnotationEntity(
        annotationClientAddress: "Andorinhas 381",
        annotationConcluied: false,
        annotationPaymentMethod: "Dinheiro",
        annotationReminder: "No Reminder",
        annotationSaleDate: "Data Atual",
        annotationSaleTime: "Hora Atual",
        annotationSaleValue: "1455,67");

    final annotationsListinha = <AnnotationEntity>[
      annotationzinha,
      annotationzinha,
      annotationzinha,
      annotationzinha,
      annotationzinha,
    ];

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundContainer,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            widthFactor: width,
            child: SizedBox(
              height: height * 0.65,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.27),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                          _doneAnnotations ? "Finalizadas" : "Não Finalizadas"),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      height: height * 0.25,
                      child: PageView(
                        controller: _listTypeController,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          AnnoationsListViewComponent(
                              backgroundColor: primaryColor,
                              itemWidth: width * 0.4,
                              annotations: annotationsListinha),
                          AnnoationsListViewComponent(
                              backgroundColor: primaryColor,
                              itemWidth: width * 0.4,
                              annotations: annotationsListinha),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.12,
            left: width * 0.02,
            child: SizedBox(
              width: width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CashNumberComponent(
                      operatorEntity: widget.operatorEntity,
                      backgroundColor: surfaceColor,
                      radius: 16),
                  Text(
                    "${widget.operatorEntity.operatorName}",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.245,
            left: 2,
            child: Switch(
                activeColor: tertiaryColor,
                value: _doneAnnotations,
                onChanged: (value) {
                  setState(() {
                    _doneAnnotations = !_doneAnnotations;
                    _listTypeController.animateToPage(_doneAnnotations ? 0 : 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
