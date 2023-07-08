import 'package:cash_helper_app/app/modules/login_module/presenter/controllers/login_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../domain/entities/pendency_entity.dart';

class PendenciesListPage extends StatefulWidget {
  const PendenciesListPage({super.key});

  @override
  State<PendenciesListPage> createState() => _PendenciesListPageState();
}

List<PendencyEntity> pendencies = [];
List<OperatorEntity> operatorsWithPendency = [];
final _loginController = Modular.get<LoginController>();
final _managementController = Modular.get<ManagementController>();

class _PendenciesListPageState extends State<PendenciesListPage> {
  @override
  void initState() {
    super.initState();
    _loginController.enterpriseId = Modular.args.params["enterpriseId"];
    _loginController.getAllOperators();
    _managementController.getAllPendencies(_loginController.enterpriseId);
    _managementController.getAllOperatorsWithPendencies(_loginController.enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final appThemes = CashHelperThemes();
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
                      AnimatedBuilder(
                          animation: _managementController.pendencies,
                          builder: (_, __) {
                            return SizedBox(
                              height: sizeFrame ? height * 0.63 : height * 0.67,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: ListView.builder(
                                  itemCount: _managementController.operatorsList.length,
                                  itemBuilder: (_, i) {
                                    final pendingOperator =
                                        _managementController.operatorsList.firstWhere((operatorEntity) => operatorEntity.operatorId == _managementController.operatorsList[i].operatorId);
                                    _managementController.getAnnotationsByOperator(_loginController.enterpriseId, pendingOperator.operatorId!);
                                    _managementController.getPendingAnnotationsByOperator(pendingOperator.operatorId!);
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
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${pendingOperator.operatorName}",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                            ),
                                            Text(
                                              "${pendingOperator.operatorNumber}",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                            ),
                                            Text(
                                              "${_managementController.operatorAnnotations.value.length}",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                            ),
                                            Text(
                                              "${_managementController.operatorsPendencies.value.length}",
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
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
}
