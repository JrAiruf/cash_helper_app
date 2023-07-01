import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../annotations_module/external/data/application_annotations_database.dart';
import 'errors/payment_method_not_created.dart';
import 'errors/payment_methods_list_unnavailable.dart';
import 'errors/pendency_error.dart';
import 'errors/remove_payment_method_error.dart';
import 'errors/users_unavailable_error.dart';

class ManagementDatabase implements ApplicationManagementDatabase {
  ManagementDatabase({
    required FirebaseFirestore database,
    required ApplicationAnnotationDatabase annotationsDatabase,
  })  : _database = database,
        _annotationsDatabase = annotationsDatabase;

  final FirebaseFirestore _database;
  final ApplicationAnnotationDatabase _annotationsDatabase;
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
  Future<Map<String, dynamic>?>? generatePendency(String? enterpriseId, String? operatorId, String? annotationId) async {
    Map<String, dynamic> pendencyMap = {};
    try {
      final pendingAnnotation = await _annotationsDatabase.getAnnotationById(enterpriseId!, operatorId!, annotationId!);
      await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").add({
        "annotationId": annotationId,
        "pendencySaleTime": pendingAnnotation?["annotationSaleTime"],
        "pendencySaleDate": pendingAnnotation?["annotationSaleDate"],
        "pendencyPeriod": _getPendencyPeriod(pendingAnnotation?["annotationSaleTime"]),
        "operatorId": operatorId,
      }).then(
        (value) async {
          pendencyMap["pendencyId"] = value.id;
          value.update({"pendencyId": pendencyMap["pendencyId"]});
        },
      );
      if (pendencyMap.isNotEmpty) {
        return pendencyMap;
      } else {
        return null;
      }
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
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
