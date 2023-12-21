// ignore_for_file: use_build_context_synchronously

import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/check_user_data_bloc/check_user_data_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_events.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_bloc.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';
import '../../../enterprise_module/domain/entities/enterprise_business_position.dart';
import '../../../user_module/domain/entities/operator_entity.dart';
import '../blocs/create_operator_bloc/create_operator_bloc.dart';
import '../blocs/create_operator_bloc/create_operator_events.dart';

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

//BLOCS
  final authBloc = Modular.get<AuthBloc>();
  final createManagerBloc = Modular.get<CreateManagerBloc>();
  final createOperatorBloc = Modular.get<CreateOperatorBloc>();
  final checkUserDataBloc = Modular.get<CheckUserDataBloc>();
  final managerBloc = Modular.get<ManagerBloc>();
  final operatorBloc = Modular.get<OperatorBloc>();
  //
  late String userEmail;
  late String userCode;
  late String userCollection;
  final dateValue = DateValues();
  bool startWithEnabledOperator = false;
  bool get enabledOperator => startWithEnabledOperator;
  set enabledOperator(bool status) => startWithEnabledOperator = status;
  late EnterpriseBusinessPosition userEnterpriseBusinessPosition;
  final loginFormKey = GlobalKey<FormState>();
  final createManagerFormKey = GlobalKey<FormState>();
  final createOperatorFormKey = GlobalKey<FormState>();
  final checkOperatorDataFormKey = GlobalKey<FormState>();

  var managerEntity = ManagerEntity(businessPosition: EnterpriseBusinessPosition.manager.position);
  var operatorEntity = OperatorEntity(
    operatorClosing: 'Pendente',
    businessPosition: EnterpriseBusinessPosition.cashOperator.position,
  );
  EnterpriseEntity entepriseEntity = EnterpriseEntity();

  final operatorPasswordVisible = ValueNotifier(false);
  final operatorConfirmationPasswordVisible = ValueNotifier(false);
  final managerPasswordVisible = ValueNotifier(false);
  final managerConfirmationPasswordVisible = ValueNotifier(false);
  final passwordVisible = ValueNotifier(false);
  final managerUser = ValueNotifier(false);
  final businessPosition = ValueNotifier("Operador");
  List<OperatorEntity> operatorsList = [];
  String enterpriseId = "";
  String? confirmartionPassword;
  String? operatorConfirmationPassword;

  bool get userStatus => managerUser.value;
  set userStatus(bool manager) => managerUser.value = manager;
  String get userBusinessPosition => businessPosition.value;
  set userBusinessPosition(String position) => businessPosition.value = managerUser.value ? "Gerente" : "Operador";

  String? emailValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.contains('@') ? null : 'E-mail Inválido! Insira o email do caixa.';
  }

  String? cpfValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 11 ? null : 'Insira seu CPF';
  }

  String? rgValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 9 ? null : 'Insira seu RG';
  }

  String? phoneValidate(String? value) {
    return value!.isNotEmpty && value != '' ? null : 'Insira um número de Telefone/Celular';
  }

  String? passwordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8 ? null : 'Senha Inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }

  String? confirmationPasswordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8 ? null : 'Senha inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }

  String? cashierNameValidate(String? value) {
    return value!.isNotEmpty && value != '' ? null : 'Nome Inválido! Insira o nome do caixa.';
  }

  String? cashierCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6 ? null : 'Código Inválido! Insira seu código Ops.';
  }

  String? enterpriseCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 8 ? null : 'Código Inválido! Insira o código da Empresa';
  }

  String? cashierNumberValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' ' ? null : 'Informe o número do caixa.';
  }

  void createManager(BuildContext context) {
    createManagerFormKey.currentState!.validate();
    if (createManagerFormKey.currentState!.validate()) {
      createManagerFormKey.currentState!.save();
      if (confirmartionPassword == managerEntity.managerPassword) {
        createManagerBloc.add(CreateManagerEvent(enterpriseId, managerEntity.businessPosition!, managerEntity));
      } else {
        noMatchingPasswords(context, message: "As senhas não correspondem");
      }
    }
  }

  void createOperator(BuildContext context) {
    createOperatorFormKey.currentState?.validate();
    if (createOperatorFormKey.currentState!.validate()) {
      createOperatorFormKey.currentState?.save();
      if (operatorConfirmationPassword == operatorEntity.operatorPassword) {
        operatorEntity.hasPendencies = false;
        operatorEntity.operatorEnabled = startWithEnabledOperator ? true : false;
        operatorEntity.operatorOppening = startWithEnabledOperator ? dateValue.operatorOppening : "Pendente";
        operatorEntity.operatorId = "operatorId";
        operatorEntity.operatorCode = "operatorCode";
        createOperatorBloc.add(CreateOperatorEvent(enterpriseId, operatorEntity.businessPosition!, operatorEntity));
      } else {
        noMatchingPasswords(context, message: "As senhas não correspondem");
      }
    }
  }

  void login() async {
    managerUser.value ? userEnterpriseBusinessPosition = EnterpriseBusinessPosition.manager : userEnterpriseBusinessPosition = EnterpriseBusinessPosition.cashOperator;
    loginFormKey.currentState?.validate();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      authBloc.add(LoginEvent(entepriseEntity.enterpriseId!, emailField.text, passwordField.text, userEnterpriseBusinessPosition.position));
      emailField.clear();
      passwordField.clear();
    }
  }

  void checkUserData() {
    checkOperatorDataFormKey.currentState!.validate();
    if (checkOperatorDataFormKey.currentState!.validate()) {
      checkUserDataBloc.add(CheckUserDataEvent(enterpriseId, userEmail, userCode, userCollection));
    }
    emailField.clear();
    cashierCodeField.clear();
  }

  void signOut() async {
    authBloc.add(AuthSignOutEvent());
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
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
            ),
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

  showSignOutDialog(BuildContext context, Color color, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.surface;
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Deseja Sair?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: surfaceColor)),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Sim',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: surfaceColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      style: TextButton.styleFrom(side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Não',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: surfaceColor),
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

  showUserOptionsDialog(BuildContext context, Color color) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.surface;
        final appThemes = CashHelperThemes();
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Criar conta para:', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17, color: surfaceColor)),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Modular.to.pop();
                        Modular.to.pushNamed("./${LoginRoutes.createOperator}", arguments: entepriseEntity);
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          backgroundColor: appThemes.greenColor(context),
                          side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Operador',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: surfaceColor),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Modular.to.pop();
                        Modular.to.pushNamed("./${LoginRoutes.createManager}", arguments: entepriseEntity);
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          backgroundColor: appThemes.blueColor(context),
                          side: BorderSide(color: surfaceColor)),
                      child: Text(
                        'Gerente',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: surfaceColor),
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
