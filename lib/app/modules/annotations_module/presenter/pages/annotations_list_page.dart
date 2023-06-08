// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/views/finished_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/views/not_finished_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../routes/app_routes.dart';

class AnnotationsListPage extends StatefulWidget {
  AnnotationsListPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<AnnotationsListPage> createState() => _AnnotationsListPageState();
}

final _annotationsController = Modular.get<AnnotationsController>();
final _annotationsListStore = Modular.get<AnnotationsListStore>();

class _AnnotationsListPageState extends State<AnnotationsListPage> {
  @override
  void initState() {
    super.initState();
    _annotationsController.enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsListStore.getAllAnnotations(
        _annotationsController.enterpriseId, widget.operatorEntity.operatorId!);
    _annotationsController.position =
        BottomNavigationBarPosition.notFinishedAnnotations;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.navigate(
              "${UserRoutes.operatorHomePage}${_annotationsController.enterpriseId}",
              arguments: widget.operatorEntity),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _annotationsListStore,
        builder: (context, _) {
          final annotations = _annotationsListStore.value
              .where((element) => element.annotationConcluied == false)
              .toList();
          final finishedAnnotations = _annotationsListStore.value
              .where((element) => element.annotationConcluied == true)
              .toList();
          if (_annotationsListStore.value.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma Anotação Localizada",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
          }
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _annotationsController.annotationsListPageController,
            children: [
              NotFinishedAnnotations(
                  operatorEntity: widget.operatorEntity,
                  annotations: annotations,
                  position: BottomNavigationBarPosition.notFinishedAnnotations,
                  enterpriseId: _annotationsController.enterpriseId),
              FinishedAnnotations(
                  operatorEntity: widget.operatorEntity,
                  annotations: finishedAnnotations,
                  position: BottomNavigationBarPosition.finishedAnnotations,
                  enterpriseId: _annotationsController.enterpriseId),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: appTheme.backgroundColor(context)),
        child: CashHelperBottomNavigationBar(
          radius: 20,
          backgroundColor: appTheme.primaryColor(context),
          pageController: _annotationsController.annotationsListPageController,
          itemColor: appTheme.greenColor(context),
          height: 60,
          position: _annotationsController.position,
          items: [
            CashHelperBottomNavigationItem(
              onTap: () {
                _annotationsController.annotationsListPageController
                    .animateToPage(
                        BottomNavigationBarPosition
                            .notFinishedAnnotations.position,
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.notFinishedAnnotations;
                });
              },
              position: BottomNavigationBarPosition.notFinishedAnnotations,
              icon: Icons.library_books_outlined,
              contentColor: appTheme.surfaceColor(context),
              itemName: "Não Finalizadas",
              itemBackgroundColor: appTheme.primaryColor(context),
            ),
            CashHelperBottomNavigationItem(
              onTap: () {
                _annotationsController.annotationsListPageController
                    .animateToPage(
                        BottomNavigationBarPosition
                            .finishedAnnotations.position,
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position =
                      BottomNavigationBarPosition.finishedAnnotations;
                });
              },
              position: BottomNavigationBarPosition.finishedAnnotations,
              icon: Icons.download_done_rounded,
              contentColor: appTheme.surfaceColor(context),
              itemName: "Finalizadas",
              itemBackgroundColor: appTheme.primaryColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
