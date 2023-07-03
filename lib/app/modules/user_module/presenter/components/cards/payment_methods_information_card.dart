import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../management_module/presenter/controller/management_controller.dart';

class PaymentMethodsInformationCard extends StatelessWidget {
  PaymentMethodsInformationCard({required this.enterpriseId, super.key}) {
    _managementController.getAllPaymentMethods(enterpriseId);
  }
  final _managementController = Modular.get<ManagementController>();
  final String enterpriseId;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appThemes = CashHelperThemes();
    return AnimatedBuilder(
      animation: _managementController.paymentMethodsListStore,
      builder: (context, _) {
        final paymentMethodsTotal = _managementController.paymentMethodsListStore.value?.length;
        return Container(
          height: height * 0.15,
          decoration: BoxDecoration(border: Border.all(color: appThemes.surfaceColor(context), width: 0.5), color: appThemes.primaryColor(context), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }
}
