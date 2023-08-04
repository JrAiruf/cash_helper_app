import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/pendency_occurrance_bloc/pendency_ocurrance_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PendenciesInformationCard extends StatefulWidget {
  PendenciesInformationCard({super.key, required this.enterpriseId, required this.managerEntity, required this.height}) {
    _managementController.enterpriseId = enterpriseId;
    _managementController.getPendencyOcurrances();
  }

  final double height;
  final ManagerEntity managerEntity;
  final String enterpriseId;

  @override
  State<PendenciesInformationCard> createState() => _PendenciesInformationCardState();
}

final _managementController = Modular.get<ManagementController>();

class _PendenciesInformationCardState extends State<PendenciesInformationCard> {
  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final sizeFrame = widget.height <= 800;
    final appThemes = CashHelperThemes();
    List<String> periods = [];
    return Container(
      height: widget.height * 0.22,
      decoration: BoxDecoration(
        border: Border.all(color: appThemes.surfaceColor(context), width: 0.5),
        color: appThemes.primaryColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<PendencyOcurranceBloc, PendencyOcurranceStates>(
        bloc: _managementController.pendencyOcurranceBloc,
        builder: (_, state) {
          if (state is PendencyOcurranceLoadingState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: LinearProgressIndicator(
                  minHeight: 1,
                  color: appThemes.blueColor(context),
                ),
              ),
            );
          }
          if (state is PendencyOcurranceSuccessState) {
            final periodList = state.pendencies.map((pendency) => pendency.pendencyPeriod).toList();
            List<String> periods = [];
            for (var period in periodList) {
              if (!periods.contains(period)) {
                periods.add(period!);
              }
            }
            final pendingOperatorsIdList = state.pendencies.map((pendency) => pendency.operatorId).toList();
            final operatorsWithPedencies = state.operators.where((operatorEntity) => pendingOperatorsIdList.contains(operatorEntity.operatorId)).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: widget.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              "${state.pendencies.length}",
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
                            Text(
                              "${operatorsWithPedencies.length}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                            ),
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
                ),
                SizedBox(
                  height: widget.height * 0.04,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: periods.length,
                    itemBuilder: (_, i) {
                      final period = periods[i];
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
            );
          }
          if (state is PendencyOcurranceFailureState) {
            return Container(
              height: sizeFrame ? widget.height * 0.22 : widget.height * 0.23,
              decoration: BoxDecoration(border: Border.all(color: appTheme.surfaceColor(context), width: 0.5), color: appTheme.primaryColor(context), borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: widget.height * 0.15,
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
                                "0",
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
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: appTheme.surfaceColor(context)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: widget.height * 0.04,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: periods.length,
                        itemBuilder: (_, i) {
                          final period = periods[i];
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
          }
          return Container();
        },
      ),
    );
  }
}
