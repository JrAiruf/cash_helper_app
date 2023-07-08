import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PendenciesInformationCard extends StatelessWidget {
  PendenciesInformationCard({super.key, required this.enterpriseId, required this.height}) {
    _managementController.getAllPendencies(enterpriseId);
  }

  final double height;
  final String enterpriseId;
  final _managementController = Modular.get<ManagementController>();
  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final sizeFrame = height <= 800;
    return AnimatedBuilder(
      animation: _managementController.pendenciesListStore,
      builder: (_, __) {
        final pendencies = _managementController.pendencies.value.length;
        return Container(
          height: sizeFrame ? height * 0.22 : height * 0.23,
          decoration: BoxDecoration(border: Border.all(color: appTheme.surfaceColor(context), width: 0.5), color: appTheme.primaryColor(context), borderRadius: BorderRadius.circular(20)),
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
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                          ),
                          Text(
                            "$pendencies",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Operadores:",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                          ),
                          AnimatedBuilder(
                              animation: _managementController.operatorsWithPendencies,
                              builder: (_, __) {
                                final operatorsWithPendencies = _managementController.operatorsWithPendencies.value.length;
                                return Text(
                                  "$operatorsWithPendencies",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                                );
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Período:",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _managementController.periodList.value.length,
                    itemBuilder: (_, i) {
                      final period = _managementController.periodList.value[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: appTheme.surfaceColor(context), width: 0.5),
                            color: appTheme.primaryColor(context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                              child: Text(
                                period,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
