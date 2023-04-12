// ignore_for_file: unnecessary_string_interpolations

import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/operator_initial_page.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/operator_oppening_page.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/operator_options_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../login_module/presenter/stores/login_states.dart';
import '../../../login_module/presenter/stores/login_store.dart';
import '../components/cash_helper_bottom_navigation_item.dart';

class OperatorArea extends StatefulWidget {
  OperatorArea({super.key, required this.operatorId, this.position});

  final String operatorId;
  BottomNavigationBarPosition? position;
  @override
  State<OperatorArea> createState() => _OperatorArea();
}

final _loginStore = Modular.get<LoginStore>();
final _operatorPageController = PageController();

class _OperatorArea extends State<OperatorArea> {
  @override
  void initState() {
    widget.position = BottomNavigationBarPosition.operatorHome;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final tertiaryColor = Theme.of(context).colorScheme.onTertiaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, operatorState, __) {
        if (operatorState is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: CircularProgressIndicator(
                color: indicatorColor,
              ),
            ),
          );
        }
        if (operatorState is LoginSuccessState) {
          final currentOperator = operatorState.operatorEntity;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: Colors.white,
                onPressed: () {
                  Modular.to.navigate("/operator-module/",
                      arguments: currentOperator);
                },
                icon: const Icon(Icons.arrow_back),
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
                    operatorId: currentOperator.operatorId!,
                    pageController: _operatorPageController,
                    position: BottomNavigationBarPosition.operatorHome,
                  ),
                  OperatorOptionsPage(
                    position: BottomNavigationBarPosition.operatorOptions,
                    pageController: _operatorPageController,
                    operatorId: '',
                  ),
                  OperatorOppeningPage(
                      operatorEntity: OperatorEntity(),
                      position: BottomNavigationBarPosition.operatorOppening,
                      pageController: _operatorPageController)
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: primaryColor),
              child: CashHelperBottomNavigationBar(
                itemColor: tertiaryColor,
                itemContentColor: Colors.white,
                pageController: _operatorPageController,
                position: widget.position,
                backgroundColor: seccondaryColor,
                radius: 20,
                height: 55,
                items: [
                  CashHelperBottomNavigationItem(
                    itemBackgroundColor: Colors.blueAccent,
                    onTap: () {
                      _operatorPageController.animateToPage(
                          BottomNavigationBarPosition.operatorHome.position,
                          duration: const Duration(
                            milliseconds: 400,
                          ),
                          curve: Curves.easeInSine);
                      setState(() {
                        widget.position =
                            BottomNavigationBarPosition.operatorHome;
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
                        widget.position =
                            BottomNavigationBarPosition.operatorOptions;
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
        } else {
          return Container();
        }
      },
    );
  }
}
