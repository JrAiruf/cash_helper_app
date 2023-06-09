import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';

import '../modules/user_module/infra/models/manager_model.dart';

class DataVerifier {
  bool validateInputData({required List<Object?> inputs}) {
    late bool verified;
    for (var element in inputs) {
      if (element != null &&
          element.toString().isNotEmpty &&
          !element.toString().contains(" ")) {
        verified = true;
      } else {
        verified = false;
      }
    }
    return verified;
  }

  bool objectVerifier({required Map object}) =>
      object.isNotEmpty && !object.values.contains("");
  bool operatorModelVerifier({required dynamic model}) => model.runtimeType == OperatorModel;
  bool paymentMethodModelVerifier({required dynamic model}) => model.runtimeType == PaymentMethodModel;
  bool managerModelVerifier({required dynamic model}) => model.runtimeType == ManagerModel;
  bool operatorEntityVerifier({required dynamic entity}) => entity.runtimeType == OperatorEntity;
  bool paymentMethodEntityVerifier({required dynamic entity}) => entity.runtimeType == PaymentMethodModel;
  bool managerEntityVerifier({required dynamic entity}) => entity.runtimeType == ManagerEntity;
  bool operatorMapVerifier({required Map map}) => map.keys.contains("operatorId");
  bool managerMapVerifier({required Map map}) => map.keys.contains("managerId");
}
