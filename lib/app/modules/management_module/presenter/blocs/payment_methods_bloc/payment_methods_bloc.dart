import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_events.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodEvents, PaymentMethodStates> {
  PaymentMethodsBloc() : super(PaymentMethodInitialState()) {
    on((event, emit) => null);
  }
  void _mapEventToState()
}
