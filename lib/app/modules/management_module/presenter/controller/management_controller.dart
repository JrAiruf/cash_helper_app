import 'package:flutter/material.dart';

class ManagementController {
  final paymentMethodNameField = TextEditingController();
  final paymentMethodDescriptionField = TextEditingController();
  final managerCodeField = TextEditingController();

  String? paymentMethodNameValidate(String? value) {
    return value!.isNotEmpty
        ? null
        : 'Insira o nome do método de pagamento';
  }

  String? managerCodeValidate(String? value) {
    return value!.isNotEmpty && value != '' && value.length == 6
        ? null
        : 'Código Inválido! Insira o código administrativo.';
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
}
