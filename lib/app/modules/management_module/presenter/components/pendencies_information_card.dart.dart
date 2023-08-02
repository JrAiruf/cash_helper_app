import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';

import '../../../user_module/domain/entities/operator_entity.dart';

class PendenciesInformationCard extends StatefulWidget {
  const PendenciesInformationCard({super.key, required this.enterpriseId, required this.height, required this.operators, required this.pendencies});

  final double height;
  final List<PendencyEntity> pendencies;
  final List<OperatorEntity> operators;
  final String enterpriseId;

  @override
  State<PendenciesInformationCard> createState() => _PendenciesInformationCardState();
}

class _PendenciesInformationCardState extends State<PendenciesInformationCard> {
  @override
  Widget build(BuildContext context) {
    final appTheme = CashHelperThemes();
    final sizeFrame = widget.height <= 800;
    final periodList = widget.pendencies.map((pendency) => pendency.pendencyPeriod).toList();
    List<String> periods = [];
    for (var period in periodList) {
      if (!periods.contains(period)) {
        periods.add(period!);
      }
    }
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
                        "${widget.pendencies.length}",
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
                        "${widget.operators.length}",
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
}
