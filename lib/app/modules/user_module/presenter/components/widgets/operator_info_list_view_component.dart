import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OperatorInfoListViewComponent extends StatelessWidget {
  const OperatorInfoListViewComponent({super.key, required this.operators});

  final List<OperatorEntity> operators;
  @override
  Widget build(BuildContext context) {
    final annotationsController = Modular.get<AnnotationsController>();
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.builder(
        itemCount: operators.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          final operatorAnnotations = annotationsController.annotationsListStore.value.where((annotation) => annotation.annotationCreatorId == operators[index].operatorId).toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  operators[index].operatorName ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: surfaceColor),
                ),
                Text(
                  "${operatorAnnotations.length}",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
                ),
                Text(
                  "Sem pendências",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
                ),
                Text(
                  "Fechamento:",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
                ),
                Text(
                  operators[index].operatorClosing ?? "",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
