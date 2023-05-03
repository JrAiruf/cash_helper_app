import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:mockito/mockito.dart';

class EnterpriseDBMock extends Mock implements ApplicationEnterpriseDatabase {}
class LoginRepositoryMock extends Mock implements LoginRepository {}
class AnnotationRepo extends Mock implements AnnotationRepositoryImpl {}