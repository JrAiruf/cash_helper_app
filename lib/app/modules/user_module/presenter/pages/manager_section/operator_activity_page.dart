import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../components/cards/operator_pendency_card.dart';
import '../../components/operator_widgets/cash_number_component.dart';

class OperatorActivityPage extends StatefulWidget {
  const OperatorActivityPage({super.key, required this.managerEntity, required this.operatorEntity, required this.pendencies});

  final ManagerEntity managerEntity;
  final OperatorEntity operatorEntity;
  final List<PendencyEntity> pendencies;
  @override
  State<OperatorActivityPage> createState() => _OperatorActivityPageState();
}

class _OperatorActivityPageState extends State<OperatorActivityPage> {
  final _managementController = Modular.get<ManagementController>();
  @override
  void initState() {
    super.initState();
    _managementController.enterpriseId = Modular.args.params["enterpriseId"];
    _managementController.annotationsListStore.getAllPendingAnnotations(_managementController.enterpriseId);
  }

  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    final annotations = _managementController.annotationsListStore.value.where((annotation) {
      final pendingAnnotationsIdList = widget.pendencies.map((e) => e.annotationId).toList();
      return pendingAnnotationsIdList.contains(annotation.annotationId);
    }).toList();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: appThemes.backgroundColor(context),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  color: appThemes.primaryColor(context),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    "${widget.operatorEntity.operatorName}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: sizeFrame ? height * 0.11 : height * 0.12,
              right: width * 0.06,
              child: CashNumberComponent(operatorEntity: widget.operatorEntity, backgroundColor: appThemes.surfaceColor(context), radius: 16),
            ),
            Positioned(
              top: sizeFrame ? height * 0.2 : height * 0.21,
              child: SizedBox(
                height: height * 0.28,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pendências:",
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: appThemes.surfaceColor(context),
                            ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: annotations.length,
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: OperatorPendencyCard(
                                backgroundColor: appThemes.primaryColor(context),
                                borderColor: appThemes.surfaceColor(context),
                                cardWidth: sizeFrame ? width * 0.4 : width * 0.41,
                                annotation: annotations[i],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}