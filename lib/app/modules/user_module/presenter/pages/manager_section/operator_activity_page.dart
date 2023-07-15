import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../components/operator_widgets/cash_number_component.dart';

class OperatorActivityPage extends StatefulWidget {
  const OperatorActivityPage({super.key,  required this.managerEntity,required this.operatorEntity, required this.pendencies});

  final ManagerEntity managerEntity;
  final OperatorEntity operatorEntity;
  final List<PendencyEntity> pendencies;
  @override
  State<OperatorActivityPage> createState() => _OperatorActivityPageState();
}

class _OperatorActivityPageState extends State<OperatorActivityPage> {
  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    return Container(
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
            ),
          ),
          Positioned(
            top: sizeFrame ? height * 0.11 : height * 0.12,
            left: width * 0.02,
            child: SizedBox(
              width: width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CashNumberComponent(operatorEntity: widget.operatorEntity, backgroundColor: appThemes.surfaceColor(context), radius: 16),
                  Text(
                    "${widget.operatorEntity.operatorName}",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: appThemes.surfaceColor(context),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
