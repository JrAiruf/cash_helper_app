import 'package:flutter/material.dart';

class AnnotationsController {
  final annotationAddressField = TextEditingController();
  final annotationValue = TextEditingController();
  final annotationSaleTime = TextEditingController();

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
}
