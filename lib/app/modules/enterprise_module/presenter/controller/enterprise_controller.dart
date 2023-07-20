import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_bloc.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../domain/entities/enterprise_entity.dart';
import '../stores/enterprise_store.dart';

class EnterpriseController {
  final cnpjField = TextEditingController();
  final enterpriseNameField = TextEditingController();
  final enterpriseCodeField = TextEditingController();
  final cityField = TextEditingController();
  final cepField = TextEditingController();
  final stateField = TextEditingController();
  final streetField = TextEditingController();
  final addressNumberField = TextEditingController();
  final phoneNumberField = TextEditingController();
  final enterpriseEmailField = TextEditingController();
  final newEnterprisePasswordField = TextEditingController();
  final confirmationPasswordField = TextEditingController();

  final enterpriseEntity = EnterpriseEntity();
  String confirmationPassword = "";

  final enterpriseStore = Modular.get<EnterpriseStore>();
  final createEnterpriseBloc = Modular.get<CreateEnterpriseBLoc>();
  final enterpriseFormKey = GlobalKey<FormState>();
  final createEnterpriseFormKey = GlobalKey<FormState>();
  bool loadingData = false;

  final passwordVisible = ValueNotifier(false);
  final confirmPasswordVisible = ValueNotifier(false);
  final loadingEnterpriseAuth = ValueNotifier(false);
  final codeVisible = ValueNotifier(false);

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
    return value!.isNotEmpty && value != '' ? null : 'Insira um nome válido.';
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
    return value!.isNotEmpty && value != '' ? null : 'Insira o CEP';
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

  void nextRegistrationStep() {
    enterpriseFormKey.currentState!.validate();
    if (enterpriseFormKey.currentState!.validate()) {
      enterpriseFormKey.currentState?.save();
      Modular.to.pushNamed(EnterpriseRoutes.createEnterprise,
          arguments: enterpriseEntity);
    }
  }

  finishEnterpriseRegistration(BuildContext context) {
    createEnterpriseFormKey.currentState?.validate();
    createEnterpriseFormKey.currentState?.save();
    if (createEnterpriseFormKey.currentState!.validate()) {
      if (confirmationPassword == enterpriseEntity.enterprisePassword) {
        // enterpriseStore.createEnterpriseAccount(enterpriseEntity);
        createEnterpriseBloc.add(CreateEnterpriseEvent(enterpriseEntity));
      } else {
        noMatchingPasswords(context, message: "As senhas não correspondem");
      }
    }
  }

  void authenticateEnterprise(BuildContext context) async {
    enterpriseFormKey.currentState?.validate();
    if (enterpriseFormKey.currentState!.validate()) {
      loadingEnterpriseAuth.value = true;
      enterpriseFormKey.currentState?.save();
      final enterprise = await enterpriseStore
          .getEnterpriseByCode(enterpriseCodeField.text)
          .catchError((e) {
        enterpriseNotFound(context,
            message: "Código Inválido! Digite o cógido da sua empresa");
        loadingEnterpriseAuth.value = false;
        return null;
      });
      if (enterprise != null) {
        Modular.to.navigate(LoginRoutes.login, arguments: enterprise);
        loadingEnterpriseAuth.value = false;
      }
    }
  }

  noMatchingPasswords(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 5),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

  enterpriseNotFound(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 5),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
