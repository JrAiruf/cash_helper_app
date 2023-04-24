// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cards/annotations_status_card_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../login_module/presenter/controllers/login_controller.dart';
import '../../../../../login_module/presenter/stores/login_store.dart';
import '../../../components/cards/operator_card_component.dart';
import '../../../components/cards/profile_informations_card.dart';
import '../../../components/tiles/drawer_tile.dart';
import '../../../components/widgets/cash_helper_drawer.dart';

class OperatorProfilePage extends StatefulWidget {
  OperatorProfilePage({
    super.key,
    required this.operatorEntity,
  });

  OperatorEntity operatorEntity;
  @override
  State<OperatorProfilePage> createState() => _OperatorProfilePageState();
}

final _loginController = Modular.get<LoginController>();
final _loginStore = Modular.get<LoginStore>();
DrawerPagePosition? drawerPosition;
bool showOperatorCode = false;

class _OperatorProfilePageState extends State<OperatorProfilePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final fontSize = Theme.of(context).textTheme.bodySmall;
    _loginController.drawerPosition = DrawerPagePosition.profile;
    return Scaffold(
      appBar: AppBar(),
      drawer: CashHelperDrawer(
        height: height,
        width: width,
        drawerTitle: "Opções",
        backgroundColor: primaryColor,
        drawerItems: [
          DrawerTile(
            width: width,
            title: "Início",
            icon: Icons.home,
            itemColor:
                _loginController.drawerPosition == DrawerPagePosition.home
                    ? tertiaryColor
                    : surfaceColor,
            onTap: () {
              Modular.to.pop();
              Modular.to.navigate("./", arguments: widget.operatorEntity);
            },
          ),
          SizedBox(height: height * 0.06),
          DrawerTile(
            width: width,
            title: "Meu Perfil",
            icon: Icons.person,
            itemColor:
                _loginController.drawerPosition == DrawerPagePosition.profile
                    ? tertiaryColor
                    : surfaceColor,
            onTap: () {
              Modular.to.pop();
            },
          ),
          SizedBox(height: height * 0.06),
          DrawerTile(
            width: width,
            title: "Configurações",
            icon: Icons.settings,
            itemColor:
                _loginController.drawerPosition == DrawerPagePosition.settings
                    ? tertiaryColor
                    : surfaceColor,
            onTap: () {
              Modular.to.pop();
              Modular.to.pushReplacementNamed("./operator-settings",
                  arguments: widget.operatorEntity);
            },
          ),
          SizedBox(height: height * 0.3),
          GestureDetector(
            onTap: () {
              _loginController.showSignOutDialog(
                context,
                primaryColor,
                () {
                  _loginStore.signOut();
                  Modular.to.pop();
                  Modular.to.navigate("/");
                },
              );
            },
            child: Text("Sair",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: surfaceColor)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: primaryColor),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.82,
                decoration: BoxDecoration(
                  color: backgroundContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.04,
              left: width * 0.36,
              child: Text(
                widget.operatorEntity.operatorName ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Positioned(
              top: height * 0.02,
              left: width * 0.05,
              child: const Icon(
                Icons.person,
                size: 85,
              ),
            ),
            Positioned(
              top: height * 0.2,
              left: width * 0.01,
              child: SizedBox(
                height: height * 0.55,
                width: width * 0.98,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        OperatorCardComponent(
                            height: height * 0.15,
                            width: width,
                            backgroundColor: secondaryColor,
                            operatorEntity: widget.operatorEntity),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProfileInformationCard(
                                    backgroundColor: secondaryColor,
                                    height: height * 0.165,
                                    width: width * 0.35,
                                    items: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: onSurfaceColor,
                                      ),
                                      Text("Abertura:", style: fontSize),
                                      Text(
                                        widget.operatorEntity
                                                .operatorOppening ??
                                            "",
                                        style: fontSize,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ProfileInformationCard(
                                    height: height * 0.165,
                                    width: width * 0.35,
                                    backgroundColor: secondaryColor,
                                    items: [
                                      Text("Código Ops.", style: fontSize),
                                      Text(
                                        showOperatorCode
                                            ? widget.operatorEntity
                                                    .operatorCode ??
                                                ""
                                            : "......",
                                        style: fontSize,
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          setState(() {
                                            showOperatorCode =
                                                !showOperatorCode;
                                          });
                                        }),
                                        child: Icon(
                                          showOperatorCode
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: onSurfaceColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              AnnotationsStatusCardComponent(
                                height: height * 0.34,
                                width: width * 0.54,
                                backgroundColor: secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
