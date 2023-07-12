import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/operator_info_list_view_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../components/buttons/quick_access_button.dart';
import '../../components/widgets/manager_section_drawer.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

final _loginController = Modular.get<LoginController>();
final _managementController = Modular.get<ManagementController>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  void initState() {
    super.initState();
    _loginController.enterpriseId = _enterpriseId;
    _loginController.loginStore.getUserById(_enterpriseId, widget.managerEntity.managerId!, widget.managerEntity.businessPosition!);
    _managementController.managementStore.getOperatorsInformations(_enterpriseId);
    _managementController.annotationsListStore.getAllAnnotations(_enterpriseId);
    _managementController.getAllPendencies(_enterpriseId);
    _loginController.getAllOperators();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return ValueListenableBuilder(
      valueListenable: _loginController.loginStore,
      builder: (_, state, __) {
        if (state is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        }
        if (state is ManagerLoginSuccessState) {
          final manager = state.managerEntity;
          return Scaffold(
            appBar: AppBar(),
            drawer: ManagerSectionDrawer(
              managerEntity: manager,
              enterpriseId: _enterpriseId,
              operatorsWithPendency: _loginController.operatorsList,
              pendencies: _managementController.pendencies.value,
              currentPage: ManagerDrawerPage.home,
              radius: 20,
              width: width * 0.75,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePageComponent(
                        manager: manager,
                        height: height * 0.19,
                        width: width,
                        color: appThemes.primaryColor(context),
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Atividades recentes:",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.18,
                        child: ValueListenableBuilder(
                          valueListenable: _managementController.managementStore,
                          builder: (_, state, __) {
                            if (state is ManagementLoadingState) {
                              return Container(
                                decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: appThemes.indicatorColor(context),
                                  ),
                                ),
                              );
                            }
                            if (state is GetUsersListFailureState) {
                              return Center(
                                child: Text(
                                  "Nenhum Operador Encontrado",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: appThemes.surfaceColor(context),
                                      ),
                                ),
                              );
                            }
                            if (state is GetUsersListState) {
                              final operatorsList = state.operators;
                              return OperatorInfoListViewComponent(
                                enterpriseId: _enterpriseId,
                                operators: operatorsList,
                                annotations: _managementController.annotationsListStore.value,
                                pendencies: _managementController.pendencies.value,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text(
                          "Acesso rápido:",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: appThemes.surfaceColor(context),
                              ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuickAccessButton(
                              backgroundColor: appThemes.primaryColor(context),
                              onPressed: () {},
                              border: true,
                              height: height * 0.1,
                              width: width * 0.38,
                              radius: 15,
                              items: [
                                Icon(
                                  Icons.person,
                                  color: appThemes.surfaceColor(context),
                                ),
                                Text(
                                  "Operadores",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                                ),
                              ],
                            ),
                            QuickAccessButton(
                              backgroundColor: appThemes.primaryColor(context),
                              onPressed: () {},
                              border: true,
                              height: height * 0.1,
                              width: width * 0.38,
                              radius: 15,
                              items: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: appThemes.surfaceColor(context),
                                ),
                                Text(
                                  "Anotações",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Center(
                        child: CashHelperElevatedButton(
                          border: true,
                          height: 50,
                          width: width * 0.7,
                          radius: 12,
                          onPressed: () {
                            Modular.to.navigate(
                              "${UserRoutes.controllPanelPage}$_enterpriseId",
                              arguments: manager,
                            );
                          },
                          buttonName: "Painel de controle",
                          backgroundColor: appThemes.blueColor(context),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: sizeFrame ? height * 0.149 : height * 0.153,
                  left: width * 0.07,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                        maxRadius: 30,
                        child: CircleAvatar(
                          backgroundColor: appThemes.blueColor(context),
                          maxRadius: 29,
                          child: const Icon(
                            color: Colors.white,
                            Icons.person,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Text(
                        "Gerente",
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: appThemes.surfaceColor(context),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (state is LoginSignOutState) {
          Modular.to.navigate(EnterpriseRoutes.initial);
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
          );
        } else {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
          );
        }
      },
    );
  }
}
