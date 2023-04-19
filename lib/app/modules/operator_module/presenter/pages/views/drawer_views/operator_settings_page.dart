// ignore_for_file: must_be_immutable

import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/cash_helper_bottom_navigation_item.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/drawer_views/settings_pages/app_apearence_page.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/drawer_views/settings_pages/operator_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../login_module/presenter/stores/login_store.dart';
import '../../../../domain/entities/operator_entity.dart';
import '../../../components/tiles/drawer_tile.dart';
import '../../../components/widgets/cash_helper_drawer.dart';

class OperatorSettingsPage extends StatefulWidget {
  OperatorSettingsPage(
      {super.key,
      required this.operatorEntity,
      this.position = BottomNavigationBarPosition.appAppearance});

  OperatorEntity operatorEntity;
  BottomNavigationBarPosition? position;
  @override
  State<OperatorSettingsPage> createState() => _OperatorSettingsPageState();
}

final _loginController = Modular.get<LoginController>();
final _loginStore = Modular.get<LoginStore>();
DrawerPagePosition? drawerPosition;
final _settingsPageController = PageController();

class _OperatorSettingsPageState extends State<OperatorSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
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
      body: PageView(
        controller: _settingsPageController,
        children: [
          AppAppearencePage(
            position: widget.position,
            controller: _settingsPageController,
          ),
          OperatorAccountPage(
            controller: _settingsPageController,
            operatorEntity: widget.operatorEntity,
            position: widget.position,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: backgroundContainer),
        child: CashHelperBottomNavigationBar(
          itemContentColor: Colors.white,
          pageController: _settingsPageController,
          itemColor: tertiaryColor,
          position: widget.position,
          radius: 20,
          backgroundColor: primaryColor,
          height: 60,
          items: [
            CashHelperBottomNavigationItem(
              icon: Icons.color_lens_outlined,
              itemName: "Aparência",
              itemBackgroundColor: backgroundContainer,
              position: BottomNavigationBarPosition.appAppearance,
              onTap: () {
                _settingsPageController.animateToPage(
                    BottomNavigationBarPosition.appAppearance.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position = BottomNavigationBarPosition.appAppearance;
                });
              },
            ),
            CashHelperBottomNavigationItem(
              icon: Icons.person_search_outlined,
              itemName: "Minha Conta",
              position: BottomNavigationBarPosition.operatorAccount,
              onTap: () {
                _settingsPageController.animateToPage(
                    BottomNavigationBarPosition.operatorAccount.position,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    curve: Curves.easeInSine);
                setState(() {
                  widget.position = BottomNavigationBarPosition.operatorAccount;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
