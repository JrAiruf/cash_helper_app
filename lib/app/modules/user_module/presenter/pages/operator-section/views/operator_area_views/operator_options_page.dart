// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/options_page_menu_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_close_page.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import "package:flutter/material.dart";
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../components/operator_widgets/cash_number_component.dart';

class OperatorOptionsPage extends StatefulWidget {
  const OperatorOptionsPage({super.key, required this.operatorEntity, required this.enterpriseId, this.position, required this.pageController});
  final OperatorEntity operatorEntity;
  final String enterpriseId;
  final BottomNavigationBarPosition? position;
  final PageController? pageController;
  @override
  State<OperatorOptionsPage> createState() => _OperatorOptionsPageState();
}

class _OperatorOptionsPageState extends State<OperatorOptionsPage> {
  final _operatorController = Modular.get<OperatorController>();
  final _annotationsListStore = Modular.get<AnnotationsListStore>();
  @override
  void initState() {
    super.initState();
    operatorController.operatorEntity = widget.operatorEntity;
    operatorController.enterpriseId = widget.enterpriseId;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return Container(
      height: height,
      width: width,
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
          ),
          SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionsPageMenuComponent(
                      elevation: 10,
                      itemName: "Listar Anotações",
                      radius: 15,
                      borderColor: appThemes.surfaceColor(context),
                      itemColor: appThemes.primaryColor(context),
                      icon: Icons.view_list_outlined,
                      height: height * 0.11,
                      width: width * 0.4,
                      onTap: () {
                        _annotationsListStore.value.isEmpty
                            ? _operatorController.noAnnotationSnackbar(context)
                            : Modular.to.pushNamed("${AnnotationRoutes.annotationsListPage}${operatorController.enterpriseId}", arguments: operatorController.operatorEntity);
                      },
                    ),
                    OptionsPageMenuComponent(
                      elevation: 10,
                      itemName: "Pesquisar",
                      radius: 15,
                      borderColor: appThemes.surfaceColor(context),
                      itemColor: appThemes.primaryColor(context),
                      icon: Icons.search,
                      height: height * 0.11,
                      width: width * 0.4,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OptionsPageMenuComponent(
                      elevation: 10,
                      itemName: "Criar Anotação",
                      radius: 15,
                      borderColor: appThemes.surfaceColor(context),
                      itemColor: appThemes.primaryColor(context),
                      icon: Icons.library_books_outlined,
                      height: height * 0.11,
                      width: width * 0.4,
                      onTap: () {
                        operatorController.operatorEntity!.operatorEnabled!
                            ? Modular.to.pushNamed("${AnnotationRoutes.createAnnotationPage}${operatorController.enterpriseId}", arguments: operatorController.operatorEntity)
                            : operatorController.operatorDisabledSnackbar(context);
                      },
                    ),
                    OptionsPageMenuComponent(
                      elevation: 10,
                      itemName: "Fechar caixa",
                      radius: 15,
                      borderColor: appThemes.surfaceColor(context),
                      itemColor: appThemes.primaryColor(context),
                      icon: Icons.power_settings_new_outlined,
                      height: height * 0.11,
                      width: width * 0.4,
                      onTap: () {
                        operatorController.operatorEntity!.operatorEnabled!
                            ? Modular.to.navigate("${UserRoutes.operatorClosePage}${operatorController.enterpriseId}", arguments: operatorController.operatorEntity)
                            : operatorController.operatorDisabledSnackbar(context);
                        ;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: sizeFrame ? height * 0.11 : height * 0.12,
            left: width * 0.02,
            child: SizedBox(
              width: width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CashNumberComponent(operatorEntity: operatorController.operatorEntity!,
                   backgroundColor: appThemes.surfaceColor(context), radius: 16),
                  Text(
                    "${widget.operatorEntity.operatorName}",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
