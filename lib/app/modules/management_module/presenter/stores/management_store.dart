import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_all_payment_methods/iget_all_payment_methods.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class ManagementStore extends ValueNotifier<ManagementStates> {
  ManagementStore({
    required IGetOperatorsInformations getOperatorsInformations,
    required ICreateNewpaymentMethod createNewPaymentMethod,
    required IGetAllPaymentMethods getAllPaymentMethods,
  })  : _getOperatorsInformations = getOperatorsInformations,
        _createNewPaymentMethod = createNewPaymentMethod,
        _getAllPaymentMethods = getAllPaymentMethods,
        super(ManagementInitialState());

  final IGetOperatorsInformations _getOperatorsInformations;
  final ICreateNewpaymentMethod _createNewPaymentMethod;
  final IGetAllPaymentMethods _getAllPaymentMethods;

  void resetManagementModuleState() {
    value = ManagementInitialState();
  }

  Future<void> getOperatorsInformations(String enterpriseId) async {
    value = ManagementLoadingState();
    final operatorsList =
        await _getOperatorsInformations(enterpriseId) as List<OperatorEntity>;
    if (operatorsList.isNotEmpty) {
      value = GetUsersListState(operators: operatorsList);
    } else {
      value = GetUsersListFailureState();
    }
  }

  Future<void> createNewPaymentMethod(
      String enterpriseId, PaymentMethodEntity paymentMethod) async {
    value = ManagementLoadingState();
    final newPaymentMethod =
        await _createNewPaymentMethod(enterpriseId, paymentMethod);
    if (newPaymentMethod != null) {
      value = ManagementInitialState();
    } else {
      value = PaymentMethodFailureState();
    }
  }

  Future<void> getAllPaymentMethods(String enterpriseId) async {
    value = ManagementLoadingState();
    final paymentMethods =
        await _getAllPaymentMethods(enterpriseId) as List<PaymentMethodEntity>;
    if (paymentMethods.isNotEmpty) {
      value = GetPaymentMethodsState(paymentMethods: paymentMethods);
    } else if (paymentMethods.isEmpty) {
      value = NoPaymentMethodsState();
    } else {
      value = PaymentMethodFailureState();
    }
  }
}
