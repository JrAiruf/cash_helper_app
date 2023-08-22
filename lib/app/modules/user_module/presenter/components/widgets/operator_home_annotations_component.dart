import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/get_all_annotations_bloc/get_annotations_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'annotation_info_list_view_component.dart';

class OperatorHomeAnnotationsComponent extends StatefulWidget {
  const OperatorHomeAnnotationsComponent({super.key, required this.operatorEntity, required this.enterpriseId});
  final OperatorEntity operatorEntity;
  final String enterpriseId;
  @override
  State<OperatorHomeAnnotationsComponent> createState() => _OperatorHomeAnnotationsComponentState();
}

final _annotationsController = Modular.get<AnnotationsController>();

class _OperatorHomeAnnotationsComponentState extends State<OperatorHomeAnnotationsComponent> {
  @override
  void initState() {
    super.initState();
    _annotationsController.enterpriseId = widget.enterpriseId;
    _annotationsController.getAllAnnotations();
  }

  @override
  Widget build(BuildContext context) {
    final appThemes = CashHelperThemes();
    return BlocBuilder<GetAnnotationsBloc, GetAnnotationsStates>(
      bloc: _annotationsController.getAnnotationsBloc,
      builder: (_, state) {
        if (state is GetAnnotationsLoadingState) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: LinearProgressIndicator(
                color: appThemes.greenColor(context),
              ),
            ),
          );
        }
        if (state is GetAnnotationsSuccessState) {
          final annotations = state.annotations.where((annotation) => annotation.annotationCreatorId == widget.operatorEntity.operatorId && !annotation.annotationWithPendency!).toList();
          return AnnotationInfoListViewComponent(
            annotations: annotations,
          );
        }
        return Container();
      },
    );
  }
}
