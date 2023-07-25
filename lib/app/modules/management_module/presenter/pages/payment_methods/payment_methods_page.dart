import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_state.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../routes/app_routes.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key, required this.managerEntity});

  final ManagerEntity managerEntity;
  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

final _managementController = Modular.get<ManagementController>();

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  @override
  void initState() {
    _managementController.enterpriseId = Modular.args.params["enterpriseId"];
    _managementController.getAllPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800;
    final appThemes = CashHelperThemes();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: height * 0.15,
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
                child: BlocConsumer(
                  bloc: _managementController.paymentMethodsListBloc,
                  listener: (context, state) {},
                  builder: (_, state) {
                    if (state is PaymentMethodsListLoadingState) {
                      return Container(
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          color: appThemes.backgroundColor(context),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: appThemes.indicatorColor(context),
                          ),
                        ),
                      );
                    }
                    if (state is PaymentMethodsListSuccessState) {
                      final paymentMethods = state.paymentMethods;
                      return paymentMethods.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
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
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
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
                                                      "paymentMethodEntity": paymentMethod,
                                                      "managerEntity": widget.managerEntity,
                                                    };
                                                    Modular.to.pushNamed("${ManagementRoutes.paymentMethod}${_managementController.enterpriseId}", arguments: argObjects);
                                                  },
                                                  child: Container(
                                                    height: sizeFrame ? height * 0.12 : height * 0.11,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: appThemes.primaryColor(context),
                                                      border: Border.all(
                                                        color: appThemes.surface(context),
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${paymentMethod.paymentMethodName}",
                                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appThemes.surfaceColor(context)),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.analytics_outlined,
                                                              color: appThemes.surfaceColor(context),
                                                            ),
                                                            SizedBox(
                                                              width: width * 0.07,
                                                            ),
                                                            Text(
                                                              "${paymentMethod.paymentMethodUsingRate} - hora",
                                                              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appThemes.surfaceColor(context)),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: height * 0.05,
                                              width: width * 0.4,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 3,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: appThemes.blueColor(context),
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
                                                    color: appThemes.surface(context),
                                                  ),
                                                  backgroundColor: appThemes.blueColor(context),
                                                ),
                                                onPressed: () {
                                                  Modular.to.navigate("${ManagementRoutes.createPaymentMethodPage}${_managementController.enterpriseId}", arguments: widget.managerEntity);
                                                },
                                                child: Text(
                                                  "Criar",
                                                  style: Theme.of(context).textTheme.displaySmall,
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
                                                color: appThemes.redColor(context),
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
                                                    color: appThemes.surface(context),
                                                  ),
                                                  backgroundColor: appThemes.redColor(context),
                                                ),
                                                onPressed: () {
                                                  Modular.to.navigate(
                                                    "${ManagementRoutes.removePaymentMethodPage}${_managementController.enterpriseId}",
                                                    arguments: widget.managerEntity,
                                                  );
                                                },
                                                child: Text(
                                                  "Remover",
                                                  style: Theme.of(context).textTheme.displaySmall,
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
                            )
                          : Container(
                              decoration: BoxDecoration(color: appThemes.backgroundColor(context)),
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
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: appThemes.surfaceColor(context),
                                              ),
                                        ),
                                        SizedBox(
                                          height: height * 0.5,
                                          child: Center(
                                            child: Text(
                                              "Nenhum método de pagamento encontrado",
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: appThemes.surfaceColor(context),
                                                  ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.04,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: height * 0.05,
                                              width: width * 0.4,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 3,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: appThemes.redColor(context),
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
                                                    color: appThemes.surface(context),
                                                  ),
                                                  backgroundColor: appThemes.redColor(context),
                                                ),
                                                onPressed: () {
                                                  Modular.to.pushReplacementNamed("${ManagementRoutes.createPaymentMethodPage}${_managementController.enterpriseId}", arguments: widget.managerEntity);
                                                },
                                                child: Text(
                                                  "Criar",
                                                  style: Theme.of(context).textTheme.displaySmall,
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
                                                color: appThemes.red(context),
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
                                                    color: appThemes.surface(context),
                                                  ),
                                                  backgroundColor: appThemes.red(context),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Remover",
                                                  style: Theme.of(context).textTheme.displaySmall,
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
                    }
                    return Container();
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