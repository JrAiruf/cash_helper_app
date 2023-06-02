// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/annotation_home.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../user_module/domain/entities/operator_entity.dart';

class AnnotationPage extends StatefulWidget {
  AnnotationPage({Key? key}) : super(key: key);

  @override
  State<AnnotationPage> createState() => _AnnotationPageState();
}

AnnotationEntity? annotationEntity;
OperatorEntity? operatorEntity;
final _annotationsController = Modular.get<AnnotationsController>();

class _AnnotationPageState extends State<AnnotationPage> {
  @override
  void initState() {
    annotationEntity = Modular.args.data["annotationEntity"];
    operatorEntity = Modular.args.data["operatorEntity"];
    super.initState();
    _annotationsController.position = BottomNavigationBarPosition.appAppearance;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final greenColor = Theme.of(context).colorScheme.tertiaryContainer;
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _annotationsController.annotationsPageController,
        children: [
          AnnotationHome(annotationEntity: annotationEntity!),
          Container(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: CashHelperBottomNavigationBar(
          itemContentColor: surfaceColor,
          pageController: _annotationsController.annotationsPageController,
          itemColor: greenColor,
          position: _annotationsController.position,
          radius: 20,
          backgroundColor: primaryColor,
          height: 60,
          items: [
            CashHelperBottomNavigationItem(
              icon: Icons.home,
              itemName: "Início",
              itemBackgroundColor: backgroundColor,
              position: BottomNavigationBarPosition.appAppearance,
              onTap: () {
                _annotationsController.annotationsPageController.animateToPage(
                    BottomNavigationBarPosition.annotationHome.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.appAppearance;
                });
              },
            ),
            CashHelperBottomNavigationItem(
              icon: Icons.settings,
              itemName: "Opções",
              position: BottomNavigationBarPosition.operatorAccount,
              onTap: () {
                _annotationsController.annotationsPageController.animateToPage(
                    BottomNavigationBarPosition.annotationSettings.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.operatorAccount;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
