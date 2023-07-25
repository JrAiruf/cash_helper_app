import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/payment_methods/get_all_payment_methods/iget_all_payment_methods.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_events.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/payment_methods_list_bloc/payment_methods_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsListBloc extends Bloc<PaymentMethodsListEvents, PaymentMethodsListStates> {
  PaymentMethodsListBloc({required IGetAllPaymentMethods getAllPaymentMethods})
      : _getAllPaymentMethods = getAllPaymentMethods,
        super(PaymentMethodsListInitialState()) {
    on<GetAllPaymentMethodsEvent>(_mapGetAllPaymentMethodsEventToState);
  }
  final IGetAllPaymentMethods _getAllPaymentMethods;
  void _mapGetAllPaymentMethodsEventToState(GetAllPaymentMethodsEvent event, Emitter<PaymentMethodsListStates> state) async {
    state(PaymentMethodsListLoadingState());
    final paymentMethodsList = await _getAllPaymentMethods(event.enterpriseId)?.catchError((e) {
      state(PaymentMethodsListErrorState("Nenhuma método de Pagamento disponível"));
    }) as List<PaymentMethodEntity>;
    if (paymentMethodsList.isNotEmpty) {
      state(PaymentMethodsListSuccessState(paymentMethodsList));
    }
  }
}
