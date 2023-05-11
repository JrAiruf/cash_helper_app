import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../login_module/presenter/controllers/login_controller.dart';
import '../tiles/drawer_tile.dart';

class CashHelperDrawer extends StatelessWidget {
  const CashHelperDrawer({
    super.key,
    this.backgroundColor,
    this.height,
    this.radius,
    this.width,
    required this.pagePosition,
    required this.operator,
  });
  final Color? backgroundColor;
  final double? height;
  final double? radius;
  final double? width;
  final DrawerPagePosition? pagePosition;
  final OperatorEntity? operator;
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
              const SizedBox(
                height: 80,
              ),
              Text("Opções", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 160,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerTile(
                    width: width,
                    title: "Início",
                    icon: Icons.home,
                    itemColor: pagePosition == DrawerPagePosition.home
                        ? tertiaryColor
                        : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.navigate("./", arguments: operator);
                    },
                  ),
                  SizedBox(height: height * 0.06),
                  DrawerTile(
                    width: width,
                    title: "Meu Perfil",
                    icon: Icons.person,
                    itemColor: pagePosition == DrawerPagePosition.profile
                        ? tertiaryColor
                        : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.pushReplacementNamed("./operator-settings",
                          arguments: operator);
                    },
                  ),
                  SizedBox(height: height * 0.06),
                  DrawerTile(
                    width: width,
                    title: "Configurações",
                    icon: Icons.settings,
                    itemColor: pagePosition == DrawerPagePosition.settings
                        ? tertiaryColor
                        : surfaceColor,
                    onTap: () {
                      Modular.to.pop();
                      Modular.to.pushReplacementNamed("./operator-settings",
                          arguments: operator);
                    },
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
