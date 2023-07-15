import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_store.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/payment_methods_list_store.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/pendencies_list_store.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/pendency_states.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/pendency_store.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../annotations_module/presenter/stores/annotations_list_store.dart';
import '../../../login_module/presenter/stores/login_store.dart';

class ManagementController {
  final paymentMethodNameField = TextEditingController();
  final paymentMethodDescriptionField = TextEditingController();
  final managerCodeField = TextEditingController();

  var paymentMethods = ValueNotifier(<PaymentMethodEntity>[]);
  var pendencies = ValueNotifier(<PendencyEntity>[]);
  var operatorsList = <OperatorEntity>[];
  var operatorAnnotations = ValueNotifier(<AnnotationEntity>[]);
  var operatorsPendencies = ValueNotifier(<PendencyEntity>[]);
  final operatorsWithPendencies = ValueNotifier(<String>[]);
  final periodList = ValueNotifier(<String>[]);

  final paymentMethodsListStore = Modular.get<PaymentMethodsListStore>();
  final _loginStore = Modular.get<LoginStore>();
  final managementStore = Modular.get<ManagementStore>();
  final pendencyStore = Modular.get<PendencyStore>();
  final pendenciesListStore = Modular.get<PendenciesListStore>();
  final annotationsListStore = Modular.get<AnnotationsListStore>();
  String enterpriseId = "";

  String? paymentMethodNameValidate(String? value) {
    return value!.isNotEmpty ? null : 'Insira o nome do método de pagamento';
  }

  String? managerCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6 ? null : 'Código Inválido! Insira o código administrativo.';
  }

  String? paymentMethodValidate(PaymentMethodEntity? value) {
    return value != null ? null : 'Campo obrigatório.';
  }

  Future<void> getAllPaymentMethods(String enterpriseId) async {
    await paymentMethodsListStore.getAllPaymentMethods(enterpriseId);
    paymentMethods.value = paymentMethodsListStore.value ?? [];
  }

  Future<void> getAllPendencies() async {
    await pendenciesListStore.getAllPendencies(enterpriseId);
    if (pendencies.value.isNotEmpty) {
      final operatorIdList = pendencies.value.map((e) => e.operatorId).toList();
      final pendenciesPeriodList = pendencies.value.map((e) => e.pendencyPeriod).toList();
      operatorsWithPendencies.value.clear();
      periodList.value.clear();
      for (var id in operatorIdList) {
        if (!operatorsWithPendencies.value.contains(id)) {
          operatorsWithPendencies.value.add(id!);
        }
      }
      for (var period in pendenciesPeriodList) {
        if (!periodList.value.contains(period)) {
          periodList.value.add(period!);
        }
      }
    } else {
      return;
    }
  }

  Future<void>? getAnnotationsByOperator(String operatorId) async {
    final operatorAnnotationsList = annotationsListStore.value.where((annotation) => annotation.annotationCreatorId == operatorId).toList();
    operatorAnnotations.value.clear();
    operatorAnnotations.value.addAll(operatorAnnotationsList);
  }


  Future<void>? getAllOperatorsWithPendencies(String enterpriseId) async {
    final operators = await _loginStore.getAllOperators(enterpriseId);
    final operatorWithPendenciesList = operators?.where((operatorEntity) => operatorsWithPendencies.value.contains(operatorEntity.operatorId)).toList();
    operatorsList.clear();
    for (var operatorEntity in operatorWithPendenciesList!) {
      if (!operatorsList.contains(operatorEntity)) {
        operatorsList.add(operatorEntity);
      }
    }
  }

  noMatchingCodes(BuildContext context, {required String message}) {
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

  paymentMethodRemovedSnackBar(BuildContext context, {required String message}) {
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: variantColor.withOpacity(0.5),
        elevation: 5,
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  paymentMethodAddedSnackBar(BuildContext context, {required String message}) {
    final variantColor = Theme.of(context).colorScheme.surfaceVariant;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: variantColor.withOpacity(0.5),
        elevation: 5,
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
