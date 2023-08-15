import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/pendency_occurrance_bloc/pendency_ocurrance_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/get_recent_activities_bloc/get_recent_activities_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'finish_pedency_bloc/finish_pendency_bloc.dart';
import 'payment_methods_list_bloc/payment_methods_list_bloc.dart';

class ManagementBlocBinds {
  static final binds = <Bind>[
    Bind<PaymentMethodsBloc>(
      (i) => PaymentMethodsBloc(
        createNewpaymentMethod: i(),
      ),
    ),
    Bind<PaymentMethodsListBloc>(
      (i) => PaymentMethodsListBloc(
        getAllPaymentMethods: i(),
      ),),
    Bind<GetRecentActivitiesBloc>(
      (i) => GetRecentActivitiesBloc(
        getAllOperators: i(),
        getAllAnnotations: i(),
        getAllPendencies: i()
      ),
    ),
    Bind<PendencyOcurranceBloc>(
      (i) => PendencyOcurranceBloc(
        getAllOperators: i(),
        getAllAnnotations: i(),
        getAllPendencies: i()
      ),
    ),
    Bind<FinishPendencyBloc>(
      (i) => FinishPendencyBloc(finishPendency: i(),
      ),
    ),
  ];
}
