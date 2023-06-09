// ignore_for_file: use_build_context_synchronously

import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../enterprise_module/domain/entities/enterprise_business_position.dart';
import '../../../user_module/domain/entities/operator_entity.dart';
import '../stores/login_store.dart';

class LoginController {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final confirmationPasswordField = TextEditingController();
  final newManagerEmailField = TextEditingController();
  final newManagerPasswordField = TextEditingController();
  final managerCpfField = TextEditingController();
  final managerRgField = TextEditingController();
  final managerPhoneField = TextEditingController();
  final newOperatorEmailField = TextEditingController();
  final newOperatorPasswordField = TextEditingController();
  final cashierNameField = TextEditingController();
  final cashierCodeField = TextEditingController();
  final cashierNumberField = TextEditingController();

  final loginStore = Modular.get<LoginStore>();
  final dateValue = DateValues();
  bool loadingLoginData = false;
  bool loadingAuthData = false;
  bool startWithEnabledOperator = false;
  bool get enabledOperator => startWithEnabledOperator;
  set enabledOperator(bool status) => startWithEnabledOperator = status;
  late EnterpriseBusinessPosition userEnterpriseBusinessPosition;
  final loginFormKey = GlobalKey<FormState>();
  final createManagerFormKey = GlobalKey<FormState>();
  final createOperatorFormKey = GlobalKey<FormState>();

  final managerEntity = ManagerEntity(
      businessPosition: EnterpriseBusinessPosition.manager.position);
  final operatorEntity = OperatorEntity(
    operatorClosing: 'Pendente',
    businessPosition: EnterpriseBusinessPosition.cashOperator.position,
  );
  final loadingData = ValueNotifier(false);
  final operatorPasswordVisible = ValueNotifier(false);
  final operatorConfirmationPasswordVisible = ValueNotifier(false);
  final managerPasswordVisible = ValueNotifier(false);
  final managerConfirmationPasswordVisible = ValueNotifier(false);
  final passwordVisible = ValueNotifier(false);
  final managerUser = ValueNotifier(false);
  final businessPosition = ValueNotifier("Operador");
  String enterpriseId = "";
  String? confirmartionPassword;
  String? operatorConfirmationPassword;

  bool get userStatus => managerUser.value;
  set userStatus(bool manager) => managerUser.value = manager;
  String get userBusinessPosition => businessPosition.value;
  set userBusinessPosition(String position) =>
      businessPosition.value = managerUser.value ? "Gerente" : "Operador";

  String? emailValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.contains('@')
        ? null
        : 'E-mail Inválido! Insira o email do caixa.';
  }

  String? cpfValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 11
        ? null
        : 'Insira seu CPF';
  }

  String? rgValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 9
        ? null
        : 'Insira seu RG';
  }

  String? phoneValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Insira um número de Telefone/Celular';
  }

  String? passwordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8
        ? null
        : 'Senha Inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }

  String? confirmationPasswordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8
        ? null
        : 'Senha inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }

  String? cashierNameValidate(String? value) {
    return value!.isNotEmpty && value != ''
        ? null
        : 'Nome Inválido! Insira o nome do caixa.';
  }

  String? cashierCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6
        ? null
        : 'Código Inválido! Insira seu código Ops.';
  }

  String? enterpriseCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 8
        ? null
        : 'Código Inválido! Insira o código da Empresa';
  }

  String? cashierNumberValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' '
        ? null
        : 'Informe o número do caixa.';
  }

  registerManager() async {
    createManagerFormKey.currentState?.validate();
    if (createManagerFormKey.currentState!.validate()) {
      createManagerFormKey.currentState?.save();
      await loginStore.registerManager(
          managerEntity, enterpriseId, managerEntity.businessPosition!);
    }
  }

  registerOperator(BuildContext context) async {
    loadingData.value = true;
    createOperatorFormKey.currentState!.validate();
    operatorEntity.operatorEnabled = enabledOperator ? true : false;
    operatorEntity.operatorOppening =
        enabledOperator ? dateValue.operatorOppening : 'Pendente';
    if (createOperatorFormKey.currentState!.validate()) {
      createOperatorFormKey.currentState!.save();
      if (operatorEntity.operatorPassword == operatorConfirmationPassword) {
        final newOperator = await loginStore
            .register(
              operatorEntity,
              enterpriseId,
              operatorEntity.businessPosition!,
            )
            ?.then((value) => value)
            .catchError((e) {
          if (e.toString().contains("already-in-use")) {
            registrationFail(context, message: "Email já utilizado");
          } else {
            const String message = "Erro desconhecido";
            registrationFail(context, message: message);
          }
        });
        if (newOperator != null) {
          operatorCreatedSucessfully(context);
          Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId",
              arguments: newOperator);
          loadingData.value = false;
        } else {
          onFail(context);
          loadingData.value = false;
        }
      } else {
        noMatchingPasswords(context, message: "As senhas não correspondem");
        loadingData.value = false;
      }
    }
    loadingData.value = false;
  }

  void login() async {
    loadingData.value = true;
    managerUser.value
        ? userEnterpriseBusinessPosition = EnterpriseBusinessPosition.manager
        : userEnterpriseBusinessPosition =
            EnterpriseBusinessPosition.cashOperator;
    loginFormKey.currentState!.validate();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      await loginStore.login(emailField.text, passwordField.text, enterpriseId,
          userEnterpriseBusinessPosition.position);
      loadingData.value = false;
    }
    loadingData.value = false;
  }

  onFail(BuildContext context) {
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
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Login não realizado, tente Novamente!',
                style: Theme.of(context).textTheme.displaySmall,
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

  registrationFail(BuildContext context, {required String message}) {
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

  recoveryTrialFail(BuildContext context) {
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
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            'As senhas não correspondem.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

  checkInformationTrialFail(BuildContext context) {
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
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            'Dados não localizados. Tente novamente.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }

  onSuccess(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              'Olá!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  operatorCreatedSucessfully(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              'Usuário criado com sucesso!',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  showSignOutDialog(
      BuildContext context, Color color, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.surface;
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Deseja Sair?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: surfaceColor)),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                          side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Sim',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: surfaceColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      style: TextButton.styleFrom(
                          side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Não',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: surfaceColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

enum DrawerPagePosition { home, profile, settings }
