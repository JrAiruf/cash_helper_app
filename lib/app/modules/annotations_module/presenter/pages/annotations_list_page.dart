// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/get_all_annotations_bloc/get_annotations_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/views/finished_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/views/not_finished_annotations.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _AnnotationsListPageState extends State<AnnotationsListPage> {
  final annotationsList = <AnnotationEntity>[];
  @override
  void initState() {
    super.initState();
    _annotationsController.enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsController.getAllAnnotations();
    _annotationsController.position = BottomNavigationBarPosition.notFinishedAnnotations;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.navigate("${UserRoutes.operatorHomePage}${_annotationsController.enterpriseId}", arguments: widget.operatorEntity),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: appTheme.primaryColor(context),
        ),
        child: BlocBuilder(
          bloc: _annotationsController.getAnnotationsBloc,
          builder: (_, state) {
            if (state is GetAnnotationsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: appTheme.indicatorColor(context),
                ),
              );
            }
            if (state is GetAnnotationsFailureState) {
              return Center(
                child: Text(
                  state.error,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            }
            if (state is GetAnnotationsSuccessState) {
              final annotations = state.annotations.where((annotation) => annotation.annotationCreatorId == widget.operatorEntity.operatorId && annotation.annotationConcluied == false).toList();
              final finishedAnnotations =
                  state.annotations.where((annotation) => annotation.annotationCreatorId == widget.operatorEntity.operatorId && annotation.annotationConcluied == true).toList();
              annotationsList.clear();
              annotationsList.addAll(annotations);
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _annotationsController.annotationsListPageController,
                children: [
                  NotFinishedAnnotations(
                      operatorEntity: widget.operatorEntity,
                      annotations: annotations,
                      controller: _annotationsController.annotationsListPageController,
                      position: BottomNavigationBarPosition.notFinishedAnnotations,
                      enterpriseId: _annotationsController.enterpriseId),
                  FinishedAnnotations(
                      operatorEntity: widget.operatorEntity,
                      annotations: finishedAnnotations,
                      controller: _annotationsController.annotationsListPageController,
                      position: BottomNavigationBarPosition.finishedAnnotations,
                      enterpriseId: _annotationsController.enterpriseId),
                ],
              );
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: sizeFrame ? height * 0.07 : height * 0.065,
        decoration: BoxDecoration(color: annotationsList.isNotEmpty ? appTheme.backgroundColor(context) : appTheme.primaryColor(context)),
        child: CashHelperBottomNavigationBar(
          radius: 20,
          backgroundColor: appTheme.primaryColor(context),
          pageController: _annotationsController.annotationsListPageController,
          itemColor: appTheme.greenColor(context),
          height: sizeFrame ? height * 0.07 : height * 0.065,
          position: _annotationsController.position,
          items: [
            CashHelperBottomNavigationItem(
              onTap: () {
                _annotationsController.annotationsListPageController.animateToPage(BottomNavigationBarPosition.notFinishedAnnotations.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position = BottomNavigationBarPosition.notFinishedAnnotations;
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
                _annotationsController.annotationsListPageController.animateToPage(BottomNavigationBarPosition.finishedAnnotations.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  _annotationsController.position = BottomNavigationBarPosition.finishedAnnotations;
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
