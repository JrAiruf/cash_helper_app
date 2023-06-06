import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user_module/presenter/components/cash_helper_bottom_navigation_bar.dart';
import '../date_values/date_values.dart';
import '../stores/annotations_list_store.dart';
import '../stores/annotations_store.dart';

class AnnotationsController {
  final annotationAddressField = TextEditingController();
  final annotationValueField = TextEditingController();
  final annotationPaymentMethodField = TextEditingController();
  final annotationSaleTimeField = TextEditingController();
  final dateValue = DateValues();
  final _annotationsStore = Modular.get<AnnotationStore>();
  final _annotationsListStore = Modular.get<AnnotationsListStore>();
  final annotationsPageController = PageController();

  String get annotationClientAddress => annotationAddressField.text;

  String get annotationSaleTime => annotationSaleTimeField.text;

  String get annotationPaymentMethod => annotationPaymentMethodField.text;

  String get annotationValue => annotationValueField.text;

  BottomNavigationBarPosition? position;

  final newAnnotationFormKey = GlobalKey<FormState>();
  final annotationLoadingState = ValueNotifier(false);

  String enterpriseId = "";
  String operatorId = "";
  String annotationId = "";
  List<AnnotationEntity> annotationsList = [];
  String? annotationAddressValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Endereço Inválido! Informe o rua e número.';
  }

  String? annotationValueValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Valor Inválido! Insira o valor da compra feita.';
  }

  Future<void> createAnnotation(OperatorEntity operatorEntity) async {
    newAnnotationFormKey.currentState!.validate();
    if (newAnnotationFormKey.currentState!.validate()) {
      annotationLoadingState.value = true;
      newAnnotationFormKey.currentState?.save();
      final newAnnotation = AnnotationEntity(
          annotationClientAddress: annotationClientAddress,
          annotationConcluied: false,
          annotationReminder: "AnnotationReminder",
          annotationSaleDate: dateValue.annotationDayDateTime,
          annotationSaleTime: annotationSaleTime,
          annotationPaymentMethod: annotationPaymentMethod,
          annotationId: "AnnotationId",
          annotationSaleValue: annotationValue);
      await _annotationsStore.createNewAnnotation(
          enterpriseId, operatorId, newAnnotation);
      final operatorAndAnnotationObjects = {
        "operatorEntity": operatorEntity,
        "annotationEntity": newAnnotation,
      };
      Modular.to.pushNamed("${AnnotationRoutes.annotationPage}$enterpriseId",
          arguments: operatorAndAnnotationObjects);
      annotationLoadingState.value = false;
    } else {
      return;
    }
  }

  Future<void> getAllAnnotations() async {
    annotationsList = _annotationsListStore.value;
  }

  Future<void> finishAnnotation(OperatorEntity operatorEntity) async {
    annotationLoadingState.value = true;
    await _annotationsStore.finishAnnotation(
        enterpriseId, operatorId, annotationId);
    Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId",
        arguments: operatorEntity);
    annotationLoadingState.value = false;
  }
}
