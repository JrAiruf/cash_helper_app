import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/pendency_occurrance_bloc/pendency_ocurrance_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../user_module/presenter/components/buttons/manager_view_button.dart';

class PendenciesListPage extends StatefulWidget {
  const PendenciesListPage({required this.managerEntity, super.key});

  final ManagerEntity managerEntity;

  @override
  State<PendenciesListPage> createState() => _PendenciesListPageState();
}

final _managementController = Modular.get<ManagementController>();

class _PendenciesListPageState extends State<PendenciesListPage> {
  @override
  void initState() {
    super.initState();
    _managementController.enterpriseId = Modular.args.params["enterpriseId"];
    _managementController.getPendencyOcurrances();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
    return BlocBuilder(
      bloc: _managementController.pendencyOcurranceBloc,
      builder: (_, state) {
        if (state is PendencyOcurranceLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: appThemes.indicatorColor(context),
            ),
          );
        }
        if (state is PendencyOcurranceFailureState) {
          return Expanded(
              child: Center(
            child: Text(
              "Sem pendências no momento.",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: appThemes.surfaceColor(context),
                  ),
            ),
          ));
        }
        if (state is PendencyOcurranceSuccessState) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: appThemes.backgroundColor(context),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: sizeFrame ? height * 0.16 : height * 0.15,
                          decoration: BoxDecoration(
                            color: appThemes.primaryColor(context),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.09,
                          child: Text(
                            "Pendências",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Text(
                              "Operadores:",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            SizedBox(
                              height: sizeFrame ? height * 0.63 : height * 0.67,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ListView.builder(
                                  itemCount: state.pendencies.length,
                                  itemBuilder: (_, i) {
                                    final pendingOperatorsIdList = state.pendencies.map((pendency) => pendency.operatorId).toList();
                                    final pendingOperator = state.operators.where((operatorEntity) => pendingOperatorsIdList.contains(operatorEntity.operatorId)).toList();
                                    final operatorPendingAnnotations = state.annotations.where((annotation) => annotation.annotationCreatorId == pendingOperator[i].operatorId).toList();
                                    final operatorPendencies = state.pendencies.where((pendency) => pendency.operatorId == pendingOperator[i].operatorId).toList();
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 3),
                                      child: Container(
                                        height: height * 0.28,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: appThemes.primaryColor(context),
                                          border: Border.all(
                                            color: appThemes.surfaceColor(context),
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "${pendingOperator[i].operatorName}",
                                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                          color: appThemes.surfaceColor(context),
                                                        ),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor: appThemes.surfaceColor(context),
                                                    radius: height * 0.02,
                                                    child: Text(
                                                      "${pendingOperator[i].operatorNumber}",
                                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                                            color: appThemes.primaryColor(context),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Total de anotações",
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                          color: appThemes.surfaceColor(context),
                                                        ),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor: appThemes.surfaceColor(context),
                                                    radius: height * 0.02,
                                                    child: Text(
                                                      "${operatorPendingAnnotations.length}",
                                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                                            color: appThemes.primaryColor(context),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Total de pendências",
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                          color: appThemes.surfaceColor(context),
                                                        ),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor: appThemes.surfaceColor(context),
                                                    radius: height * 0.02,
                                                    child: Text(
                                                      "${operatorPendencies.length}",
                                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                                            color: appThemes.primaryColor(context),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: ManagerViewButton(
                                                  text: "Visualizar",
                                                  onPressed: () {
                                                    Modular.to.pushNamed("${ManagementRoutes.operatorActivityPage}${_managementController.enterpriseId}", arguments: {
                                                      "manager": widget.managerEntity,
                                                      "operator": pendingOperator[i],
                                                      "pendingAnnotations": operatorPendingAnnotations,
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
