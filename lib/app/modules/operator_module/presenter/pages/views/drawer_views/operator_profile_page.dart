import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../login_module/presenter/controllers/login_controller.dart';
import '../../../../../login_module/presenter/stores/login_store.dart';
import '../../../components/tiles/drawer_tile.dart';
import '../../../components/tiles/operator_profile_component.dart';
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

class _OperatorProfilePageState extends State<OperatorProfilePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    : Colors.white,
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
                    : Colors.white,
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
                    : Colors.white,
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
            child: Text("Sair", style: Theme.of(context).textTheme.titleMedium),
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
                height: height * 0.75,
                decoration: BoxDecoration(
                  color: backgroundContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.11,
              left: width * 0.36,
              child: Text(
                widget.operatorEntity.operatorName ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Positioned(
              top: height * 0.09,
              left: width * 0.05,
              child: const Icon(
                Icons.person,
                size: 85,
              ),
            ),
            Positioned(
              top: height * 0.25,
              left: width * 0.01,
              child: Container(
                height: height * 0.5,
                width: width * 0.98,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OperatorProfileComponent(
                        height: height,
                        title: "E-mail:",
                        backgroundColor: backgroundContainer,
                        content: widget.operatorEntity.operatorEmail,
                      ),
                      SizedBox(height: height * 0.03),
                      OperatorProfileComponent(
                        height: height,
                        title: "Número do caixa:",
                        backgroundColor: backgroundContainer,
                        content: "${widget.operatorEntity.operatorNumber}",
                      ),
                      SizedBox(height: height * 0.03),
                      OperatorProfileComponent(
                        height: height,
                        title: "Anotações nesta semana:",
                        backgroundColor: backgroundContainer,
                        content: "7",
                      ),
                      SizedBox(height: height * 0.03),
                      OperatorProfileComponent(
                        height: height,
                        title: "Ocupação:",
                        backgroundColor: backgroundContainer,
                        content: widget.operatorEntity.operatorOcupation ==
                                "operator"
                            ? "Operador"
                            : "ADM",
                      ),
                      SizedBox(height: height * 0.03),
                      OperatorProfileComponent(
                        height: height,
                        title: "Abertura:",
                        backgroundColor: backgroundContainer,
                        content: widget.operatorEntity.operatorOppening,
                      ),
                      SizedBox(height: height * 0.03),
                      OperatorProfileComponent(
                        height: height,
                        title: "Código Ops.:",
                        backgroundColor: backgroundContainer,
                        content: widget.operatorEntity.operatorCode,
                      ),
                    ],
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
