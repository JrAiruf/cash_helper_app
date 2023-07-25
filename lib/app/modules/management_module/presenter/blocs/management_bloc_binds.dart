import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      ),
    ),
  ];
}
