import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/payment_methods_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../stores/pendency_store.dart';

class ManagementController {
  ManagementController();
  final paymentMethodNameField = TextEditingController();
  final paymentMethodDescriptionField = TextEditingController();
  final managerCodeField = TextEditingController();

  var paymentMethods = ValueNotifier(<PaymentMethodEntity>[]);
  final paymentMethodsListStore = Modular.get<PaymentMethodsListStore>();
  final pendencyStore = Modular.get<PendencyStore>();
  
  String? paymentMethodNameValidate(String? value) {
    return value!.isNotEmpty ? null : 'Insira o nome do método de pagamento';
  }

  String? managerCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6
        ? null
        : 'Código Inválido! Insira o código administrativo.';
  }

  String? paymentMethodValidate(PaymentMethodEntity? value) {
    return value != null ? null : 'Campo obrigatório.';
  }

  Future<void> getAllPaymentMethods(String enterpriseId) async {
    await paymentMethodsListStore.getAllPaymentMethods(enterpriseId);
    paymentMethods.value = paymentMethodsListStore.value ?? [];
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

  paymentMethodRemovedSnackBar(BuildContext context,
      {required String message}) {
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
