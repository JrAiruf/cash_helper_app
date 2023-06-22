// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_initial_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_oppening_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_options_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../annotations_module/presenter/stores/annotations_list_store.dart';
import '../../components/cash_helper_bottom_navigation_item.dart';

class OperatorArea extends StatefulWidget {
  OperatorArea(
      {super.key,
      required this.operatorEntity,
      this.position = BottomNavigationBarPosition.operatorHome});

  final OperatorEntity operatorEntity;
  BottomNavigationBarPosition? position;
  @override
  State<OperatorArea> createState() => _OperatorArea();
}

final _annotationListStore = Modular.get<AnnotationsListStore>();
final _enterpriseId = Modular.args.params["enterpriseId"];
final _operatorPageController = PageController();

class _OperatorArea extends State<OperatorArea> {
  @override
  void initState() {
    super.initState();
    _annotationListStore.getAllAnnotations(
        _enterpriseId, widget.operatorEntity.operatorId!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final annotations = _annotationListStore.value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Modular.to.navigate(
              "${UserRoutes.operatorHomePage}$_enterpriseId",
              arguments: widget.operatorEntity),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: seccondaryColor,
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _operatorPageController,
          children: [
            OperatorInitialPage(
              operatorEntity: widget.operatorEntity,
              pageController: _operatorPageController,
              position: BottomNavigationBarPosition.operatorHome,
              annotations: annotations,
              enterpriseId: _enterpriseId,
            ),
            OperatorOptionsPage(
              position: BottomNavigationBarPosition.operatorOptions,
              pageController: _operatorPageController,
              operatorEntity: widget.operatorEntity,
              enterpriseId: _enterpriseId,
            ),
            OperatorOppeningPage(
              operatorEntity: widget.operatorEntity,
              position: BottomNavigationBarPosition.operatorOppening,
              pageController: _operatorPageController,
              enterpriseId: _enterpriseId,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: sizeFrame ? height * 0.07 : height * 0.065,
        decoration: BoxDecoration(color: backgroundColor),
        child: CashHelperBottomNavigationBar(
          itemColor: tertiaryColor,
          itemContentColor: surfaceColor,
          pageController: _operatorPageController,
          position: widget.position,
          backgroundColor: primaryColor,
          radius: 20,
          height: sizeFrame ? height * 0.07 : height * 0.065,
          items: [
            CashHelperBottomNavigationItem(
              itemBackgroundColor: primaryColor,
              onTap: () {
                _operatorPageController.animateToPage(
                    BottomNavigationBarPosition.operatorHome.position,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position = BottomNavigationBarPosition.operatorHome;
                });
              },
              icon: Icons.person,
              itemName: 'Início',
              position: BottomNavigationBarPosition.operatorHome,
            ),
            CashHelperBottomNavigationItem(
              itemBackgroundColor: primaryColor,
              contentColor: seccondaryColor,
              onTap: () {
                _operatorPageController.animateToPage(
                    BottomNavigationBarPosition.operatorOptions.position,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position = BottomNavigationBarPosition.operatorOptions;
                });
              },
              icon: Icons.menu,
              itemName: 'Opções',
              position: BottomNavigationBarPosition.operatorOptions,
            ),
            CashHelperBottomNavigationItem(
              itemBackgroundColor: primaryColor,
              contentColor: seccondaryColor,
              onTap: () {
                _operatorPageController.animateToPage(
                    BottomNavigationBarPosition.operatorOppening.position,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position =
                      BottomNavigationBarPosition.operatorOppening;
                });
              },
              icon: Icons.adf_scanner_outlined,
              itemName: 'Abertura',
              position: BottomNavigationBarPosition.operatorOppening,
            ),
          ],
        ),
      ),
    );
  }
}
