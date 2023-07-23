import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_bloc.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EnterpriseBlocBinds {
  static final binds = <Bind>[
    Bind.lazySingleton<CreateEnterpriseBloc>(
          (i) => CreateEnterpriseBloc(
        createEnterprise: i(),
      ),
    ),Bind.lazySingleton<GetEnterpriseByCodeBloc>(
          (i) => GetEnterpriseByCodeBloc(
        getEnterpriseByCode: i(),
      ),
    ),
  ];
}