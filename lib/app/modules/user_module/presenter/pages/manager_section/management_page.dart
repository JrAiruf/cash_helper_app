import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/manager_section_drawer.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';
import '../../../domain/entities/manager_entity.dart';
import '../../components/buttons/manager_view_button.dart';
import '../../components/cards/payment_methods_information_card.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

final _managementController = Modular.get<ManagementController>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _ManagementPageState extends State<ManagementPage> {
  @override
  void initState() {
    super.initState();
    _managementController.paymentMethodsListStore.getAllPaymentMethods(_enterpriseId);
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
                      Container(
                        height: height * 0.15,
                        decoration: BoxDecoration(border: Border.all(color: surfaceColor, width: 0.5), color: primaryColor, borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                    "4",
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
                                  Text(
                                    "Manhã",
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
                                    "3",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
