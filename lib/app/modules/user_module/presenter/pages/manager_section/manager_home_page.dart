import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/operator_info_list_view_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../login_module/presenter/components/buttons/cash_helper_login_button.dart';
import '../../../../management_module/presenter/stores/management_store.dart';
import '../../components/buttons/quick_access_button.dart';
import '../../components/widgets/manager_section_drawer.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

final _loginStore = Modular.get<LoginStore>();
final _managementStore = Modular.get<ManagementStore>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  void initState() {
    _loginStore.getUserById(_enterpriseId, widget.managerEntity.managerId!,
        widget.managerEntity.businessPosition!);
    _managementStore.getOperatorsInformations(_enterpriseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;

    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, state, __) {
        if (state is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: CircularProgressIndicator(
                color: indicatorColor,
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
              currentPage: ManagerDrawerPage.home,
              radius: 20,
              width: width * 0.75,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: backgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePageComponent(
                        manager: manager,
                        height: height * 0.19,
                        width: width,
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Atividades recentes:",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: surfaceColor),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.18,
                        child: ValueListenableBuilder(
                          valueListenable: _managementStore,
                          builder: (_, state, __) {
                            if (state is ManagementLoadingState) {
                              return Container(
                                decoration: BoxDecoration(color: primaryColor),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: indicatorColor,
                                  ),
                                ),
                              );
                            }
                            if (state is ManagementInitialState) {
                              return Container(
                                decoration: BoxDecoration(color: primaryColor),
                                child: Center(
                                  child: Text(
                                    "Aguarde ...",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                ),
                              );
                            }
                            if (state is GetUsersListState) {
                              final operatorsList = state.operators;
                              return OperatorInfoListViewComponent(
                                  operators: operatorsList);
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
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: surfaceColor,
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
                              backgroundColor: primaryColor,
                              onPressed: () {},
                              border: true,
                              height: height * 0.1,
                              width: width * 0.38,
                              radius: 15,
                              items: [
                                Icon(
                                  Icons.person,
                                  color: surfaceColor,
                                ),
                                Text(
                                  "Operadores",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: surfaceColor),
                                ),
                              ],
                            ),
                            QuickAccessButton(
                              backgroundColor: primaryColor,
                              onPressed: () {},
                              border: true,
                              height: height * 0.1,
                              width: width * 0.38,
                              radius: 15,
                              items: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: surfaceColor,
                                ),
                                Text(
                                  "Anotações",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: surfaceColor),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CashHelperElevatedButton(
                          width: width,
                          height: 60,
                          radius: 12,
                          onPressed: () {
                            Modular.to.navigate(
                              "${UserRoutes.controllPanelPage}$_enterpriseId",
                              arguments: manager,
                            );
                          },
                          buttonName: "Painel de controle",
                          backgroundColor: variantColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 137,
                  left: 30,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        maxRadius: 30,
                        child: CircleAvatar(
                          backgroundColor: variantColor,
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
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: surfaceColor,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
          );
        }
      },
    );
  }
}
