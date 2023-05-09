// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/tiles/drawer_tile.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controller/manager_controller.dart';

class ManagerSectionDrawer extends StatelessWidget {
  ManagerSectionDrawer(
      {super.key,
      this.radius,
      this.width,
      this.enterpriseId,
      required this.currentPage,
      required this.managerEntity});

  double? radius;
  double? width;
  ManagerDrawerPage currentPage;
  ManagerEntity managerEntity;
  String? enterpriseId;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final tertiaryColor = Theme.of(context).colorScheme.surfaceVariant;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? 5),
        bottomRight: Radius.circular(radius ?? 5),
      ),
      child: Drawer(
        backgroundColor: primaryColor,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text("Opções", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 160),
              DrawerTile(
                  currentPage: ManagerDrawerPage.home,
                  itemColor: currentPage == ManagerDrawerPage.home
                      ? tertiaryColor
                      : Colors.white,
                  icon: Icons.home,
                  title: "Início",
                  width: width,
                  onTap: () {
                    Modular.to.pop();
                    Modular.to.navigate("${UserRoutes.managerHomePage}$enterpriseId",
                        arguments: managerEntity);
                  }),
              DrawerTile(
                  currentPage: ManagerDrawerPage.management,
                  itemColor: currentPage == ManagerDrawerPage.management
                      ? tertiaryColor
                      : Colors.white,
                  icon: Icons.home,
                  title: "Gerenciamento",
                  width: width,
                  onTap: () {
                    Modular.to.pop();
                    print("Hello World");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
