import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'errors/users_unavailable_error.dart';

class ManagementDatabase implements ApplicationManagementDatabase {
  ManagementDatabase({required FirebaseFirestore database})
      : _database = database;

  final FirebaseFirestore _database;
  var databaseOperatorsMapList = <Map<String, dynamic>>[];
  @override
  Future<List<Map<String, dynamic>>>? getOperatorInformations(
      String? enterpriseId) async {
    try {
      final operatorsCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection("operator")
          .get();
      if (operatorsCollection.docs.isNotEmpty) {
        final databaseMaps =
            operatorsCollection.docs.map((e) => e.data()).toList();
        databaseOperatorsMapList =
            databaseMaps.map((operatorMap) => operatorMap).toList();
        return databaseOperatorsMapList;
      } else {
        throw UsersUnavailableError(
            errorMessage: "Lista de usuários indisponível.");
      }
    } catch (e) {
      throw UsersUnavailableError(errorMessage: e.toString());
    }
  }
}
