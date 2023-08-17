// ignore_for_file: use_build_context_synchronously

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/finish_pendency_bloc/finish_pendency_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_events.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_events.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/pendency_occurrance_bloc/pendency_ocurrance_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/get_recent_activities_bloc/get_recent_activities_bloc.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManagementController {
  final paymentMethodFormKey = GlobalKey<FormState>();
  final finishPendencyFormKey = GlobalKey<FormState>();
  final paymentMethodNameField = TextEditingController();
  final paymentMethodDescriptionField = TextEditingController();
  final managerCodeField = TextEditingController();
  final managerFinishCodeField = TextEditingController();
  var paymentMethods = ValueNotifier(<PaymentMethodEntity>[]);
  var pendencies = ValueNotifier(<PendencyEntity>[]);
  var operatorsList = <OperatorEntity>[];
  var operatorAnnotations = ValueNotifier(<AnnotationEntity>[]);
  var operatorPendingAnnotations = ValueNotifier(<AnnotationEntity>[]);
  var operatorsPendencies = ValueNotifier(<PendencyEntity>[]);
  final operatorsWithPendencies = ValueNotifier(<String>[]);
  final periodList = ValueNotifier(<String>[]);

// Blocs
  final paymentMethodBloc = Modular.get<PaymentMethodsBloc>();
  final paymentMethodsListBloc = Modular.get<PaymentMethodsListBloc>();
  final getRecentActivitiesBloc = Modular.get<GetRecentActivitiesBloc>();
  final pendencyOcurranceBloc = Modular.get<PendencyOcurranceBloc>();
  final finishPendencyBloc = Modular.get<FinishPendencyBloc>();

  ValueNotifier managementCodeVisible = ValueNotifier(true);
  String enterpriseId = "";
  String pendencyId = "";
  String? managerCode;
  ManagerEntity? manager;
  final newPaymentMethod = PaymentMethodEntity();
  String? paymentMethodNameValidate(String? value) {
    return value!.isNotEmpty ? null : 'Insira o nome do método de pagamento';
  }

  String? managerCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6 ? null : 'Código Inválido! Insira o código administrativo.';
  }

  String? paymentMethodValidate(PaymentMethodEntity? value) {
    return value != null ? null : 'Campo obrigatório.';
  }

  Future<void> createPaymentMethod(BuildContext context) async {
    paymentMethodFormKey.currentState?.validate();
    paymentMethodFormKey.currentState?.save();
    if (paymentMethodFormKey.currentState!.validate()) {
      if (managerCode == manager?.managerCode) {
        newPaymentMethod.paymentMethodUsingRate = 0;
        paymentMethodBloc.add(CreateNewPaymentMethodEvent(enterpriseId, newPaymentMethod));
        paymentMethodAddedSnackBar(
          context,
          message: "Novo método de pagamento adicionado!",
        );
      } else {
        noMatchingCodes(
          context,
          message: "Código Administrativo Inválido!",
        );
      }
    }
  }

  void finishPedency(BuildContext context) {
    finishPendencyFormKey.currentState!.validate();
    finishPendencyFormKey.currentState!.save();
    if (finishPendencyFormKey.currentState!.validate() && managerCode == manager!.managerCode) {
      finishPendencyBloc.add(FinishPendencyEvent(enterpriseId, pendencyId));
      Modular.to.navigate("${UserRoutes.managementPage}$enterpriseId", arguments: manager);
    } else {
      noMatchingCodes(context, message: "Código inválido! Digite seu códio Ops");
    }
  }

  void getAllPaymentMethods() {
    paymentMethodsListBloc.add(GetAllPaymentMethodsEvent(enterpriseId));
  }

  Future<void> getAllRecentActivities() async {
    getRecentActivitiesBloc.add(GetRecentActivitiesEvent(enterpriseId));
  }

  Future<void> getPendencyOcurrances() async {
    pendencyOcurranceBloc.add(PendencyOcurranceEvent(enterpriseId));
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

  finishedPendencies(BuildContext context, {required String message}) {
    final appThemes = CashHelperThemes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: appThemes.blueColor(context),
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
