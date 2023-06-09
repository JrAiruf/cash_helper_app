// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_initial_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_oppening_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_options_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final annotations = _annotationListStore.value;
    return Scaffold(
      appBar: AppBar(),
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
                operatorEntity: OperatorEntity(),
                position: BottomNavigationBarPosition.operatorOppening,
                pageController: _operatorPageController)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: CashHelperBottomNavigationBar(
          itemColor: tertiaryColor,
          itemContentColor: surfaceColor,
          pageController: _operatorPageController,
          position: widget.position,
          backgroundColor: primaryColor,
          radius: 20,
          height: height * 0.08,
          items: [
            CashHelperBottomNavigationItem(
              itemBackgroundColor: primaryColor,
              onTap: () {
                _operatorPageController.animateToPage(
                    BottomNavigationBarPosition.operatorHome.position,
                    duration: const Duration(
                      milliseconds: 400,
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
                      milliseconds: 400,
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
                      milliseconds: 400,
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
