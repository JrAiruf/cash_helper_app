import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/login_module/external/login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/repository/login_repository_impl.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/repositories/management_repository_impl.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/repository/operator_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../modules/enterprise_module/external/enterprise_database_test.dart';

class EnterpriseDBMock extends Mock implements EnterpriseDatabaseMock {}

class EnterpriseRepoMock extends Mock implements EnterpriseRepository {}

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {}

class LoginRepositoryMock extends Mock implements LoginRepository {}

class AnnotationRepo extends Mock implements AnnotationRepositoryImpl {}

class ManagementRepoMock extends Mock implements ManagementRepositoryImpl {}
class ManagementDatabaseMock extends Mock implements ManagementDatabase {}

class OperatorRepositoryMock extends Mock implements OperatorRepositoryImpl {}

