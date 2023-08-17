// ignore_for_file: unnecessary_string_interpolations, must_be_immutable

import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/get_all_annotations_bloc/get_annotations_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_initial_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_oppening_page.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_options_page.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../components/cash_helper_bottom_navigation_item.dart';

class OperatorArea extends StatefulWidget {
  OperatorArea({super.key, required this.operatorEntity, this.position = BottomNavigationBarPosition.operatorHome});

  final OperatorEntity operatorEntity;
  BottomNavigationBarPosition? position;
  @override
  State<OperatorArea> createState() => _OperatorArea();
}

final _annotationsController = Modular.get<AnnotationsController>();
final _operatorPageController = PageController();

class _OperatorArea extends State<OperatorArea> {
  @override
  void initState() {
    super.initState();
    _annotationsController.enterpriseId = Modular.args.params["enterpriseId"];
    _annotationsController.getAllAnnotations();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Modular.to.navigate("${UserRoutes.operatorHomePage}${_annotationsController.enterpriseId}", arguments: widget.operatorEntity),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: appThemes.backgroundColor(context),
        ),
        child: BlocBuilder<GetAnnotationsBloc, GetAnnotationsStates>(
          bloc: _annotationsController.getAnnotationsBloc,
          builder: (context, state) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _operatorPageController,
              children: [
                if (state is GetAnnotationsLoadingState)
                  Center(
                    child: CircularProgressIndicator(
                      color: appThemes.indicatorColor(context),
                    ),
                  ),
                if (state is GetAnnotationsSuccessState)
                  OperatorInitialPage(
                    operatorEntity: widget.operatorEntity,
                    pageController: _operatorPageController,
                    position: BottomNavigationBarPosition.operatorHome,
                    annotations: state.annotations,
                    enterpriseId: _annotationsController.enterpriseId,
                  ),
                OperatorOptionsPage(
                  position: BottomNavigationBarPosition.operatorOptions,
                  pageController: _operatorPageController,
                  operatorEntity: widget.operatorEntity,
                  enterpriseId: _annotationsController.enterpriseId,
                ),
                OperatorOppeningPage(
                  operatorEntity: widget.operatorEntity,
                  position: BottomNavigationBarPosition.operatorOppening,
                  pageController: _operatorPageController,
                  enterpriseId: _annotationsController.enterpriseId,
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: sizeFrame ? height * 0.07 : height * 0.065,
        decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
        child: CashHelperBottomNavigationBar(
          itemColor: appThemes.greenColor(context),
          itemContentColor: appThemes.surfaceColor(context),
          pageController: _operatorPageController,
          position: widget.position,
          backgroundColor: appThemes.primaryColor(context),
          radius: 20,
          height: sizeFrame ? height * 0.07 : height * 0.065,
          items: [
            CashHelperBottomNavigationItem(
              itemBackgroundColor: appThemes.primaryColor(context),
              onTap: () {
                _operatorPageController.animateToPage(BottomNavigationBarPosition.operatorHome.position,
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
              itemBackgroundColor: appThemes.primaryColor(context),
              contentColor: appThemes.surfaceColor(context),
              onTap: () {
                _operatorPageController.animateToPage(BottomNavigationBarPosition.operatorOptions.position,
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
              itemBackgroundColor: appThemes.primaryColor(context),
              contentColor: appThemes.surfaceColor(context),
              onTap: () {
                _operatorPageController.animateToPage(BottomNavigationBarPosition.operatorOppening.position,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position = BottomNavigationBarPosition.operatorOppening;
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
