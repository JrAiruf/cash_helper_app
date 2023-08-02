import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_states.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _managementController.enterpriseId = _enterpriseId;
    _managementController.managementStore.getOperatorsInformations(_enterpriseId);
    _managementController.annotationsListStore.getAllAnnotations(_enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return BlocConsumer<ManagerBloc, ManagerStates>(
      bloc: _loginController.managerBloc,
      listener: ((context, state) {
        if (state is ManagerSignOutState) {
          Modular.to.navigate(Modular.initialRoute);
        }
      }),
      builder: (_, state) {
        if (state is ManagerLoadingState) {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        }
        if (state is ManagerErrorState) {
          Modular.to.navigate(EnterpriseRoutes.initial);
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
                child: Icon(
              Icons.error,
              size: height * 0.035,
            )),
          );
        }
        if (state is ManagerSuccessState) {
          final manager = state.manager;
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
                        child: Container(),
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
        return Container(
          decoration: BoxDecoration(color: appThemes.primaryColor(context)),
        );
      },
    );
  }
}


/* 
 ValueListenableBuilder(
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
                              state.operators.isNotEmpty ? _managementController.getAllPendencies() : null;
                              final operatorsList = state.operators;
                              return SizedBox(
                                child: ValueListenableBuilder(
                                  valueListenable: _managementController.pendenciesListStore,
                                  builder: (_, state, __) {
                                    if (state is LoadingPendenciesState) {
                                      return Container(
                                        decoration: BoxDecoration(color: appThemes.primaryColor(context)),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: appThemes.indicatorColor(context),
                                          ),
                                        ),
                                      );
                                    }
                                    if (state is NoPendenciesState) {
                                      return Center(
                                        child: Text(
                                          "Sem pendências no momento",
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      );
                                    }
                                    if (state is PendenciesListState) {
                                      final pendenciesList = state.pendencies;
                                      return OperatorInfoListViewComponent(
                                        enterpriseId: _enterpriseId,
                                        operators: operatorsList,
                                        annotations: _managementController.annotationsListStore.value,
                                        pendencies: pendenciesList,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
 */