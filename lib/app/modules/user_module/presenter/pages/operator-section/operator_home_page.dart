// ignore_for_file: must_be_immutable, unnecessary_string_interpolations
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/components/buttons/cash_helper_login_button.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_events.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_states.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/buttons/quick_access_button.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/home_page_component.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/cash_helper_drawer.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/operator-section/views/operator_area_views/operator_close_page.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../components/operator_widgets/operator_status_component.dart';
import '../../components/widgets/annotation_info_list_view_component.dart';

class OperartorHomePage extends StatefulWidget {
  OperartorHomePage({super.key, required this.operatorEntity});

  OperatorEntity operatorEntity;
  @override
  State<OperartorHomePage> createState() => _OperartorHomePageState();
}

class _OperartorHomePageState extends State<OperartorHomePage> {
  final _loginController = Modular.get<LoginController>();
  final _annotationsController = Modular.get<AnnotationsController>();
  final _operatorController = Modular.get<OperatorController>();
  DrawerPagePosition? drawerPosition;
  final _enterpriseId = Modular.args.params["enterpriseId"];
  @override
  void initState() {
    _annotationsController.annotationsListStore.getAllAnnotations(_enterpriseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    return BlocConsumer(
      bloc: _loginController.operatorBloc,
      listener: (context, state) {
        if (state is OperatorSignOutState) {
          Modular.to.navigate(EnterpriseRoutes.initial);
        }
      },
      builder: (_, state) {
        if (state is OperatorLoadingState) {
          return Container(
            decoration: BoxDecoration(color: appThemes.primaryColor(context)),
            child: Center(
              child: CircularProgressIndicator(
                color: appThemes.indicatorColor(context),
              ),
            ),
          );
        }
        if (state is OperatorSuccessState) {
          final currentOperator = state.operatorEntity;
          return Scaffold(
            appBar: AppBar(),
            drawer: CashHelperDrawer(
              backgroundColor: appThemes.primaryColor(context),
              radius: 20,
              width: width * 0.75,
              pagePosition: DrawerPagePosition.home,
              operator: currentOperator,
              enterpriseId: _enterpriseId,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePageComponent(
                        operator: currentOperator,
                        height: height * 0.19,
                        width: width,
                        color: appThemes.primaryColor(context),
                      ),
                      SizedBox(height: height * 0.07),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: appThemes.primaryColor(context),
                            border: Border.all(color: appThemes.surfaceColor(context), width: 0.07),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: height * 0.2,
                          child: ValueListenableBuilder(
                            valueListenable: _annotationsController.annotationsListStore,
                            builder: ((context, annotationListState, child) {
                              if (annotationListState.isEmpty) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: appThemes.primaryColor(context),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Nenhuma anotação encontrada",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: appThemes.surfaceColor(context),
                                          ),
                                    ),
                                  ),
                                );
                              } else if (annotationListState.isNotEmpty) {
                                final annotations =
                                    annotationListState.where((annotation) => annotation.annotationCreatorId == currentOperator.operatorId && !annotation.annotationWithPendency!).toList();
                                return AnnotationInfoListViewComponent(
                                  annotations: annotations,
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: height * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Acesso rápido:",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: appThemes.surfaceColor(context),
                                  ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QuickAccessButton(
                                  backgroundColor: appThemes.primaryColor(context),
                                  border: true,
                                  height: height * 0.1,
                                  width: width * 0.38,
                                  radius: 15,
                                  items: [
                                    Icon(
                                      Icons.list_alt_outlined,
                                      color: appThemes.surfaceColor(context),
                                    ),
                                    Text(
                                      "Anotações",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: appThemes.surfaceColor(context),
                                          ),
                                    ),
                                  ],
                                  onPressed: () {
                                    _annotationsController.annotationsListStore.value.isEmpty
                                        ? _operatorController.noAnnotationSnackbar(context)
                                        : Modular.to.navigate("${AnnotationRoutes.annotationsListPage}$_enterpriseId", arguments: currentOperator);
                                  },
                                ),
                                QuickAccessButton(
                                  backgroundColor: appThemes.primaryColor(context),
                                  border: true,
                                  height: height * 0.1,
                                  width: width * 0.4,
                                  radius: 15,
                                  items: [
                                    Icon(
                                      Icons.add,
                                      color: appThemes.surfaceColor(context),
                                    ),
                                    Text(
                                      "Nova Anotação",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: appThemes.surfaceColor(context),
                                          ),
                                    )
                                  ],
                                  onPressed: () {
                                    currentOperator.operatorEnabled!
                                        ? Modular.to.navigate("${AnnotationRoutes.createAnnotationPage}$_enterpriseId", arguments: currentOperator)
                                        : operatorController.operatorDisabledSnackbar(context);
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
                          onPressed: () => Modular.to.navigate("${UserRoutes.operatorArea}$_enterpriseId", arguments: currentOperator),
                          buttonName: "Área do operador",
                          backgroundColor: appThemes.greenColor(context),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                OperatorStatusComponent(
                  textColor: appThemes.surfaceColor(context),
                  activeColor: appThemes.greenColor(context),
                  borderColor: appThemes.backgroundColor(context),
                  inactiveColor: appThemes.purpleColor(context),
                  operatorEntity: currentOperator,
                  sidePosition: width * 0.025,
                  topPosition: sizeFrame ? height * 0.148 : height * 0.155,
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
