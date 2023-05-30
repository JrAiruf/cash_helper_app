import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

class OperatorInfoListViewComponent extends StatelessWidget {
  const OperatorInfoListViewComponent({super.key, required this.operators});

  final List<OperatorEntity> operators;
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.builder(
        itemCount: operators.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    operators[index].operatorName ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    "23 Anotações",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    "Sem pendências",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    "Fechamento:",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                  Text(
                    operators[index].operatorClosing ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: surfaceColor),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}