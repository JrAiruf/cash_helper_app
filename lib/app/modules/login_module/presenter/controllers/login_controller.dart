// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  bool loadingData = false;
  bool loadingLoginData = false;
  bool loadingAuthData = false;
  DrawerPagePosition? drawerPosition;
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

  String? cashierNumberValidate(String? value) {
    return value!.isNotEmpty && value != '' && value != ' '
        ? null
        : 'Informe o número do caixa.';
  }

  onFail(BuildContext context) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.redAccent,
        elevation: 5,
        duration: const Duration(seconds: 5),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Text(
                'Erro: $message',
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

  recoveryTrialFail(BuildContext context) {
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
                'As senhas não correspondem.',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
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

  checkInformationTrialFail(BuildContext context) {
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
                'Dados não localizados. Tente novamente.',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
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

  onSuccess(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.greenAccent,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Boas Vindas',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Icon(
                Icons.verified_outlined,
                size: 35,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  operatorCreatedSucessfully(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        elevation: 5,
        duration: const Duration(seconds: 2),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Usuário criado com sucesso!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Icon(
                Icons.done,
                size: 35,
                color: Colors.white,
              )
            ],
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
