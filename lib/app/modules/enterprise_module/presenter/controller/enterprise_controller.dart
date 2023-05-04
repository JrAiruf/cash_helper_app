import 'package:flutter/material.dart';

class EnterpriseController {
  final cnpjField = TextEditingController();
  final enterpriseNameField = TextEditingController();
  final cityField = TextEditingController();
  final cepField = TextEditingController();
  final stateField = TextEditingController();
  final streetField = TextEditingController();
  final addressNumberField = TextEditingController();
  final phoneNumberField = TextEditingController();
  final enterpriseEmailField = TextEditingController();
  final newEnterprisePasswordField = TextEditingController();
  final confirmationPasswordField = TextEditingController();

  bool loadingData = false;

  String? cnpjValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insira o CNPJ da empresa.';
  }

  String? enterpriseNameValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insira um nome válido.';
  }

  String? cityValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insiar o nome onde sua empresa está situada';
  }

  String? cepValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insira o CEP';
  }

  String? stateValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insira o Estado da Empresa';
  }

  String? streetValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' '
        ? null
        : 'Informe a rua de endereço da empresa.';
  }
  String? addressNumberValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' '
        ? null
        : 'Informe o número de endereço da empresa.';
  }
  String? phoneNumberValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' '
        ? null
        : 'Informe o número de telefone da empresa.';
  }
}
