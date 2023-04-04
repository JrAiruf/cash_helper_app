import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<LoginStates?> {
  LoginStore({required LoginUsecases usecases}) : _usecases = usecases, super(LoginInitialState());

final LoginUsecases _usecases;
bool loadingData = false;


Future<OperatorEntity?>? register(OperatorEntity newOperator, String collection) async {
final operatorEntity = await _usecases.register(newOperator, collection);
return operatorEntity;
}
Future<OperatorEntity?>? login(String? email, String? password,String? collection) async {
final operatorEntity = await _usecases.login(email, password, collection);
return operatorEntity;
}
Future<void>? getOperatorById(String operatorId,String collection) async {
  value = LoginLoadingState();
final operatorEntity = await _usecases.getOperatorById(operatorId, collection);
operatorEntity != null ?
value = LoginSuccessgState(operatorEntity: operatorEntity) :
value = LoginErrorState(message: "Usuário não encontrado");
}

Future<void> signOut() async {
  await _usecases.signOut();
  value = null;
}
}