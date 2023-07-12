// ignore_for_file: must_be_immutable
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/tiles/drawer_tile.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../controller/manager_controller.dart';

class ManagerSectionDrawer extends StatelessWidget {
  ManagerSectionDrawer({
    super.key,
    this.radius,
    this.width,
    this.enterpriseId,
    required this.currentPage,
    required this.managerEntity,
  });
  double? radius;
  double? width;
  ManagerDrawerPage currentPage;
  ManagerEntity managerEntity;
  String? enterpriseId;
  final loginController = Modular.get<LoginController>();
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final sizeFrame = height <= 800.0;
    final itemSpacingHeight = sizeFrame ? height * 0.015 : height * 0.02;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? 5),
        bottomRight: Radius.circular(radius ?? 5),
      ),
      child: Drawer(
        backgroundColor: appThemes.primaryColor(context),
        width: width,
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
                height: height * 0.12,
              ),
              DrawerTile(
                itemColor: currentPage == ManagerDrawerPage.home ? appThemes.greenColor(context) : appThemes.surfaceColor(context),
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
                itemColor: currentPage == ManagerDrawerPage.management ? appThemes.greenColor(context) : appThemes.surfaceColor(context),
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
                itemColor: currentPage == ManagerDrawerPage.adminOptions ? appThemes.greenColor(context) : appThemes.surfaceColor(context),
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
                itemColor: currentPage == ManagerDrawerPage.settings ? appThemes.greenColor(context) : appThemes.surfaceColor(context),
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
              SizedBox(height: itemSpacingHeight * 10),
              TextButton(
                onPressed: () {
                  loginController.signOut(context);
                },
                child: Row(
                  children: [
                    Text(
                      "Sair",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: appThemes.surfaceColor(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
