// ignore_for_file: must_be_immutable, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/buttons/quick_access_button.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/cash_helper_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../components/widgets/empty_annotations_list_component.dart';

class OperartorHomePage extends StatefulWidget {
  OperartorHomePage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<OperartorHomePage> createState() => _OperartorHomePageState();
}

class _OperartorHomePageState extends State<OperartorHomePage> {
  final _loginStore = Modular.get<LoginStore>();
  final _annotationListStore = Modular.get<AnnotationsListStore>();
  DrawerPagePosition? drawerPosition;
  final _enterpriseId = Modular.args.params["enterpriseId"];
  @override
  void initState() {
    _loginStore.getUserById(_enterpriseId, widget.operatorEntity.operatorId!,
        widget.operatorEntity.businessPosition!);
    _annotationListStore.getAllAnnotations(widget.operatorEntity.operatorId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final surfaceColor = Theme.of(context).colorScheme.surface;
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
          return Scaffold(
            appBar: AppBar(),
            drawer: CashHelperDrawer(
              backgroundColor: primaryColor,
              radius: 20,
              width: width * 0.75,
              pagePosition: DrawerPagePosition.home,
              operator: currentOperator,
              enterpriseId: _enterpriseId,
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
                          if (annotationListState.isEmpty) {
                            return Container(
                              decoration: BoxDecoration(color: primaryColor),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: indicatorColor,
                                ),
                              ),
                            );
                          } else if (annotationListState.isNotEmpty) {
                            final annotationsList = annotationListState;
                            final pendingAnnotations = annotationsList.where(
                                (annotation) =>
                                    annotation.annotationConcluied == false);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Últimas anotações:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: surfaceColor),
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
                                            .displaySmall
                                            ?.copyWith(color: surfaceColor),
                                      ),
                                    ),
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
                            horizontal: 15, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Acesso rápido:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: surfaceColor,
                                  ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QuickAccessButton(
                                  backgroundColor: primaryColor,
                                  border: true,
                                  height: height * 0.1,
                                  width: width * 0.38,
                                  radius: 15,
                                  items: [
                                    Icon(
                                      Icons.list_alt_outlined,
                                      color: surfaceColor,
                                    ),
                                    Text(
                                      "Anotações",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: surfaceColor,
                                          ),
                                    ),
                                  ],
                                  onPressed: () {
                                    print("Botão 1");
                                  },
                                ),
                                QuickAccessButton(
                                  backgroundColor: primaryColor,
                                  border: true,
                                  height: height * 0.1,
                                  width: width * 0.38,
                                  radius: 15,
                                  items: [
                                    Icon(
                                      Icons.add,
                                      color: surfaceColor,
                                    ),
                                    Text(
                                      "Nova Anotação",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: surfaceColor,
                                          ),
                                    )
                                  ],
                                  onPressed: () {
                                    Modular.to.navigate(
                                        "${AnnotationRoutes.createAnnotationPage}$_enterpriseId",
                                        arguments: currentOperator);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CashHelperElevatedButton(
                          border: true,
                          height: 50,
                          width: width * 0.7,
                          radius: 12,
                          onPressed: () => Modular.to.pushNamed(
                              "./operator-area",
                              arguments: currentOperator),
                          buttonName: "Área do operador",
                          backgroundColor: tertiaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height * 0.155,
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
                      Text(
                        currentOperator.operatorEnabled! ? "Ativo" : "Inativo",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: surfaceColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (operatorState is LoginSignOutState) {
          Modular.to.navigate(EnterpriseRoutes.initial);
          return Container();
        } else {
          return Container(
            decoration: BoxDecoration(color: primaryColor),
          );
        }
      },
    );
  }
}
