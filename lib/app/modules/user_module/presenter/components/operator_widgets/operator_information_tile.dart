import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OperatorInformationTile extends StatelessWidget {
  OperatorInformationTile({
    required this.enterpriseId,
    required this.operatorEntity,
    super.key,
    required this.annotations,
    required this.pendencies,
  });

  final String enterpriseId;
  final OperatorEntity operatorEntity;
  final List<AnnotationEntity> annotations;
  final List<PendencyEntity> pendencies;

  final _managementController = Modular.get<ManagementController>();

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final operatorAnnotations = annotations.where((annotation) => annotation.annotationCreatorId == operatorEntity.operatorId);
    final operatorPendencies = pendencies.where((pendecy) => pendecy.operatorId == operatorEntity.operatorId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            operatorEntity.operatorName ?? "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: surfaceColor),
          ),
          Text(
            operatorAnnotations.isNotEmpty ? "${operatorAnnotations.length}" : "Sem anotações",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
          ),
          Text(
            operatorPendencies.isNotEmpty ? "${operatorPendencies.length}" : "Sem pendências",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
          ),
          Text(
            "Fechamento:",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
          ),
          Text(
            operatorEntity.operatorClosing ?? "",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(color: surfaceColor),
          ),
        ],
      ),
    );
  }
}
