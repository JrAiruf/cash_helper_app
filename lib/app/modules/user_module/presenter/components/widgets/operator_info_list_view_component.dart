import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../management_module/presenter/controller/management_controller.dart';
import '../operator_widgets/operator_information_tile.dart';

class OperatorInfoListViewComponent extends StatelessWidget {
  OperatorInfoListViewComponent({super.key, required this.enterpriseId, required this.operators});

  final String enterpriseId;
  final List<OperatorEntity> operators;

  final _managementController = Modular.get<ManagementController>();
  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView.builder(
        itemCount: operators.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          _managementController.annotationsListStore.getAllAnnotations(enterpriseId);
          _managementController.getAllPendencies(enterpriseId);
          final pendencies = _managementController.pendenciesListStore.value.where((pendency) => pendency.operatorId == operators[index].operatorId).toList();
          return OperatorInformationTile(
            enterpriseId: enterpriseId,
            operatorEntity: operators[index],
            annotations: _managementController.annotationsListStore.value,
            pendencies: pendencies,
          );
        }),
      ),
    );
  }
}
