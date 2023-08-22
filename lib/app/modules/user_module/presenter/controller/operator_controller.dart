import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/update_annotation_bloc/update_annotation_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/date_values/date_values.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../routes/app_routes.dart';
import '../../../annotations_module/domain/entities/annotation_entity.dart';
import '../../../management_module/presenter/blocs/generate_pendency_bloc/generate_pendency_bloc.dart';
import '../blocs/operator_closing_bloc/operator_closing_bloc.dart';
import '../blocs/operator_oppening_bloc/operator_oppening_bloc.dart';

class OperatorController {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final cashierCodeField = TextEditingController();
  final operatorOppeningBloc = Modular.get<OperatorOppeningBloc>();
  final operatorClosingBloc = Modular.get<OperatorClosingBloc>();
  final generatePendencyBloc = Modular.get<GeneratePendencyBloc>();
  final updateAnnotationBloc = Modular.get<UpdateAnnotationBloc>();

  final dateValue = DateValues();
  final operatorCodeFormKey = GlobalKey<FormState>();
  bool? loadingOperatorSettings;

  List<AnnotationEntity> operatorAnnotations = [];
  OperatorEntity? operatorEntity;
  String? enterpriseId;
  String? operatorCode;
  String? annotationId;

  Future<void> openOperatorCash(BuildContext context) async {
    operatorCodeFormKey.currentState!.validate();
    operatorCodeFormKey.currentState!.save();
    if (cashierCodeField.text == operatorEntity!.operatorCode) {
      operatorEntity?.operatorOppening = dateValue.operatorOppening;
      operatorOppeningBloc.add(OperatorOppeningEvent(enterpriseId!, operatorEntity!));
    } else {
      operatorCodeFormKey.currentState!.reset();
      wrongCodeSnackbar(context);
    }
  }

  Future<void> closeOperatorCash(BuildContext context, Color color) async {
    final unfinishedAnnotations = operatorAnnotations.where(((annotation) => !annotation.annotationConcluied!)).toList();
    cashClosingDialog(context, color, () async {
      if (unfinishedAnnotations.isNotEmpty) {
        Modular.to.pop();
        cashClosingConfirmationDialog(context, color, () async {
          for (var annotation in unfinishedAnnotations) {
            PendencyEntity pendency = PendencyEntity(
              annotationId: annotation.annotationId,
              pendencyFinished: false,
              operatorId: operatorEntity!.operatorId,
              pendencySaleTime: annotation.annotationSaleTime,
              pendencySaleDate: annotation.annotationSaleDate,
            );
            generatePendencyBloc.add(GeneratePendencyEvent(enterpriseId!, pendency));
            annotation.annotationWithPendency = true;
            updateAnnotationBloc.add(UpdateAnnotationEvent(enterpriseId!, annotation));
          }
          operatorClosingBloc.add(OperatorClosingEvent(enterpriseId!, operatorEntity!.operatorId!, operatorEntity!.operatorClosing!));
        });
      } else {
        operatorClosingBloc.add(OperatorClosingEvent(enterpriseId!, operatorEntity!.operatorId!, operatorEntity!.operatorClosing!));
      }
    });
  }

  bool validOperatorCredentials(OperatorEntity operatorEntity, String operatorCode, String currentPassword, {String? operatorEmail}) {
    return currentPassword == operatorEntity.operatorPassword && operatorCode == operatorEntity.operatorCode && operatorEmail == operatorEntity.operatorEmail;
  }

  String? emailValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.contains('@') ? null : 'E-mail Inválido! Insira o email da conta.';
  }

  String? cashierCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6 ? null : 'Código Inválido! Insira seu código Ops.';
  }

  String? passwordValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length >= 8 ? null : 'Senha Inválida! Sua Senha deve ter pelo menos 8 dígitos.';
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'E-mail não modificado. Verifique os dados e tente novamente',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Conta não deletada. Verifique os dados e tente novamente',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Senha não modificada. Verifique os dados e tente novamente',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
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

  operatorDisabledSnackbar(BuildContext context) {
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
                'Seu caixa ainda não foi aberto. Abra o caixa para realizar operações.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  removeAccountWarning(BuildContext context, Color color, void Function()? onPressed) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning),
                const SizedBox(height: 15),
                Text(
                  'Atenção! Esse procedimento deletará todos os seus dados e não pode ser desfeito. Deseja Continuar?',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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

  cashClosingDialog(BuildContext context, Color color, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.onSurface;
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: surfaceColor,
                ),
                const SizedBox(height: 15),
                Text(
                  'Deseja fechar o caixa?',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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

  cashClosingConfirmationDialog(BuildContext context, Color color, void Function()? onPressed) {
    showDialog(
      context: context,
      builder: (_) {
        final surfaceColor = Theme.of(context).colorScheme.onSurface;
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: surfaceColor,
                ),
                const SizedBox(height: 15),
                Text(
                  'Ainda existem anotações pendentes.Deseja fechar mesmo assim?',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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

  askForAccountDeletion(BuildContext context, Color color, void Function()? onPressed) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.warning),
                const SizedBox(height: 15),
                Text(
                  'Essa operação não poderá ser desfeita.Deseja deletar sua conta permanentemente?',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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
}
