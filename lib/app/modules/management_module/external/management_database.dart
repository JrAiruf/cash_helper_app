import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'errors/payment_method_not_created.dart';
import 'errors/payment_methods_list_unnavailable.dart';
import 'errors/pendency_error.dart';
import 'errors/pendency_list_error.dart';
import 'errors/remove_payment_method_error.dart';
import 'errors/users_unavailable_error.dart';

class ManagementDatabase implements ApplicationManagementDatabase {
  ManagementDatabase({
    required FirebaseFirestore database,
  }) : _database = database;

  final FirebaseFirestore _database;
  var databaseOperatorsMapList = <Map<String, dynamic>>[];
  @override
  Future<List<Map<String, dynamic>>>? getOperatorInformations(String? enterpriseId) async {
    try {
      final operatorsCollection = await _database.collection("enterprise").doc(enterpriseId).collection("operator").get();
      if (operatorsCollection.docs.isNotEmpty) {
        final databaseMaps = operatorsCollection.docs.map((e) => e.data()).toList();
        databaseOperatorsMapList = databaseMaps.map((operatorMap) => operatorMap).toList();
        return databaseOperatorsMapList;
      } else {
        throw UsersUnavailableError(errorMessage: "Lista de usuários indisponível.");
      }
    } catch (e) {
      throw UsersUnavailableError(errorMessage: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? createNewPaymentMethod(String? enterpriseId, Map<String, dynamic>? paymentMethod) async {
    try {
      if (enterpriseId!.isNotEmpty && paymentMethod!.isNotEmpty) {
        final paymentMethodsCollection = _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods");
        final newPaymentMethod = await paymentMethodsCollection.add(paymentMethod).then((value) async {
          final paymentMethodId = value.id;
          await value.update({"paymentMethodId": paymentMethodId});
          return value.get();
        });
        return newPaymentMethod.data() ?? {};
      } else {
        throw PaymentMethodNotCreated(errorMessage: "Erro ao criar método de pagamento");
      }
    } catch (e) {
      throw PaymentMethodNotCreated(errorMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>>? getAllPaymentMethods(String? enterpriseId) async {
    try {
      final paymentMethodsCollection = await _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods").get();
      if (enterpriseId!.isNotEmpty) {
        final paymentMethodsMapList = paymentMethodsCollection.docs.map((paymentMethodDocument) => paymentMethodDocument.data()).toList();
        return paymentMethodsMapList;
      } else {
        throw PaymentMethodsListUnnavailable(errorMessage: "Métodos de pagamento indisponíveis");
      }
    } catch (e) {
      throw PaymentMethodsListUnnavailable(errorMessage: e.toString());
    }
  }

  @override
  Future<void>? removePaymentMethod(String? enterpriseId, String? paymentMethodId) async {
    try {
      if (paymentMethodId != null) {
        final paymentMethodsCollection = _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods");
        await paymentMethodsCollection.doc(paymentMethodId).delete();
      } else {
        throw RemovePaymentMethodError(errorMessage: "Método não deletado");
      }
    } catch (e) {
      throw RemovePaymentMethodError(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Map<String, dynamic>?>? generatePendency(String? enterpriseId, Map<String, dynamic>? pendency) async {
    try {
      final pendenciesCollection = _database.collection("enterprise").doc(enterpriseId).collection("pendencies");
      await pendenciesCollection.add(pendency!).then((value) => value.update({"pendencyId": value.id}));
      final pendenciesMapsList = await pendenciesCollection.get();
      final createdPendency =
          pendenciesMapsList.docs.firstWhere((pendency) => pendency.data()["annotationId"] == pendency["annotationId"] && pendency.data()["operatorId"] == pendency["operatorId"]).data();
      if (createdPendency.isEmpty) {
        return {};
      }
      return createdPendency;
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllPendencies(String? enterpriseId) async {
    try {
      final pendenciesCollection = await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").get();
      final pendenciesList = pendenciesCollection.docs.map((e) => e.data()).toList();
      if (pendenciesList.isNotEmpty) {
        return pendenciesList;
      } else {
        throw PendencyListError(errorMessage: "Não existem pendências no momento");
      }
    } catch (e) {
      throw PendencyListError(errorMessage: e.toString());
    }
  }

  @override
  Future<void>? finishPendency(String? enterpriseId, String? pendencyId) async {
    try {
      await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").doc(pendencyId).update({"pendencyFinished": true});
    } on FirebaseException catch (e) {
      throw PendencyError(errorMessage: e.message ?? "");
    }
  }

  @override
  Future<Map<String, dynamic>>? getPendencyById(String enterpriseId, String pendencyId) async {
    try {
      final pendenciesCollection = await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").get();
      final selectedPendency = pendenciesCollection.docs.firstWhere((pendency) => pendency["pendencyId"] == pendencyId).data();
      return selectedPendency;
    } on FirebaseException catch (e) {
      throw PendencyError(errorMessage: e.message ?? "");
    }
  }

  String _getPendencyPeriod(String annotationSaleTime) {
    final annotationPeriod = annotationSaleTime.split(":").first;
    final timeValue = int.tryParse(annotationPeriod) ?? 0;
    if (timeValue >= 18) {
      return "Noite";
    } else if (timeValue >= 12 && timeValue < 18) {
      return "Tarde";
    } else {
      return "Manhã";
    }
  }
}
