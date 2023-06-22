// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/annotation_page.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/options_page_menu_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
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
                            : Modular.to.pushNamed("${AnnotationRoutes.annotationsListPage}${widget.enterpriseId}", arguments: widget.operatorEntity);
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
                      onTap: () => Modular.to.pushNamed("${AnnotationRoutes.createAnnotationPage}${widget.enterpriseId}", arguments: widget.operatorEntity),
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
                      onTap: () => Modular.to.navigate(
                        "${UserRoutes.operatorClosePage}${widget.enterpriseId}",
                        arguments: widget.operatorEntity,
                      ),
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
                  CashNumberComponent(operatorEntity: widget.operatorEntity, backgroundColor: appThemes.surfaceColor(context), radius: 16),
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


/* 
Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.28,
            width: width,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.03),
                const Icon(Icons.person, size: 85),
                SizedBox(height: height * 0.01),
                Text('Júnior Oliveira',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: surfaceColor)),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.adf_scanner_outlined),
                    SizedBox(width: width * 0.05),
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: surfaceColor,
                        child: Text(
                          "2",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: height * 0.04),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionsPageMenuComponent(
                    elevation: 10,
                    itemName: "Listar Anotações",
                    radius: 15,
                    borderColor: surfaceColor,
                    itemColor: primaryColor,
                    icon: Icons.view_list_outlined,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                  OptionsPageMenuComponent(
                    elevation: 10,
                    itemName: "Pesquisar",
                    radius: 15,
                    borderColor: surfaceColor,
                    itemColor: primaryColor,
                    icon: Icons.search,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionsPageMenuComponent(
                    onTap: () => Modular.to.navigate("/annotations-module/${widget.operatorEntity.operatorId}"),
                    elevation: 10,
                    itemName: "Criar Anotação",
                    radius: 15,
                    borderColor: surfaceColor,
                    itemColor: primaryColor,
                    icon: Icons.note_add_outlined,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                  OptionsPageMenuComponent(
                    elevation: 10,
                    itemName: "Fechar Caixa",
                    radius: 15,
                    borderColor: surfaceColor,
                    itemColor: primaryColor,
                    icon: Icons.power_settings_new_sharp,
                    height: height * 0.18,
                    width: width * 0.38,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
 */