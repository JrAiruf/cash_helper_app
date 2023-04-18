import '../../domain/contract/operator_usecases.dart';

class OperatorStore {
  OperatorStore({required OperatorUsecases usecases}) : _usecases = usecases;
  final OperatorUsecases _usecases;

  Future<void> changeOperatorEmail(String newEmail, String operatorCode,
      String operatorPassword, String collection) async {
        return await _usecases.changeOperatorEmail(newEmail, operatorCode, operatorPassword, collection);
      }
}
