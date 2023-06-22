import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_close_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/pages/operator-section/operator_area.dart';
import '../presenter/pages/operator-section/operator_home_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/operator_profile_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/operator_settings_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/change_operator_email_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/change_operator_password_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/remove_operator_account_page.dart';

class OperatorChildRoutes {
  static List<ChildRoute> routes = [
     ChildRoute(
      "/operator-home-page/:enterpriseId",
      child: (_, args) => OperartorHomePage(
        operatorEntity: args.data,
      ),
    ),
   ChildRoute(
      "/operator-profile-page/:enterpriseId",
      child: (_, args) => OperatorProfilePage(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/operator-settings-page/:enterpriseId",
      child: (_, args) => OperatorSettingsPage(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/change-operator-email",
      child: (_, args) => ChangeOperatorEmailPage(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/change-operator-password",
      child: (_, args) => ChangeOperatorPasswordPage(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/remove-operator-account",
      child: (_, args) => RemoveOperatorAccountPage(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/operator-area/:enterpriseId",
      child: (_, args) => OperatorArea(
        operatorEntity: args.data,
      ),
    ),
ChildRoute(
      "/operator-close-page/:enterpriseId",
      child: (_, args) => OperatorClosePage(
        operatorEntity: args.data,
      ),
    ),
  ];
}