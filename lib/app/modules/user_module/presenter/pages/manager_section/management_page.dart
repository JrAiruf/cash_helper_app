import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/manager_section_drawer.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../../domain/entities/manager_entity.dart';
import '../../components/buttons/manager_view_button.dart';
import '../../../../management_module/presenter/components/payment_methods_information_card.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

final _managementController = Modular.get<ManagementController>();
final _enterpriseId = Modular.args.params["enterpriseId"];
final List<String> operatorsWithPendencies = [];

class _ManagementPageState extends State<ManagementPage> {
  @override
  void initState() {
    super.initState();
    _managementController.getAllPendencies(_enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    return Scaffold(
      appBar: AppBar(),
      drawer: ManagerSectionDrawer(
        currentPage: ManagerDrawerPage.management,
        managerEntity: widget.managerEntity,
        enterpriseId: _enterpriseId,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.09,
                    child: Text(
                      "Gerenciamento",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: SizedBox(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Métodos de Pagamento:",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      PaymentMethodsInformationCard(enterpriseId: _enterpriseId),
                      const SizedBox(
                        height: 15,
                      ),
                      ManagerViewButton(
                        onPressed: () => Modular.to.pushNamed(
                          "${ManagementRoutes.paymentMethodsPage}$_enterpriseId",
                          arguments: widget.managerEntity,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      Text(
                        "Pendências:",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AnimatedBuilder(
                          animation: _managementController.pendenciesListStore,
                          builder: (_, __) {
                            final pendencies = _managementController.pendencies.value;
                            final operatorIdList = pendencies.map((e) => e.operatorId).toList();
                            for (var id in operatorIdList) {
                              if (!operatorsWithPendencies.contains(id)) {
                                setState(() {
                                  operatorsWithPendencies.add(id!);
                                });
                              }
                            }
                            return Container(
                              height: sizeFrame ? height * 0.21 : height * 0.23,
                              decoration: BoxDecoration(border: Border.all(color: surfaceColor, width: 0.5), color: primaryColor, borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: height * 0.15,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Todas:",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                              ),
                                              Text(
                                                "${pendencies.length}",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Operadores:",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                              ),
                                              Text(
                                                "${operatorsWithPendencies.length}",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Período:",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: height * 0.04,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: surfaceColor, width: 0.5),
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text("Hello"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: surfaceColor, width: 0.5),
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text("Hello"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Container(
                                          height: height * 0.04,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: surfaceColor, width: 0.5),
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text("Hello"),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      ManagerViewButton(
                        onPressed: () => Modular.to.pushNamed(
                          "${ManagementRoutes.pendenciesListPage}$_enterpriseId",
                          arguments: widget.managerEntity,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
