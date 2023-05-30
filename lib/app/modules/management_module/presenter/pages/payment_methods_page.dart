import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

final _managementStore = Modular.get<ManagementStore>();
final _enterpriseId = Modular.args.params["enterpriseId"];

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  @override
  void initState() {
    _managementStore.getAllPaymentMethods(_enterpriseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final errorColor = Theme.of(context).colorScheme.errorContainer;
    final detailColor = Theme.of(context).colorScheme.onPrimary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final backgroundColor = Theme.of(context).colorScheme.onBackground;
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
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
                  top: 90,
                  child: Text(
                    "Métodos de Pagamento",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: SizedBox(
                width: width,
                child: ValueListenableBuilder(
                  valueListenable: _managementStore,
                  builder: (_, state, __) {
                    if (state is ManagementInitialState) {
                      _managementStore.getAllPaymentMethods(_enterpriseId);
                    }
                    if (state is ManagementLoadingState) {
                      return Container(
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: detailColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetPaymentMethodsState) {
                      final paymentMethods = state.paymentMethods;
                      return Container(
                        decoration: BoxDecoration(color: backgroundColor),
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Text(
                                    "Métodos Cadastrados:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: surfaceColor),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  SizedBox(
                                    height: height * 0.5,
                                    child: ListView.builder(
                                      itemCount: paymentMethods.length,
                                      itemBuilder: (_, i) {
                                        final paymentMethod = paymentMethods[i];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              final argObjects = {
                                                "paymentMethodEntity":
                                                    paymentMethod,
                                                "managerEntity":
                                                    widget.managerEntity,
                                              };
                                              Modular.to.pushNamed(
                                                  "${ManagementRoutes.paymentMethod}$_enterpriseId",
                                                  arguments: argObjects);
                                            },
                                            child: Container(
                                              height: height * 0.11,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: primaryColor,
                                                border: Border.all(
                                                  color: detailColor,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${paymentMethod.paymentMethodName}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                surfaceColor),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .analytics_outlined,
                                                        color: surfaceColor,
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.07,
                                                      ),
                                                      Text(
                                                        "${paymentMethod.paymentMethodUsingRate} - hora",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                                color:
                                                                    surfaceColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(
                                              color: detailColor,
                                            ),
                                            backgroundColor: variantColor,
                                          ),
                                          onPressed: () {
                                            Modular.to.navigate(
                                                "${ManagementRoutes.createPaymentMethodPage}$_enterpriseId",
                                                arguments:
                                                    widget.managerEntity);
                                          },
                                          child: Text(
                                            "Criar",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: errorColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(
                                              color: detailColor,
                                            ),
                                            backgroundColor: errorColor,
                                          ),
                                          onPressed: () {
                                            Modular.to.navigate(
                                              "${ManagementRoutes.removePaymentMethodPage}$_enterpriseId",
                                              arguments: widget.managerEntity,
                                            );
                                          },
                                          child: Text(
                                            "Remover",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is NoPaymentMethodsState) {
                      return Container(
                        decoration: BoxDecoration(color: backgroundColor),
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Text(
                                    "Métodos Cadastrados:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: surfaceColor,
                                        ),
                                  ),
                                  SizedBox(
                                    height: height * 0.5,
                                    child: Center(
                                      child: Text(
                                        "Nenhum método de pagamento encontrado",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: surfaceColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(
                                              color: detailColor,
                                            ),
                                            backgroundColor: variantColor,
                                          ),
                                          onPressed: () {
                                            Modular.to.pushReplacementNamed(
                                                "${ManagementRoutes.createPaymentMethodPage}$_enterpriseId",
                                                arguments:
                                                    widget.managerEntity);
                                          },
                                          child: Text(
                                            "Criar",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: errorColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            side: BorderSide(
                                              color: detailColor,
                                            ),
                                            backgroundColor: errorColor,
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Remover",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is PaymentMethodFailureState) {
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
 ValueListenableBuilder(
        valueListenable: _managementStore,
        builder: (_, state, __) {
          
          
          
        },
      ),
 */