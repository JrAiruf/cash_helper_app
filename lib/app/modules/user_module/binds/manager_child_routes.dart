import 'package:cash_helper_app/app/modules/user_module/presenter/pages/manager_section/views/admin_options_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../presenter/pages/manager_section/controll_panel_page.dart';
import '../presenter/pages/manager_section/management_page.dart';
import '../presenter/pages/manager_section/manager_home_page.dart';
import '../presenter/pages/manager_section/views/manager_settings_page.dart';

class ManagerChildRoutes {
  static List<ChildRoute> routes = [
    ChildRoute(
      "/manager-home-page/:enterpriseId",
      child: (_, args) => ManagerHomePage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/management-page/:enterpriseId",
      child: (_, args) => ManagementPage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/admin-options-page/:enterpriseId",
      child: (_, args) => AdminOptionsPage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/manager-settings-page/:enterpriseId",
      child: (_, args) => ManagerSettingsPage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/controll-panel-page/:enterpriseId",
      child: (_, args) => ControllPanelPage(
        managerEntity: args.data,
      ),
    ),
  ];
}
