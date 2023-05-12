import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class ManagementStore extends ValueNotifier<ManagementStates> {
  ManagementStore({
    required IGetOperatorsInformations getOperatorsInformations,
    required ICreateNewpaymentMethod createNewPaymentMethod,
  })  : _getOperatorsInformations = getOperatorsInformations,
        _createNewPaymentMethod = createNewPaymentMethod,
        super(ManagementInitialState());

  final IGetOperatorsInformations _getOperatorsInformations;
  final ICreateNewpaymentMethod _createNewPaymentMethod;

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

  Future<void> createNewPaymentMethod(String enterpriseId, PaymentMethodEntity paymentMethod) async {
    value = ManagementLoadingState();
    final newPaymentMethod =
        await _createNewPaymentMethod(enterpriseId,paymentMethod);
    if (newPaymentMethod != null) {
      value = NewPaymentMethodState(paymentMethod: newPaymentMethod);
    } else {
      value = PaymentMethodFailureState();
    }
  }
}
