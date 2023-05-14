import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/widgets/manager_section_drawer.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/manager_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/payment_methods_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../management_module/presenter/stores/management_store.dart';
import '../../../domain/entities/manager_entity.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

final _managementStore = Modular.get<ManagementStore>();
final _paymentMethodController = Modular.get<PaymentMethodsController>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _ManagementPageState extends State<ManagementPage> {
  @override
  void initState() {
    _paymentMethodController.getPaymentMethodsInformations(_enterpriseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final detailColor = Theme.of(context).colorScheme.onPrimary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    return Scaffold(
      appBar: AppBar(),
      drawer: ManagerSectionDrawer(
          currentPage: ManagerDrawerPage.management,
          managerEntity: widget.managerEntity,
          enterpriseId: _enterpriseId),
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
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AnimatedBuilder(
                          animation: _paymentMethodController,
                          builder: (context, _) {
                            return Container(
                              height: height * 0.15,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: surfaceColor, width: 0.9),
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Todos:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                        Text(
                                          "${_paymentMethodController.paymentMethods.length}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mais Frequente:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                        Text(
                                          "Crédito",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Frequência:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                        Text(
                                          "35/hora",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(color: surfaceColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.05,
                        width: width * 0.4,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: variantColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: detailColor,
                            ),
                            backgroundColor: variantColor,
                          ),
                          onPressed: () {
                            Modular.to.pushNamed(
                              "${ManagementRoutes.paymentMethodsPage}$_enterpriseId",
                              arguments: widget.managerEntity,
                            );
                          },
                          child: Text(
                            "Visualizar",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.09,
                      ),
                      Text(
                        "Pendências:",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: surfaceColor),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(color: surfaceColor, width: 0.9),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Todas:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                  Text(
                                    "4",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Período:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                  Text(
                                    "Manhã",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Operadores:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                  Text(
                                    "3",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: surfaceColor),
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
                      Container(
                        height: height * 0.05,
                        width: width * 0.4,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: variantColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: detailColor,
                            ),
                            backgroundColor: variantColor,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Visualizar",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
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
