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
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final height = MediaQuery.of(context).size.height;
    final itemSpacingHeight = height * 0.02;
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
              const SizedBox(
                height: 80,
              ),
              Text("Opções", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 160,
              ),
              DrawerTile(
                currentPage: ManagerDrawerPage.home,
                itemColor: currentPage == ManagerDrawerPage.home
                    ? variantColor
                    : surfaceColor,
                icon: Icons.home,
                title: "Início",
                width: width,
                onTap: () {
                  Modular.to.pop();
                  Modular.to.navigate(
                    "${UserRoutes.managerHomePage}$enterpriseId",
                    arguments: managerEntity,
                  );
                },
              ),
              SizedBox(
                height: itemSpacingHeight,
              ),
              DrawerTile(
                currentPage: ManagerDrawerPage.management,
                itemColor: currentPage == ManagerDrawerPage.management
                    ? variantColor
                    : surfaceColor,
                icon: Icons.manage_accounts,
                title: "Gerenciamento",
                width: width,
                onTap: () {
                  Modular.to.pop();
                  Modular.to.navigate(
                    "${UserRoutes.managementPage}$enterpriseId",
                    arguments: managerEntity,
                  );
                },
              ),
              SizedBox(
                height: itemSpacingHeight,
              ),
              DrawerTile(
                currentPage: ManagerDrawerPage.adminOptions,
                itemColor: currentPage == ManagerDrawerPage.adminOptions
                    ? variantColor
                    : surfaceColor,
                icon: Icons.screen_search_desktop_outlined,
                title: "Opções Administrativas",
                width: width,
                onTap: () {
                  Modular.to.pop();
                  Modular.to.navigate(
                    "${UserRoutes.adminOptionsPage}$enterpriseId",
                    arguments: managerEntity,
                  );
                },
              ),
              SizedBox(
                height: itemSpacingHeight,
              ),
              DrawerTile(
                currentPage: ManagerDrawerPage.settings,
                itemColor: currentPage == ManagerDrawerPage.settings
                    ? variantColor
                    : surfaceColor,
                icon: Icons.settings,
                title: "Configurações",
                width: width,
                onTap: () {
                  Modular.to.pop();
                  Modular.to.navigate(
                    "${UserRoutes.managerSettingsPage}$enterpriseId",
                    arguments: managerEntity,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
