import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:mockito/mockito.dart';

import '../modules/enterprise_module/external/enterprise_database_test.dart';

class EnterpriseDBMock extends Mock implements EnterpriseDatabaseMock {}
class LoginRepositoryMock extends Mock implements LoginRepository {}
class AnnotationRepo extends Mock implements AnnotationRepositoryImpl {}