// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/annotation_home.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_item.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../user_module/domain/entities/operator_entity.dart';
import 'annotation_settings.dart';

class AnnotationPage extends StatefulWidget {
  AnnotationPage({Key? key}) : super(key: key);

  @override
  State<AnnotationPage> createState() => _AnnotationPageState();
}

AnnotationEntity? annotationEntity;
OperatorEntity? operatorEntity;
String? enterpriseId;
final _annotationsController = Modular.get<AnnotationsController>();

class _AnnotationPageState extends State<AnnotationPage> {
  @override
  void initState() {
    annotationEntity = Modular.args.data["annotationEntity"];
    operatorEntity = Modular.args.data["operatorEntity"];
    enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsController.getAllAnnotations();
    super.initState();
    _annotationsController.position = BottomNavigationBarPosition.appAppearance;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _annotationsController.annotationsPageController,
        children: [
          AnnotationHome(
            annotationEntity: annotationEntity!,
          ),
          AnnotationSettings(
            annotationEntity: annotationEntity!,
            operatorEntity: operatorEntity!,
            enterpriseId: enterpriseId!,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: appTheme.backgroundColor(context),
        ),
        child: CashHelperBottomNavigationBar(
          width: width,
          itemContentColor: appTheme.surfaceColor(context),
          pageController: _annotationsController.annotationsPageController,
          itemColor: appTheme.greenColor(context),
          position: _annotationsController.position,
          radius: 20,
          backgroundColor: appTheme.primaryColor(context),
          height: 60,
          items: [
            CashHelperBottomNavigationItem(
              icon: Icons.home,
              itemName: "Início",
              itemBackgroundColor: appTheme.backgroundColor(context),
              position: BottomNavigationBarPosition.annotationHome,
              onTap: () {
                _annotationsController.annotationsPageController.animateToPage(
                    BottomNavigationBarPosition.annotationHome.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.annotationHome;
                });
              },
            ),
            CashHelperBottomNavigationItem(
              icon: Icons.settings,
              itemName: "Opções",
              position: BottomNavigationBarPosition.annotationSettings,
              onTap: () {
                _annotationsController.annotationsPageController.animateToPage(
                    BottomNavigationBarPosition.annotationSettings.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.annotationSettings;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
