// ignore_for_file: must_be_immutable, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/buttons/quick_access_button.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/tiles/drawer_tile.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/widgets/cash_helper_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/home_page_card_component.dart';

class OperartorHomePage extends StatefulWidget {
  OperartorHomePage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<OperartorHomePage> createState() => _OperartorHomePageState();
}

class _OperartorHomePageState extends State<OperartorHomePage> {
  final _loginStore = Modular.get<LoginStore>();
  final _annotationListStore = Modular.get<AnnotationsListStore>();
  final _loginController = Modular.get<LoginController>();
  DrawerPagePosition? drawerPosition;
  @override
  void initState() {
    super.initState();
    _loginStore.getOperatorById(widget.operatorEntity.operatorId!,
        widget.operatorEntity.operatorOcupation!);
    _annotationListStore.getAllAnnotations(widget.operatorEntity.operatorId!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final tertiaryColor = Theme.of(context).colorScheme.tertiaryContainer;
    final backgroundContainer = Theme.of(context).colorScheme.onBackground;
    return ValueListenableBuilder(
      valueListenable: _loginStore,
      builder: (_, operatorState, __) {
        if (operatorState is LoginLoadingState) {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: CircularProgressIndicator(
                color: indicatorColor,
              ),
            ),
          );
        }
        if (operatorState is LoginSuccessState) {
          final currentOperator = operatorState.operatorEntity;
          _loginController.drawerPosition = DrawerPagePosition.home;
          return Scaffold(
            appBar: AppBar(),
            drawer: CashHelperDrawer(
              height: height,
              width: width,
              drawerTitle: "Opções",
              backgroundColor: primaryColor,
              drawerItems: [
                DrawerTile(
                  width: width,
                  title: "Início",
                  icon: Icons.home,
                  itemColor:
                      _loginController.drawerPosition == DrawerPagePosition.home
                          ? tertiaryColor
                          : Colors.white,
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                SizedBox(height: height * 0.06),
                DrawerTile(
                  width: width,
                  title: "Meu Perfil",
                  icon: Icons.person,
                  itemColor: _loginController.drawerPosition ==
                          DrawerPagePosition.profile
                      ? tertiaryColor
                      : Colors.white,
                  onTap: () {
                    Modular.to.pop();
                    Modular.to.pushNamed("./operator-profile",
                        arguments: currentOperator);
                  },
                ),
                SizedBox(height: height * 0.06),
                DrawerTile(
                  width: width,
                  title: "Configurações",
                  icon: Icons.settings,
                  itemColor: _loginController.drawerPosition ==
                          DrawerPagePosition.settings
                      ? tertiaryColor
                      : Colors.white,
                  onTap: () {
                    print(currentOperator.operatorId);
                    print(currentOperator.operatorEmail);
                    print(currentOperator.operatorPassword);
                    Modular.to.pop();
                    Modular.to.navigate("./operator-settings",
                        arguments: currentOperator);
                  },
                ),
                SizedBox(height: height * 0.3),
                GestureDetector(
                  onTap: () {
                    _loginController.showSignOutDialog(
                      context,
                      primaryColor,
                      () {
                        _loginStore.signOut();
                        Modular.to.pop();
                        Modular.to.navigate("/");
                      },
                    );
                  },
                  child: Text("Sair",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: backgroundContainer),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePageComponent(
                        operator: currentOperator,
                        height: height * 0.19,
                        width: width,
                        color: primaryColor,
                      ),
                      SizedBox(height: height * 0.07),
                      ValueListenableBuilder(
                        valueListenable: _annotationListStore,
                        builder: ((context, annotationListState, child) {
                          if (annotationListState
                              is LoadingAnnotationsListState) {
                            return Container(
                              decoration: BoxDecoration(color: primaryColor),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: indicatorColor,
                                ),
                              ),
                            );
                          } else if (annotationListState
                              is RetrievedAnnotationsListState) {
                            final annotationsList =
                                annotationListState.annotationsList;
                            final pendingAnnotations = annotationsList.where(
                                (annotation) =>
                                    annotation.annotationConcluied == false);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "Últimas anotações:",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: SizedBox(
                                    height: height * 0.2,
                                    child: Center(
                                      child: Text(
                                        "Sem Anotações no momento",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text("Acesso rápido:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          QuickAccessButton(
                                            backgroundColor: primaryColor,
                                            border: true,
                                            height: height * 0.1,
                                            width: width * 0.38,
                                            radius: 15,
                                            items: [
                                              const Icon(
                                                Icons.list_alt_outlined,
                                                color: Colors.white,
                                              ),
                                              Text("Anotações",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ),
                                          QuickAccessButton(
                                            backgroundColor: primaryColor,
                                            border: true,
                                            height: height * 0.1,
                                            width: width * 0.38,
                                            radius: 15,
                                            items: [
                                              const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              Text("Nova Anotação",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (annotationListState
                              is EmptyAnnotationsListState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    "Últimas anotações:",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: SizedBox(
                                    height: height * 0.2,
                                    child: Center(
                                      child: Text(
                                        "Sem Anotações no momento",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text("Acesso rápido:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          QuickAccessButton(
                                            backgroundColor: primaryColor,
                                            border: true,
                                            height: height * 0.1,
                                            width: width * 0.38,
                                            radius: 15,
                                            items: [
                                              const Icon(
                                                Icons.list_alt_outlined,
                                                color: Colors.white,
                                              ),
                                              Text("Anotações",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ),
                                          QuickAccessButton(
                                            backgroundColor: primaryColor,
                                            border: true,
                                            height: height * 0.1,
                                            width: width * 0.38,
                                            radius: 15,
                                            items: [
                                              const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              Text("Nova Anotação",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 45, horizontal: 10),
                        child: CashHelperElevatedButton(
                          width: width,
                          height: 60,
                          radius: 12,
                          onPressed: () => Modular.to.pushNamed(
                            "./operator-area/${currentOperator.operatorId}",
                          ),
                          buttonName: "Área do operador",
                          backgroundColor: tertiaryColor,
                          nameColor: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 140,
                  right: 25,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        maxRadius: 30,
                        child: CircleAvatar(
                          backgroundColor: currentOperator.operatorEnabled!
                              ? tertiaryColor
                              : secondaryColor,
                          maxRadius: 29,
                          child: const Icon(
                            color: Colors.white,
                            Icons.person,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Text(currentOperator.operatorEnabled!
                          ? "Ativo"
                          : "Inativo"),
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
