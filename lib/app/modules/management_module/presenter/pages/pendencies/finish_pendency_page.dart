import 'package:cash_helper_app/app/modules/login_module/presenter/components/cash_helper_text_field.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/components/pendency_finishing_widget.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/components/buttons/manager_view_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/themes/cash_helper_themes.dart';
import '../../../../annotations_module/domain/entities/annotation_entity.dart';
import '../../../../user_module/domain/entities/manager_entity.dart';
import '../../../../user_module/presenter/components/operator_widgets/cash_number_component.dart';
import '../../controller/management_controller.dart';

class FinishPendencyPage extends StatefulWidget {
  const FinishPendencyPage({super.key, required this.managerEntity, required this.operatorEntity, required this.annotation, required this.pendency});

  final ManagerEntity managerEntity;
  final OperatorEntity operatorEntity;
  final AnnotationEntity annotation;
  final PendencyEntity pendency;
  @override
  State<FinishPendencyPage> createState() => _FinishPendencyPageState();
}

final _managementController = Modular.get<ManagementController>();

class _FinishPendencyPageState extends State<FinishPendencyPage> {
  @override
  void initState() {
    super.initState();
    _managementController.enterpriseId = Modular.args.params["enterpriseId"];
    _managementController.pendencyId = widget.pendency.pendencyId!;
    _managementController.manager = widget.managerEntity;
  }

  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final sizeFrame = height <= 800.0;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
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
                child: CashNumberComponent(
                  operatorEntity: widget.operatorEntity,
                  backgroundColor: appThemes.surfaceColor(context),
                  radius: 16,
                ),
              ),
              Positioned(
                top: sizeFrame ? height * 0.29 : height * 0.3,
                child: PendencyFinishingWidget(
                  annotation: widget.annotation,
                  height: height,
                  width: width,
                ),
              ),
              Positioned(
                top: sizeFrame ? height * 0.56 : height * 0.57,
                left: height * 0.027,
                child: Center(
                  child: Form(
                    key: _managementController.finishPendencyFormKey,
                    child: SizedBox(
                      height: 50,
                      width: width * 0.9,
                      child: CashHelperTextFieldComponent(
                        validator: _managementController.managerCodeValidate,
                        controller: _managementController.managerFinishCodeField,
                        primaryColor: appThemes.surfaceColor(context),
                        onSaved: (value) => _managementController.managerCode = value,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: sizeFrame ? height * 0.65 : height * 0.66,
                left: height * 0.027,
                child: Center(
                  child: SizedBox(
                    height: 50,
                    width: width * 0.9,
                    child: ManagerViewButton(
                      text: "Finalizar",
                      onPressed: () => _managementController.finishPedency(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
