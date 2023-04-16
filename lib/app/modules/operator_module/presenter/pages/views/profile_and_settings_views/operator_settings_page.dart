import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../login_module/presenter/stores/login_store.dart';
import '../../../../domain/entities/operator_entity.dart';
import '../../../components/tiles/drawer_tile.dart';
import '../../../components/widgets/cash_helper_drawer.dart';

class OperatorSettingsPage extends StatefulWidget {
  OperatorSettingsPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<OperatorSettingsPage> createState() => _OperatorSettingsPageState();
}

final _loginController = Modular.get<LoginController>();
final _loginStore = Modular.get<LoginStore>();
DrawerPagePosition? drawerPosition;

class _OperatorSettingsPageState extends State<OperatorSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    _loginController.drawerPosition = DrawerPagePosition.settings;
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
              Modular.to.navigate("./",arguments: widget.operatorEntity);
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
              Modular.to.pushReplacementNamed("./operator-profile",
                  arguments: widget.operatorEntity);
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
        child: Center(
          child: Text("Configurações"),
        ),
      ),
    );
  }
}
