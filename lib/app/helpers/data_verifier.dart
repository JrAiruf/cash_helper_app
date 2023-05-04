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
  bool managerModelVerifier({required dynamic model}) => model.runtimeType == ManagerModel;
}
