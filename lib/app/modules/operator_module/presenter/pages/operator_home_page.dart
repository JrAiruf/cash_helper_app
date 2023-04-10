// ignore_for_file: must_be_immutable, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/components/home_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../components/home_page_card_component.dart';

class OperartorAreaPage extends StatefulWidget {
  OperartorAreaPage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<OperartorAreaPage> createState() => _OperartorAreaPageState();
}

class _OperartorAreaPageState extends State<OperartorAreaPage> {
  final _loginStore = Modular.get<LoginStore>();
  final _annotationListStore = Modular.get<AnnotationsListStore>();
  final _loginController = Modular.get<LoginController>();

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
    final primaryColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final seccondaryColor = Theme.of(context).colorScheme.secondary;
    final indicatorColor = Theme.of(context).colorScheme.secondaryContainer;
    final buttonColor = Theme.of(context).colorScheme.onTertiaryContainer;
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
            appBar: AppBar(
              actions: [
                Center(
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      _loginController.showSignOutDialog(context, primaryColor,
                          () {
                        _loginStore.signOut();
                        Modular.to.pop();
                        Modular.to.navigate(Modular.initialRoute);
                      });
                    },
                    icon: const Icon(Icons.logout_outlined),
                  ),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomePageComponent(
                    operator: currentOperator,
                    height: height * 0.19,
                    width: width,
                    color: seccondaryColor,
                  ),
                  SizedBox(height: height * 0.07),
                  ValueListenableBuilder(
                    valueListenable: _annotationListStore,
                    builder: ((context, annotationListState, child) {
                      if (annotationListState is LoadingAnnotationsListState) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                "Informações Gerais:",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.adf_scanner_outlined,
                                    itemName:
                                        'Caixa: ${currentOperator.operatorNumber}',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.note_alt_outlined,
                                    itemName:
                                        'Pendências: ${pendingAnnotations.length}',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.account_tree_outlined,
                                    itemName: currentOperator.operatorEnabled!
                                        ? "Status: Ativo"
                                        : "Status: Inativo",
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.access_time,
                                    itemName:
                                        'Abertura: ${currentOperator.operatorOppening}',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                "Informações Gerais:",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.adf_scanner_outlined,
                                    itemName:
                                        'Caixa: ${currentOperator.operatorNumber}',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.note_alt_outlined,
                                    itemName: 'Pendências: 0',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.account_tree_outlined,
                                    itemName: currentOperator.operatorEnabled!
                                        ? "Status: Ativo"
                                        : "Status: Inativo",
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
                                  ),
                                  HomePageCardComponent(
                                    itemColor: seccondaryColor,
                                    icon: Icons.access_time,
                                    itemName:
                                        'Abertura: ${currentOperator.operatorOppening}',
                                    height: height * 0.18,
                                    width: width * 0.38,
                                    radius: 20,
                                    fontSize: 16,
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
                      border: true,
                      width: width,
                      height: 60,
                      radius: 12,
                      onPressed: () {
                        Modular.to.pushNamed(
                          "./operator-area/${currentOperator.operatorId}",
                        );
                      },
                      buttonName: "Área do operador",
                      backgroundColor: buttonColor,
                      nameColor: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
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

/* 

 */