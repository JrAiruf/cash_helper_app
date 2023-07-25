import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_states.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_state.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/management_controller.dart';

class PaymentMethodsInformationCard extends StatelessWidget {
  PaymentMethodsInformationCard({required this.enterpriseId, super.key}) {
    _managementController.enterpriseId = enterpriseId;
    _managementController.getAllPaymentMethods();
  }
  final _managementController = Modular.get<ManagementController>();
  final String enterpriseId;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appThemes = CashHelperThemes();
    return Container(
      height: height * 0.15,
      decoration: BoxDecoration(border: Border.all(color: appThemes.surfaceColor(context), width: 0.5), color: appThemes.primaryColor(context), borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: BlocBuilder(
            bloc: _managementController.paymentMethodsListBloc,
            builder: (_, state) {
              if (state is PaymentMethodsListLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: appThemes.indicatorColor(context),
                  ),
                );
              }
              if (state is PaymentMethodsListErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                );
              }
              if (state is PaymentMethodsListSuccessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Todos:",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          "${state.paymentMethods.length}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mais Frequente:",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          "Crédito",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Frequência:",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                        Text(
                          "35/hora",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}

/* 
BlocBuilder(
      bloc: _managementController.paymentMethodsBloc,
      builder: (_, state) {
        return Container(
          height: height * 0.15,
          decoration: BoxDecoration(border: Border.all(color: appThemes.surfaceColor(context), width: 0.5), color: appThemes.primaryColor(context), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Todos:",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                    Text(
                      "$paymentMethodsTotal",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mais Frequente:",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                    Text(
                      "Crédito",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Frequência:",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                    Text(
                      "35/hora",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appThemes.surfaceColor(context)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ); */
/* 

 */