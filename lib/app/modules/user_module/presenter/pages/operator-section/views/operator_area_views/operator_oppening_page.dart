// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/modules/user_module/presenter/components/tiles/operator_infortmations_tile.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import '../../../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../../../login_module/presenter/components/cash_helper_text_field.dart';
import '../../../../../domain/entities/operator_entity.dart';
import '../../../../components/cash_helper_bottom_navigation_bar.dart';

class OperatorOppeningPage extends StatefulWidget {
  const OperatorOppeningPage(
      {super.key,
      required this.operatorEntity,
      required this.position,
      required this.pageController});

  final OperatorEntity operatorEntity;
  final BottomNavigationBarPosition position;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _OperatorOppeningPageState();
}

class _OperatorOppeningPageState extends State<OperatorOppeningPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final operatorPageController = PageController();
    final appThemes = CashHelperThemes();
    String oppeningTime = widget.operatorEntity.operatorOppening == "Pendente"
        ? "Pendente"
        : widget.operatorEntity.operatorOppening ?? "";
    String operatorStatus =
        widget.operatorEntity.operatorEnabled! ? "Ativo" : "Inativo";
    return Container(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.person,
                    size: 55,
                  ),
                  Text(
                    widget.operatorEntity.operatorName ?? "",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: sizeFrame ? height * 0.23 : height * 0.22,
            child: SizedBox(
              height: height * 0.65,
              width: width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: sizeFrame ? height * 0.1 : height * 0.09,
                        decoration: BoxDecoration(
                          color: appThemes.primaryColor(context),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OperatorInformationsTile(
                                content: operatorStatus,
                                icon: Icons.beenhere,
                              ),
                              OperatorInformationsTile(
                                content: oppeningTime,
                                icon: Icons.access_time,
                              ),
                              OperatorInformationsTile(
                                content:
                                    "${widget.operatorEntity.operatorNumber}",
                                icon: Icons.monitor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: sizeFrame ? height * 0.09 : height * 0.08),
                      Form(
                        /* key: _loginController.loginFormKey, */
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CashHelperTextFieldComponent(
                                primaryColor: appThemes.surfaceColor(context),
                                radius: 15,
                                /*  validator: (value) =>
                                    _loginController.emailValidate(value), */
                                /*  onSaved: (value) => _loginController
                                    .emailField.text = value ?? "",
                                controller: _loginController.emailField, */
                                label: 'Código Ops.',
                              ),
                              SizedBox(
                                  height: sizeFrame
                                      ? height * 0.05
                                      : height * 0.04),
                            ],
                          ),
                        ),
                      ),
                      CashHelperElevatedButton(
                        onPressed: () {},
                        border: true,
                        radius: 12,
                        width: width * 0.7,
                        height: 50,
                        buttonName: 'Abrir Caixa',
                        fontSize: 15,
                        nameColor: appThemes.surfaceColor(context),
                        backgroundColor: appThemes.greenColor(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
