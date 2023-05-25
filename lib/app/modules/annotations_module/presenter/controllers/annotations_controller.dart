import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../date_values/date_values.dart';
import '../stores/annotations_store.dart';

class AnnotationsController {
  final annotationAddressField = TextEditingController();
  final annotationValueField = TextEditingController();
  final annotationPaymentMethodField = TextEditingController();
  final annotationSaleTimeField = TextEditingController();
  final dateValue = DateValues();
  final _annotationsStore = Modular.get<AnnotationStore>();
  String get annotationClientAddress => annotationAddressField.text;
  String get annotationSaleTime => annotationSaleTimeField.text;
  String get annotationPaymentMethod => annotationPaymentMethodField.text;
  String get annotationValue => annotationValueField.text;

  String enterpriseId = "";
  String operatorId = "";
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

  void createAnnotation() async {
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
  }
}
