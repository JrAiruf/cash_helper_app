import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import '../../../../helpers/data_verifier.dart';
import '../../../user_module/infra/models/operator_model.dart';
import '../../domain/entities/pendency_entity.dart';
import '../../external/errors/pendency_error.dart';
import '../../external/errors/pendency_list_error.dart';
import '../adapters/pendency_adapter.dart';

class ManagementRepositoryImpl implements ManagementRepository {
  ManagementRepositoryImpl({
    required ManagementDatabase database,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _dataVerifier = dataVerifier;
  final ManagementDatabase _database;
  final DataVerifier _dataVerifier;

  @override
  Future<List<OperatorModel>>? getOperatorsInformations(String? enterpriseId) async {
    final operatorsModelList = <OperatorModel>[];
    try {
      if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
        final databaseOperatorsMapsList = await _database.getOperatorInformations(enterpriseId) ?? [];
        for (var operatorMap in databaseOperatorsMapsList) {
          final operatorModel = OperatorModel.fromMap(operatorMap);
          operatorsModelList.add(operatorModel);
        }
      }
    } catch (e) {
      return operatorsModelList;
    }
    return operatorsModelList;
  }

  @override
  Future<PaymentMethodModel>? createNewPaymentMethod(String? enterpriseId, PaymentMethodModel? paymentMethod) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final newPaymentMethod = await _database.createNewPaymentMethod(enterpriseId, paymentMethod?.toMap());
      return PaymentMethodModel.fromMap(newPaymentMethod ?? {});
    } else {
      return PaymentMethodModel();
    }
  }

  @override
  Future<List<PaymentMethodModel>>? getAllPaymentMethods(String? enterpriseId) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final paymentMethodMapList = await _database.getAllPaymentMethods(enterpriseId) as List;
      final paymentMethods = paymentMethodMapList.map((paymentMethodMap) => PaymentMethodModel.fromMap(paymentMethodMap)).toList();
      return paymentMethods;
    } else {
      return [];
    }
  }

  @override
  Future<void>? removePaymentMethod(String? enterpriseId, String? paymentMethodId) async {
    if (_dataVerifier.validateInputData(inputs: [
      enterpriseId,
      paymentMethodId,
    ])) {
      await _database.removePaymentMethod(enterpriseId, paymentMethodId);
    } else {
      return;
    }
  }

  @override
  Future<PendencyEntity?>? generatePendency(String? enterpriseId, String? operatorId, String? annotationId) async {
    try {
      final pendencyMap = await _database.generatePendency(enterpriseId, operatorId, annotationId);
      if (pendencyMap != null) {
        return PendencyAdapter.fromMap(pendencyMap);
      } else {
        throw PendencyError(errorMessage: "Pendência não criada");
      }
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  @override
  Future? getAllPendencies(String? enterpriseId) async {
    try {
      final pendenciesMapsList = await _database.getAllPendencies(enterpriseId);
      if (pendenciesMapsList != null) {
        return pendenciesMapsList.map((pendency) => PendencyAdapter.fromMap(pendency)).toList();
      } else {
        throw PendencyListError(errorMessage: "Sem Pendências No Sistema");
      }
    } catch (e) {
      throw PendencyListError(errorMessage: e.toString());
    }
  }

  @override
  Future<void>? finishPendency(String? enterpriseId, String? pendencyId) async {
    try {
      await _database.finishPendency(enterpriseId!, pendencyId!);
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  @override
  Future<PendencyEntity>? getPendencyById(String? enterpriseId, String? pendencyId) async {
    try {
      final pendencyMap = await _database.getPendencyById(enterpriseId!, pendencyId!);
      return PendencyAdapter.fromMap(pendencyMap ?? {});
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }
}
