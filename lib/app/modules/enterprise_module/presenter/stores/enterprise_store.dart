import 'package:cash_helper_app/app/modules/enterprise_module/presenter/stores/enterprise_states.dart';
import 'package:flutter/cupertino.dart';

class EnterpriseStore extends ValueNotifier<EnterpriseStates>{
  EnterpriseStore() : super(EnterpriseStoreInitialState());
}