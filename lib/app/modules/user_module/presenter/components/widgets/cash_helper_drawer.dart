import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../login_module/presenter/controllers/login_controller.dart';
import '../tiles/drawer_tile.dart';

class CashHelperDrawer extends StatelessWidget {
  CashHelperDrawer({
    super.key,
    this.backgroundColor,
    this.height,
    this.radius,
    this.width,
    this.enterpriseId,
    required this.pagePosition,
    required this.operator,
  });
  final Color? backgroundColor;
  final double? height;
  final double? radius;
  final double? width;
  final String? enterpriseId;
  final DrawerPagePosition? pagePosition;
  final OperatorEntity? operator;
  final loginController = Modular.get<LoginController>();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final height = MediaQuery.of(context).size.height;
    final itemSpacingHeight = height * 0.02;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? 5),
        bottomRight: Radius.circular(radius ?? 5),
      ),
      child: Drawer(
        width: width,
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              Text("Opções", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: height * 0.17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerTile(
                    width: width,
                    title: "Início",
                    icon: Icons.home,
                    itemColor: pagePosition == DrawerPagePosition.home ? tertiaryColor : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId", arguments: operator);
                    },
                  ),
                  SizedBox(height: itemSpacingHeight),
                  DrawerTile(
                    width: width,
                    title: "Meu Perfil",
                    icon: Icons.person,
                    itemColor: pagePosition == DrawerPagePosition.profile ? tertiaryColor : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.navigate("${UserRoutes.operatorProfilePage}$enterpriseId", arguments: operator);
                    },
                  ),
                  SizedBox(height: itemSpacingHeight),
                  DrawerTile(
                    width: width,
                    title: "Configurações",
                    icon: Icons.settings,
                    itemColor: pagePosition == DrawerPagePosition.settings ? tertiaryColor : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.navigate("${UserRoutes.operatorSettingsPage}$enterpriseId", arguments: operator);
                    },
                  ),
                  SizedBox(height: itemSpacingHeight * 10),
                  TextButton(
                    onPressed:loginController.managerSignOut,
                    child: Row(
                      children: [
                        Text(
                          "Sair",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: surfaceColor,
                              ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: surfaceColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
