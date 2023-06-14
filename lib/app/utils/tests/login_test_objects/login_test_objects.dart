import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';

import '../../../modules/user_module/domain/entities/operator_entity.dart';
import '../../../modules/user_module/infra/models/manager_model.dart';
import '../../../modules/user_module/infra/models/operator_model.dart';

class LoginTestObjects {
  static final Map<String, dynamic> newOperator = {
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'businessPosition': "operator",
  };
  static final Map<String, dynamic> newRepositoryOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'businessPosition': "operator",
  };
  static final Map<String, dynamic> modifiedUser = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 14,
    'operatorName': 'Josy Kelly',
    'operatorEmail': '',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': true,
    'businessPosition': "Admin",
  };
  static final Map<String, dynamic> testOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'junior@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'businessPosition': "operator",
  };
  static final Map<String, dynamic> deletionOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'businessPosition': "operator",
  };

  static final Map<String, dynamic> newManager = {
    'managerName': 'Júnior Silva',
    'managerEmail': 'junior@email.com',
    'managerPassword': '123junior456',
    'managerPhone': '35272307',
    'managerCpf': '00000033302',
    'managerRg': '342345642',
    'businessPosition': 'manager',
  };
  static final Map<String, dynamic> newRepositoryManager = {
    'managerId': 'q34u6hu1qeuyoio',
    'managerName': 'Júnior Silva',
    'managerEmail': 'junior@email.com',
    'managerPassword': '123junior456',
    'managerPhone': '35272307',
    'managerCpf': '00000033302',
    'managerRg': '342345642',
    'businessPosition': 'manager',
  };

  static final newOperatorModel = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: 'Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    businessPosition: "operator",
  );

  static final newManagerModel = ManagerModel(
    managerId: 'q34u6hu1qe3h52lhHKH2H5uyoio',
    managerName: 'Júnior Silva',
    managerEmail: 'junior@email.com',
    managerPassword: '123junior456',
    managerCode: '1234d8',
    managerPhone: '35272307',
    managerCpf: '00000033302',
    managerRg: '342345642',
    businessPosition: "operator",
  );
  static final newManagerEntity = ManagerEntity(
    managerId: 'q34u6hu1qe3h52lhHKH2H5uyoio',
    managerName: 'Júnior Silva',
    managerEmail: 'junior@email.com',
    managerPassword: '123junior456',
    managerCode: '1234d8',
    managerPhone: '35272307',
    managerCpf: '00000033302',
    managerRg: '342345642',
    businessPosition: "operator",
  );
  static final newOperatorEntity = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    businessPosition: "operator",
  );
  static final activeOperator = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'Now',
    operatorClosing: 'operatorClosing',
    operatorEnabled: true,
    businessPosition: "operator",
  );
}
