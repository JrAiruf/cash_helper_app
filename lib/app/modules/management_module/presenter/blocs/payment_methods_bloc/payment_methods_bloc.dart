import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/payment_methods/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/payment_methods/get_all_payment_methods/iget_all_payment_methods.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_events.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_bloc/payment_method_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodEvents, PaymentMethodStates> {
  PaymentMethodsBloc({required ICreateNewpaymentMethod createNewpaymentMethod})
      : _createNewpaymentMethod = createNewpaymentMethod,
        super(PaymentMethodInitialState()) {
    on<CreateNewPaymentMethodEvent>(_mapCreateNewPaymentMethodEventToState);
    
  }

  final ICreateNewpaymentMethod _createNewpaymentMethod;
  void _mapCreateNewPaymentMethodEventToState(CreateNewPaymentMethodEvent event, Emitter<PaymentMethodStates> state) async {
    state(PaymentMethodLoadingState());
    final paymentMethod = await _createNewpaymentMethod(event.enterpriseId, event.paymentMethod)?.catchError((e) {
      state(PaymentMethodErrorState("Método de Pagamento não Criado"));
      return null;
    });
    if (paymentMethod != null) {
      state(PaymentMethodSuccessState(paymentMethod));
    }
  }
}
