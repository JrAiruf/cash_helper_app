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


 String? passwordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8
        ? null
        : 'Senha Inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }
  
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
  String? enterpriseEmailValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.contains("@")
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

  noMatchingPasswords(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 5),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Icon(
                Icons.warning_rounded,
                size: 35,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
