import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../routes/app_routes.dart';

class OperatorController {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final cashierCodeField = TextEditingController();
  final operatorStore = Modular.get<OperatorStore>();
  final annotationsListStore = Modular.get<AnnotationsListStore>();

  final operatorCodeFormKey = GlobalKey<FormState>();
  bool? loadingOperatorSettings;

  OperatorEntity? operatorEntity;
  String? enterpriseId;
  String? operatorCode;

  Future<void> openOperatorCash(BuildContext context) async {
    if (operatorCode == operatorEntity!.operatorCode) {
      await operatorStore.openOperatorCash(
        enterpriseId ?? "",
        operatorEntity?.operatorId ?? "",
        operatorEntity?.operatorOppening ?? "",
      );
      Modular.to.navigate("${UserRoutes.operatorHomePage}$enterpriseId",
          arguments: operatorEntity);
    } else {
      wrongCodeSnackbar(context);
    }
  }

  Future<void> closeOperatorCash(BuildContext context) async {
    if (operatorCode == operatorEntity!.operatorCode) {
      await operatorStore.closeOperatorCash(
        enterpriseId ?? "",
        operatorEntity?.operatorId ?? "",
        operatorEntity?.operatorClosing ?? "",
      );
    } else {
      wrongCodeSnackbar(context);
    }
  }

  bool validOperatorCredentials(OperatorEntity operatorEntity,
      String operatorCode, String currentPassword,
      {String? operatorEmail}) {
    return currentPassword == operatorEntity.operatorPassword &&
        operatorCode == operatorEntity.operatorCode &&
        operatorEmail == operatorEntity.operatorEmail;
  }

  String? emailValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.contains('@')
        ? null
        : 'E-mail Inválido! Insira o email da conta.';
  }

  String? cashierCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6
        ? null
        : 'Código Inválido! Insira seu código Ops.';
  }

  String? passwordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8
        ? null
        : 'Senha Inválida! Sua Senha deve ter pelo menos 8 dígitos.';
  }

  modificationEmailFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'E-mail não modificado. Verifique os dados e tente novamente',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
              Icon(
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

  deletionFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Conta não deletada. Verifique os dados e tente novamente',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
              Icon(
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

  modificationPasswordFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Senha não modificada. Verifique os dados e tente novamente',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
              Icon(
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

  wrongCodeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Operação não realizada. Código inválido',
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

  noAnnotationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 5,
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nenhuma anotação no sistema',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  removeAccountWarning(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning),
                const SizedBox(height: 15),
                Text(
                  'Atenção! Esse procedimento deletará todos os seus dados e não pode ser desfeito. Deseja Continuar?',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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

  askForAccountDeletion(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning),
                const SizedBox(height: 15),
                Text(
                  'Essa operação não poderá ser desfeita.Deseja deletar sua conta permanentemente?',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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
