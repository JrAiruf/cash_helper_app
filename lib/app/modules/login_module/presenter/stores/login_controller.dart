import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<OperatorEntity> {
  LoginStore({required LoginUsecases usecases}) : _usecases = usecases, super(OperatorEntity());

final LoginUsecases _usecases;
bool loadingData = false;


Future<OperatorEntity?>? register(OperatorEntity newOperator, String collection) async {
  loadingData = true;
final newCashierOperator = await _usecases.register(newOperator, collection);
return newCashierOperator;
}
Future<OperatorEntity?>? login(String? email, String? password,String? collection) async {
  loadingData = true;
final loggedInCashierOperator = await _usecases.login(email, password, collection);
return loggedInCashierOperator;
}
Future<OperatorEntity?>? getOperatorById(String operatorId,String collection) async {
  loadingData = true;
final cashierOperator = await _usecases.getOperatorById(operatorId, collection);
return cashierOperator;
}

Future<void> signOut() async {
  await _usecases.signOut();
}
}