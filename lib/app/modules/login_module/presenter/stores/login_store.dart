import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<OperatorEntity?> {
  LoginStore({required LoginUsecases usecases}) : _usecases = usecases, super(OperatorEntity());

final LoginUsecases _usecases;
bool loadingData = false;


Future<OperatorEntity?>? register(OperatorEntity newOperator, String collection) async {
final operatorEntity = await _usecases.register(newOperator, collection);
value = operatorEntity!;
return value;
}
Future<OperatorEntity?>? login(String? email, String? password,String? collection) async {
final operatorEntity = await _usecases.login(email, password, collection);
value = operatorEntity!;
return value;
}
Future<OperatorEntity?>? getOperatorById(String operatorId,String collection) async {
final operatorEntity = await _usecases.getOperatorById(operatorId, collection);
value = operatorEntity!;
return value;
}

Future<void> signOut() async {
  await _usecases.signOut();
  value = null;
}
}